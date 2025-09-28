from os import scandir, unlink, mkdir
from os.path import isdir, isfile
from random import shuffle

InputKeyValueSeparator = "\t"
OutputKeyValueSeparator = "\t"
MaxForCombiner = 10
NumOfMappers = 10
NumOfReducer = 10

class MRE_Exception(Exception):
    pass

class _TreeNode:
    def __init__(self, key, value):
        self.__key = key
        self.__values = [(key, value)]
        self.__left = None
        self.__right = None
        
    def _getValues(self):
        return self.__values
        
    def print(self):
        if not(self.__left is None):
            self.__left.print()
            
        print(str(self.__key) + " ==> " + str(self.__values))
            
        if not(self.__right is None):
            self.__right.print()
        
    def getKey(self):
        return self.__key
    
    def getLeft(self):
        return self.__left
    
    def getRight(self):
        return self.__right
    
    def setLeft(self, left):
        self.__left = left
        
    def setRight(self, right):
        self.__right = right
        
    def add(self, value):
        self.__values.append(value)
        
    def count(self):
        return len(self.__values)
    
    def getAndEmptyValues(self):
        v=[]
        for t in self.__values:
            v.append(t[1])
        self.__values = []
        return v
    
    def getAllValues(self, values):
        if not(self.__left is None):
            self.__left.getAllValues(values)
            
        for t in self.__values:
            values.append(t[1])

        if not(self.__right is None):
            self.__right.getAllValues(values)
        
    def __addOrUpdate(self, aTree, key, value, cmp):
        if aTree is None:
            aTree = _TreeNode(key, value)
        else:
            _tree = aTree
            buscar = True
            while buscar:
                c = cmp(key, _tree.getKey())
                if c == 0:
                    _tree.add((key, value))
                    buscar = False
                elif c < 0:
                    if(_tree.getLeft() is None):
                        _tree.setLeft(_TreeNode(key, value))
                        buscar = False
                    else:
                        _tree = _tree.getLeft()
                else:
                    if(_tree.getRight() is None):
                        _tree.setRight(_TreeNode(key, value))
                        buscar = False
                    else:
                        _tree = _tree.getRight()
        return aTree
    
    def collect(self, dic, fsort):
        # Cada nodo de este árbol representa una clave intermedia y su lista de valores asociados
        nodos = [self]
        while len(nodos) > 0:
            _tree = nodos[0]
            del(nodos[0])
            tmpTree = None        # a _TreeNode
            for t in _tree._getValues():
                tmpTree = self.__addOrUpdate(tmpTree, t[0], t[1], fsort)
            values = []
            tmpTree.getAllValues(values)
               
            dic[_tree.__key] = values
        
            if not(_tree.getLeft() is None):
                nodos.append(_tree.getLeft())
            
            if not(_tree.getRight() is None):
                nodos.append(_tree.getRight())

def fDefaultCmp(a, b):
    if a == b:
        return 0
    elif a < b:
        return -1
    else:
        return 1
    
class _NodeMapIterator:
    def __init__(self):
        self.__lines = []
    
    def add(self, line):
        self.__lines.append(line)
        
    def __iter__(self):
        self.__currentLine = 0
        return self
    
    def __next__(self):
        if self.__currentLine < len(self.__lines):
            n = self.__lines[self.__currentLine]
            self.__currentLine+= 1
            return n;
        else:
            raise StopIteration  
        
class _Cluster:
    def __init__(self, inputs):
        self.__nodes = []
        for i in range(NumOfMappers):
            self.__nodes.append(_NodeMapIterator())
        
        lines = []
        for i in inputs:
            files = [obj.name for obj in scandir(i[0]) if obj.is_file()]
            for f in files:
                file = open(i[0] + "/" + f, "r", encoding='latin-1')
                lines.append((i[1], file.readlines()))
                file.close()
        shuffle(lines)
         
        n=0; offset = 0
        for (f,lin) in lines:
            for l in lin:
                l = l[:-1]
                if(l.find(InputKeyValueSeparator) >= 0):
                    (k,v) = l.split(InputKeyValueSeparator, 1)
                else:
                    (k,v) = (offset, l)
                    offset+= len(l)
        
                self.__nodes[n].add((f, k, v))
                n+=1
                if n >= NumOfMappers:
                    n = 0
                
        self.__currentNode = 0
    
    def __next__(self):
        if self.__currentNode < NumOfMappers:
            n = self.__nodes[self.__currentNode]
            self.__currentNode+= 1
            return n;
        else:
            raise StopIteration        
        
class _Context:
    def __init__(self, _inputs, inter, output, fComb, params, fShuffleCmp, fSortCmp):
        self.__inputs = _inputs
        self.__stage = 0 #map
        self.__output = output
        self.__interDir = inter
        
        self.__interm = None      # a _TreeNode
        self.__result = []
        
        self.__params = params
        self.__fComb = fComb
        self.__fShuffleCmp = fShuffleCmp
        self.__fSortCmp = fSortCmp
        
    def __iter__(self):
        if(self.__stage == 0):
            return _Cluster(self.__inputs)
            #return _MapIterator(self.__inputs)
        elif(self.__stage == 3):
            _dict = {}
            if not (self.__interm is None):
                self.__interm.collect(_dict, self.__fSortCmp)
            return _Reduceterator(_dict)
        else:
            return None
        
    def createOrCleanDir(self, _dir):
        if (isdir(_dir)):
            files = [obj.name for obj in scandir(_dir) if obj.is_file()]
            for f in files: 
                fp = _dir + "/" + f
                if isfile(fp): 
                    unlink(fp) 
        else:
            mkdir(_dir)
            
    def finish(self):
        self.createOrCleanDir(self.__output)
        f = open(self.__output + "/output.txt", "w+")
        for t in self.__result:
            f.write(self.__flat(t[0]) + OutputKeyValueSeparator + self.__flat(t[1]) + "\n")
        f.close()
    
    def __flat(self, obj):
        if(type(obj) is tuple) or (type(obj) is list):
            res = ""
            for v in obj:
                res = res + self.__flat(v) + OutputKeyValueSeparator
            res = res[:-1]
        else:
            res = str(obj)
        
        return res        
    
    def __isIterable(self, obj):
        return type(obj) in [tuple, list, dict, set]
        
    def startReduce(self):
        self.__stage = 3 # reduce
        if (not(self.__interDir is None)) and (not (self.__interm is None)):
            # guardar a disco
            self.createOrCleanDir(self.__interDir)
            f = open(self.__interDir + "/output.txt", "w+")
            _dict = {}
            self.__interm.collect(_dict, self.__fSortCmp)
            
            for t in _dict.keys():
                for v in _dict[t]:
                    s = self.__flat(t) + "\t"
                    if(self.__isIterable(v)):
                        for vv in v:
                            s = s + self.__flat(vv)
                    else:
                        s = s + str(v) + "\t"
                    f.write(s + "\n")
            f.close()
        
    def __addOrUpdateKey(self, aTree, key, value, cmp):
        if aTree is None:
            aTree = _TreeNode(key, value)
        else:
            buscar = True
            _tree = aTree
            while buscar:
                c = cmp(key, _tree.getKey())
                if c == 0:
                    _tree.add((key, value))
                    if(_tree.count() > MaxForCombiner):
                        self.__executeCombiner(_tree)
                    buscar = False
                    
                elif c < 0:
                    if(_tree.getLeft() is None):
                        _tree.setLeft( _TreeNode(key, value) )
                        buscar = False
                    else:
                        _tree = _tree.getLeft()
                else:
                    if(_tree.getRight() is None):
                        _tree.setRight( _TreeNode(key, value) )
                        buscar = False
                    else:
                        _tree = _tree.getRight()
        return aTree
    
    def write(self, k, v):
        if (self.__stage == 0):
            # map            
            self.__interm = self.__addOrUpdateKey(self.__interm, k, v, self.__fShuffleCmp)
            
        elif (self.__stage == 3):
            # reduce
            if (type(k) == ValuesIterator) or (type(v) == ValuesIterator):
                raise MRE_Exception("No es posible escribir la lista de valores. Recorrala con un for y escriba los elementos por separado; o use el método next() si sabe que la lista de values solo tiene un elemento.")
            self.__result.append((k, v))
            
    def __getitem__(self, index):
        return self.__params[index]
    
    def __executeCombiner(self, tree):
        if(self.__fComb is None):
            return
        
        values = tree.getAndEmptyValues()

        self.__fComb(tree.getKey(), values, self)
        
    
class _MapIterator:
    def __init__(self, _inputs):
        self.__inputs = _inputs
        self.__currentInput = 0
        self.__initInput(self.__currentInput)
        
    def __initInput(self, ci):
        if ci < len(self.__inputs):
            self.__currentDir = self.__inputs[ci][0]
            self.__currentFuncMap = self.__inputs[ci][1]
            if(self.__currentFuncMap is None):
                self.__currentInput = self.__currentInput + 1
                return self.__initInput(self.__currentInput)
            else:
                self.__files = [obj.name for obj in scandir(self.__currentDir) if obj.is_file()]
        else:
            self.__files = []
        self.__currentFile = 0        
        self.__initFile(self.__currentFile)
        
    def __initFile(self, cf):
        if cf < len(self.__files):
            f = open(self.__currentDir + "/" + self.__files[cf], "r", encoding='latin-1')
            self.__lines = f.readlines()
            shuffle(self.__lines)
            f.close()
        else:
            self.__lines = []
        self.__currentLine = 0 
        self.__offset = 0
        
    def __next__(self):
        if(self.__currentInput >= len(self.__inputs)):
            raise StopIteration
			
        elif(self.__currentFile >= len(self.__files)):
            self.__currentInput = self.__currentInput + 1
            self.__initInput(self.__currentInput)
            return self.__next__()
            
        elif (self.__currentLine >= len(self.__lines)):
            self.__currentFile = self.__currentFile + 1
            self.__initFile(self.__currentFile)
            return self.__next__()
            
        else:
            line = self.__lines[self.__currentLine]
            line = line[:-1]
            if(line.find(InputKeyValueSeparator) >= 0):
                (k,v) = line.split(InputKeyValueSeparator, 1)
            else:
                (k,v) = (self.__offset, line)
            self.__offset = self.__offset + len(self.__lines[self.__currentLine])
            self.__currentLine = self.__currentLine + 1
            return (self.__currentFuncMap, k,v)

class ValuesIterator:
        def __init__(self, l):
            self.__values = l
            self.__currentValue = 0
            self.__firstTime = True
            
        def __iter__(self):
            if (self.__firstTime):
                self.__firstTime = False
                return self
            else:
                raise MRE_Exception("No es posible recorrer la lista de valores más de una vez. Deberá hacer todas las operaciones dentro de un único for.")
    
        def __next__(self):
            if self.__currentValue >= len(self.__values):
                raise StopIteration
            else:
                self.__currentValue = self.__currentValue + 1
                return self.__values[self.__currentValue - 1]
            
        def next(self):
            try:
                return self.__next__()
            except StopIteration:
                return None
            
class _Reduceterator:
    def __init__(self, _dict):
        self.__dict = _dict
        self.__keys = list(self.__dict.keys())
        self.__keys.sort()
        self.__currentKey = 0
        
    def __next__(self):
        if(self.__currentKey >= len(self.__keys)):
            raise StopIteration
        else:
            k = self.__keys[self.__currentKey]
            v = self.__dict[k]
            self.__currentKey = self.__currentKey + 1
            return (k, ValuesIterator(v))
    
class Job:
    def __init__(self, _input, output, fMap, fReduce):
        self.__inputs = [(_input, fMap)]
        self.__fReduce = fReduce
        self.__fComb = None
        self.__output = output
        self.__params = None
        self.__fShuffleCmp = fDefaultCmp
        self.__fSortCmp = fDefaultCmp
        self.__interDir = None
        
    def setNumReducers(self, n):
        self.__numReducers = n
        
    def setIntermDir(self, d):
        self.__interDir = d
        
    def setShuffleCmp(self, fShuffleCmp):
        self.__fShuffleCmp = fShuffleCmp
        
    def setSortCmp(self, fSortCmp):
        self.__fSortCmp = fSortCmp
        
    def setParams(self, params):
        self.__params = params
        
    def setCombiner(self, fComb):
        self.__fComb = fComb
        print("Combiner seteado")
        
    def __map(self, context):
        for n in context:
            for (f, k, v) in n:
                f(k, v, context)
            
    def __shuffle(self, context):
        pass
            
    def __sort(self, context):
        pass
    
    def __reduce(self, context):
        context.startReduce()
        for (k,vs) in context:
            self.__fReduce(k, vs, context)
        
    def waitForCompletion(self):
        context = _Context(self.__inputs, self.__interDir, self.__output, self.__fComb, self.__params, self.__fShuffleCmp, self.__fSortCmp)
        self.__map(context)
        self.__shuffle(context)
        self.__sort(context)
        self.__reduce(context)
        context.finish()
        
        return True
        
    def addInputPath(self, _input, fmap):
        self.__inputs.append((_input, fmap))
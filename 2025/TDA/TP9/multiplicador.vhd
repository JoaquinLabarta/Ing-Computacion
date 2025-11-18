library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplicador is
    port (
        CLK    : in  BIT;
        CLR    : in  BIT;
        STB    : in  BIT;
        A, B   : in  BIT_VECTOR(3 downto 0);
        Result : out BIT_VECTOR(7 downto 0);
        Done   : out BIT	   
    );
end multiplicador;

architecture Behavioral of multiplicador is

    -- Señales para las conexiones internas
    signal SRB, SRAA, ACC    : BIT_VECTOR(7 downto 0);
    signal ADD_OUT          : BIT_VECTOR(7 downto 0);
    signal FSM_State        : BIT_VECTOR(2 downto 0); 
    signal LSB              : BIT; 
    signal Stop             : BIT;		  
	
	-- Señales de control generadas por la FSM
    signal Shift, Add, Init : BIT;
	
	-- A y B extendidos para ingresar al multiplicador
	signal A_ext, B_ext     : BIT_VECTOR(7 downto 0);	 
	

    -- Instancias de los componentes
    component Adder8
        port (
			A, B : in  BIT_VECTOR(7 downto 0);
		  	Cin: in BIT;
            Sum  : out BIT_VECTOR(7 downto 0)
        );
    end component;

    component ShiftN
        port (
            CLK  : in  BIT;
            CLR  : in  BIT;
            DIR  : in  BIT;
            LD   : in  BIT;	   
			SH   : in BIT;
            D    : in  BIT_VECTOR(7 downto 0);
            Q    : out BIT_VECTOR(7 downto 0)
        );
    end component;

    component Controller
        port (
            CLK       : in  BIT;
            STB       : in  BIT;
            LSB       : in  BIT;
            Stop      : in  BIT;
            Init, Shift, Add, Done : out BIT
        );
    end component;

    

begin	  
	-- Extension de A y B a 8 bits
	A_ext <= "0000" & A;
    B_ext <= "0000" & B;

    -- Adder: ACC + SRB
    U1: Adder8
        port map (
            A => ACC,
            B => SRB,
            Sum => ADD_OUT,
			Cin => '0'
        );
		
		
    -- Shift register de B
    SRB_Shift: ShiftN
        port map (
            CLK => CLK,
            CLR => CLR,
            DIR => '1', -- Desplazamiento a la izquierda	
			SH => Shift,
            LD  => Init,				   
            D   => B_ext, 
            Q   => SRB
        );

    -- Shift register de A
    SRA_Shift: ShiftN
        port map (
            CLK => CLK,
            CLR => CLR,
            DIR => '0', -- Desplazamiento a la derecha	 
			SH => Shift,
            LD  => Init,
            D   => A_ext,
            Q   => SRAA
        );
		
		
    -- Instancia de controller para maquina de estados del multiplicador
    FSM_Controller: Controller
        port map (
            CLK => CLK,
            STB => STB,
            LSB => SRAA(0), -- LSB de SRA
            Stop => Stop,		
			Init => Init,
            Shift => Shift,
            Add => Add,
            Done => Done
        );	 

    -- Logica del acumulador: Limpieza o carga
    process(CLK)
    begin
        if (CLK'event and CLK = '1') then
            if CLR = '1' then
                ACC <= (others => '0');	 --Limpieza
            elsif Init = '1' then
                ACC <= (others => '0');	 -- Limpieza
            elsif Add = '1' then
                ACC <= ADD_OUT; -- Carga del resultado
            end if;
        end if;
    end process;

    -- Finalizacion 
    Stop <= '1' when SRAA = "00000000" else '0';

    -- Asignación del resultado a la senal de OUT
    Result <= ACC;

end Behavioral;

  




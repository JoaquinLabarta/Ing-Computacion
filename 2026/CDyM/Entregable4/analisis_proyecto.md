# Análisis y justificación del proyecto — TP4 Control LED RGB

Documento orientado a la **exposición presencial** y a la defensa del trabajo. El foco está en **cumplir la consigna** y en el **por qué** de cada decisión, no en el detalle de implementación del código.

---

## 1. Objetivo según la consigna

El TP pide controlar un **LED RGB** de forma que:

- Se **encienda y apague periódicamente** con un efecto de **desvanecimiento**.
- El **ritmo** (período total *T*) lo fije la **luz ambiente** medida con un LDR.
- El **color** lo elija el usuario por **interfaz serie**.

Eso implica coordinar **hardware** (conexionado en Proteus / kit), **periféricos del MCU** (PWM, ADC, UART, timers) y **lógica de aplicación** (desvanecimiento + comandos) sin bloquear el sistema. Todo el razonamiento del proyecto gira en torno a satisfacer esos tres ejes de forma simultánea y estable.

---



## 2. Cumplimiento del esquema electrónico (Proteus)

La consigna fija el conexionado. No es arbitrario: cada elección condiciona cómo hay que programar el firmware.

### 2.1 LED RGB de ánodo común en PB5 (R), PB2 (G) y PB1 (B)


| Requisito de la consigna      | Cómo se cumple                                                   | Por qué importa                                                                        |
| ----------------------------- | ---------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| Modelo RGBLED-CA, ánodo común | LED conectado con ánodo a Vcc; cátodos a PB5, PB2, PB1 vía 220 Ω | Con ánodo común el LED **enciende con nivel bajo** en el pin del MCU                   |
| Resistencias de 220 Ω         | Una por canal, limitación de corriente                           | Protege el LED y cumple el esquema pedido para simulación y kit                        |
| PB5 = R, PB2 = G, PB1 = B     | Pines configurados como salida en el firmware                    | Respeta exactamente la asignación del TP; cualquier otro pin invalidaría la corrección |


**Justificación central:** el hecho de que sea **ánodo común** no es un detalle menor. Obliga a invertir la lógica del PWM respecto de un cátodo común: lo que el usuario entiende como “más intensidad” debe corresponder a un mayor duty cycle **eléctrico** hacia GND. Por eso se eligió **PWM en modo invertido** en hardware y la misma convención en el PWM por software del rojo: así **0 = apagado** y **255 = máximo**, alineado con lo que pide el comando `SET_COLOR`.

### 2.2 LDR en PC3 con divisor resistivo (100 kΩ a GND)


| Requisito de la consigna | Cómo se cumple                                   | Por qué importa                                                                               |
| ------------------------ | ------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| Sensor en PC3            | Entrada analógica, pull-up interno deshabilitado | El pull-up alteraría el divisor; la medición debe depender solo del LDR y la resistencia fija |
| Divisor con 100 kΩ a GND | Tensión en PC3 varía con la iluminación          | Convierte una magnitud física (luz) en una tensión que el ADC puede cuantizar                 |
| Canal 3 del ADC          | Lectura en ADC3 / PC3                            | La consigna lo exige explícitamente; acota el registro `ADMUX` y la validación en Proteus     |


**Justificación central:** el LDR no entrega un valor de “segundos” directamente. El firmware debe **interpretar** la lectura. La consigna solo fija dos puntos (mínima luz → 6 s, máxima luz → 3 s), por lo que se adoptó un **mapeo lineal** entre el valor ADC y el período *T*: es la interpolación más simple, **comprobable en la demo** (tapar el LDR → *T* crece; iluminarlo → *T* baja) y no introduce supuestos extra no pedidos.

### 2.3 Terminal serie en UART0 a 9600 bps, 8N1


| Requisito de la consigna | Cómo se cumple                                            | Por qué importa                                                       |
| ------------------------ | --------------------------------------------------------- | --------------------------------------------------------------------- |
| UART0 del MCU            | Comunicación con la PC / terminal virtual de Proteus      | Canal único de configuración del color por el usuario                 |
| 9600 bps, 8N1            | `UBRR` calculado para 16 MHz; 8 bits, sin paridad, 1 stop | Coincide con la configuración estándar del terminal virtual del curso |


**Justificación central:** la UART no puede bloquear el desvanecimiento. Si la recepción o transmisión retuviera al CPU con esperas activas, el efecto de fade dejaría de ser regular. Por eso se usa **UART por interrupciones** con buffers: la ISR solo guarda o envía bytes; el parseo del comando ocurre en el loop principal, cuando el sistema puede dedicar tiempo sin comprometer la base de 1 ms del desvanecimiento.

---



## 3. Cumplimiento del software bare metal (AVR-GCC)



### 3.1 Tres señales PWM: > 30 Hz, 8 bits, TIMER1 en PB1/PB2 y PWM por software en PB5


| Requisito de la consigna               | Cómo se cumple                                 | Por qué se eligió ese enfoque                                                                 |
| -------------------------------------- | ---------------------------------------------- | --------------------------------------------------------------------------------------------- |
| Frecuencia > 30 Hz en los tres canales | Verde/azul ≈ 490 Hz; rojo ≈ 244 Hz             | Superan ampliamente el mínimo; evita parpadeo visible por efecto strobo en la intensidad      |
| Resolución de 8 bits (0–255)           | 256 niveles en los tres canales                | Coincide con el rango del comando `SET_COLOR` y con el escalado del desvanecimiento           |
| PB1 y PB2 con salidas de TIMER1        | PWM por hardware en OC1A (azul) y OC1B (verde) | Es lo que indica la consigna: aprovechar los comparadores del timer ya cableados a esos pines |
| PB5 con PWM por software               | TIMER0 genera los flancos por interrupción     | **PB5 no tiene salida OC** en el ATmega328P; la consigna obliga a software en ese pin         |


**Por qué PWM fase correcta (verde y azul):** entre los modos del timer, la fase correcta de 8 bits permite alcanzar **0 % y 100 % de duty cycle reales** junto con el modo invertido. Con ánodo común eso se traduce en apagado total y encendido total sin “suelos” o “techos” incorrectos. Fast PWM hubiera complicado los extremos con el LED invertido.

**Por qué modo invertido:** porque el hardware enciende con nivel bajo. Sin invertir, un OCR alto significaría justo lo contrario de lo que el usuario espera al mandar `255`.

**Por qué frecuencias distintas entre canales:** la consigna **no exige** la misma frecuencia en R, G y B; solo pide superar 30 Hz. Se priorizó una configuración **clara y robusta** en cada timer disponible, con buenos extremos de PWM, en lugar de forzar una frecuencia idéntica a costa de más complejidad.

**Por qué TIMER0 para el rojo:** es el timer libre más adecuado para contar 256 posiciones por ciclo y ubicar el flanco de apagado con `OCR0A`, emulando un PWM de 8 bits. Los casos 0 y 255 se tratan aparte porque representan 0 % y 100 % sin ambigüedad.

---



### 3.2 Selección de color por terminal: `SET_COLOR=R,G,B`


| Requisito de la consigna           | Cómo se cumple                                                 | Por qué se eligió ese enfoque                                                          |
| ---------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| Proporción de cada color por serie | Comando `SET_COLOR=R,G,B` con valores 0–255                    | Formato explícito, alineado con la resolución PWM de 8 bits                            |
| Ejemplo con `\r\n`                 | Se aceptan fin de línea `\r` y/o `\n`                          | Compatibilidad con distintos terminales seriales y con Proteus                         |
| Color resultante en el LED         | Las tres componentes definen el color base del desvanecimiento | El usuario controla el tono; el firmware controla cuánto brilla en cada fase del ciclo |


**Por qué validar estrictamente el comando:** un valor fuera de rango o un formato incorrecto no debe corromper el estado del LED. Se responde con mensajes de error por UART para que la demo sea **verificable** ante el docente.

**Por qué el cambio de color no reinicia el ciclo de desvanecimiento:** la consigna pide que el LED siga encendiéndose y apagándose periódicamente; cortar o resetear el fade en cada comando rompería la experiencia. Al cambiar color se **conserva la fase actual** (subida, máximo, bajada o apagado) y solo se actualiza la base RGB, manteniendo el nivel de intensidad del momento.

**Por qué escalar R, G y B con el mismo factor durante el fade:** el desvanecimiento debe modificar la **intensidad global**, no el tono. Si cada color bajara distinto, el color cambiaría durante la rampa; multiplicar las tres componentes por el mismo nivel preserva la proporción elegida por el usuario.

---



### 3.3 Efecto de desvanecimiento periódico (figura de la consigna)

La figura del TP define la forma de la intensidad en el tiempo:

```
Intensidad
    ^
Max |     +-------+
    |    /         \
    |   /           \
  0 +--+-------------+--------> t
       1s  1s  1s      T-3s
            ←── T ──→
```


| Requisito de la consigna | Cómo se cumple                    | Por qué se eligió ese enfoque                                       |
| ------------------------ | --------------------------------- | ------------------------------------------------------------------- |
| Subida gradual 1 s       | Rampa lineal 0 → 255 en 1000 ms   | Reproduce la primera rampa de la figura                             |
| Meseta al máximo 1 s     | Intensidad 255 sostenida 1000 ms  | Corresponde al tramo “Max” del diagrama                             |
| Bajada gradual 1 s       | Rampa lineal 255 → 0 en 1000 ms   | Simetría con la subida, como pide el enunciado                      |
| Período total *T*        | 3 s activos + *(T − 3 s)* apagado | Los tres segundos de rampas/meseta son fijos; el resto completa *T* |


**Por qué una máquina de estados finitos (MEF):** el comportamiento tiene **fases bien diferenciadas** (subida, máximo, bajada, apagado) con duraciones distintas según *T*. Una MEF modela eso de forma directa y evita `_delay_ms()` u otras esperas bloqueantes que impedirían atender UART y ADC en paralelo.

**Por qué el tramo apagado dura *T − 3 s*:** subida, máximo y bajada ocupan exactamente 3 s. El período total lo completa el tiempo con LED apagado. Es la única forma de respetar simultáneamente la figura fija (3 s de actividad con forma definida) y el *T* variable del LDR.

**Qué ocurre cuando *T = 3 s* (máxima iluminación):** no queda tiempo de meseta apagada; al terminar la bajada **arranca de inmediato** la siguiente subida. Es el comportamiento límite coherente con la definición: no se inventa un tiempo negativo de apagado.

**Por qué no se usa corrección gamma:** la consigna habla de **proporciones PWM** y de intensidad en el diagrama temporal, no de igualar la percepción humana de brillo. Aplicar gamma alteraría las relaciones eléctricas pedidas por `SET_COLOR` sin que el TP lo requiera.

---

### 3.4 Período *T* del parpadeo según el LDR (ADC canal 3): 6 s ↔ 3 s


| Requisito de la consigna         | Cómo se cumple                               | Por qué se eligió ese enfoque                                                    |
| -------------------------------- | -------------------------------------------- | -------------------------------------------------------------------------------- |
| ADC canal 3                      | Lectura del LDR en PC3/ADC3                  | Cumple el enunciado y el esquema de Proteus                                      |
| *T* = 6 s con mínima luz         | ADC mínimo → período 6000 ms                 | Extremo inferior pedido: parpadeo más lento en oscuridad                         |
| *T* = 3 s con máxima iluminación | ADC máximo → período 3000 ms                 | Extremo superior pedido: parpadeo más rápido con mucha luz                       |
| Relación entre ambos extremos    | Interpolación lineal entre 6000 ms y 3000 ms | La consigna solo fija dos puntos; lo más defendible es un mapeo lineal y medible |


**Por qué leer el ADC cada 100 ms y no en cada milisegundo:** la luz ambiente varía lentamente; 10 lecturas por segundo son suficientes para una demo fluida y dejan casi todo el CPU disponible para el fade y la UART.

**Por qué ADC por polling y no por interrupción:** cada conversión dura del orden de **100 µs** y ocurre cada 100 ms. El bloqueo es despreciable frente al intervalo; una ISR de ADC agregaría complejidad sin beneficio real para este TP.

**Por qué el nuevo *T* se aplica al ciclo siguiente:** si *T* cambiara a mitad de un desvanecimiento, el usuario vería un salto brusco en la duración de la fase apagada o en el ritmo general. Diferir el cambio al **próximo ciclo** mantiene la continuidad visual y es coherente con la naturaleza lenta del sensor.

---

## 4. Metodología de diseño (herramientas y criterios generales)

Esta sección responde a lo que la consigna pide explicitar en la evaluación: *razonamientos, herramientas, tareas del MCU y respuestas en tiempo y forma*.

### 4.1 Enfoque bare metal con AVR-GCC

**Por qué:** el TP exige firmware sin sistema operativo ni frameworks. AVR-GCC es la toolchain del curso para el ATmega del kit y de Proteus; permite acceso directo a registros, interrupciones y temporización determinista.

**Herramientas:** AVR-GCC, Proteus 8.12 (simulación y debugger), terminal serial 9600 8N1, kit ATmega328P a 16 MHz.

### 4.2 Separación entre “tiempo real” y “tareas de fondo”

El MCU debe hacer **varias cosas a la vez** sin que una afecte a las otras:


| Tarea                        | Plazo               | Por qué no puede bloquearse                                                |
| ---------------------------- | ------------------- | -------------------------------------------------------------------------- |
| PWM rojo, verde, azul        | Continuo, > 30 Hz   | El ojo integra la luz; cualquier jitter visible arruina el color y el fade |
| Avance del desvanecimiento   | Cada 1 ms           | La figura del TP está definida en segundos con resolución de rampa         |
| Recepción / transmisión UART | Cuando llegan datos | El usuario debe poder cambiar el color en cualquier momento                |
| Lectura del LDR              | Cada 100 ms         | Ajusta *T* sin necesidad de alta frecuencia                                |


**Criterio adoptado:** las ISRs hacen lo mínimo (PWM, tick de 1 ms, bytes UART). La MEF del fade, el parser de comandos y la lectura del ADC corren en el **loop principal**, sincronizados por eventos. Así se evita anidar retardos bloqueantes y se cumple el comportamiento temporal del TP.

### 4.3 Por qué TIMER2 como base de 1 ms

TIMER0 y TIMER1 ya cumplen roles impuestos por la consigna (PWM rojo por software y PWM verde/azul por hardware). Queda TIMER2 como **único timer libre** para generar una referencia estable de 1 ms, independiente de las frecuencias PWM. Sin esa base, el desvanecimiento dependería de conteos imprecisos o de delays.

### 4.4 Descomposición del programa (sin entrar en implementación)

La división en módulos responde a **responsabilidades del enunciado**, no a un gusto estético:


| Parte del programa                | Responsabilidad respecto de la consigna                           |
| --------------------------------- | ----------------------------------------------------------------- |
| Configuración de pines y arranque | Conectar firmware con el esquema Proteus (PB5/PB2/PB1, PC3, UART) |
| PWM                               | Requisito 1: tres señales 8 bits, > 30 Hz, software en PB5        |
| Control de desvanecimiento        | Requisito 3: forma temporal de la intensidad                      |
| Sensor de luz                     | Requisito 4: *T* entre 6 s y 3 s según ADC3                       |
| UART y comandos                   | Requisito 2: color por terminal + feedback al usuario             |
| Timer de 1 ms                     | Soporte temporal para la MEF sin bloqueos                         |


**Por qué modular:** cada requisito del TP se puede **demostrar y explicar por separado** en la mesa (mostrar PWM en un pin, mostrar ADC al tapar el LDR, mostrar comando UART, mostrar transición de estados del fade).

## 5. Mapa de verificación para la demo (consigna + debugger Proteus)

La evaluación pide demostrar funcionamiento, simulación, conexionado y verificación temporal. Propuesta de guion alineada con la consigna:


| Qué muestra la consigna   | Qué demostrar                                                 | Qué justificar oralmente                                         |
| ------------------------- | ------------------------------------------------------------- | ---------------------------------------------------------------- |
| Esquema Proteus           | LED en PB5/PB2/PB1, LDR en PC3, UART 9600 8N1                 | El ánodo común define la lógica invertida del PWM                |
| PWM 8 bits, > 30 Hz       | Forma de onda o cambio visible al variar `SET_COLOR`          | Hardware en PB1/PB2; software en PB5 porque no hay OC            |
| Comando serie             | `SET_COLOR=0,255,255` y casos erróneos                        | Validación para no romper el estado; color base vs nivel de fade |
| Figura de desvanecimiento | Subida 1 s, meseta 1 s, bajada 1 s, pausa hasta completar *T* | MEF elegida porque hay fases distintas; apagado = *T* − 3 s      |
| LDR → *T* 6 s…3 s         | Tapar / iluminar sensor; medir *T* con cronómetro o debugger  | Mapeo lineal entre extremos; cambio de *T* al ciclo siguiente    |
| Tareas concurrentes       | Fade continuo mientras se envían comandos                     | UART y ADC no bloquean porque no usan delays globales            |



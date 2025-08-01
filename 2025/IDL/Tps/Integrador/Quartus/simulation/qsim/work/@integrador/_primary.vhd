library verilog;
use verilog.vl_types.all;
entity Integrador is
    port(
        PAUSE           : out    vl_logic;
        b2              : in     vl_logic;
        b1              : in     vl_logic;
        b0              : in     vl_logic;
        ERROR           : out    vl_logic;
        UP_DOWN         : in     vl_logic;
        Q2              : out    vl_logic;
        RECARGAR        : in     vl_logic;
        CLOCK           : in     vl_logic;
        FIN             : out    vl_logic;
        Q1              : out    vl_logic;
        Q0              : out    vl_logic;
        postRegSumador  : out    vl_logic_vector(11 downto 0);
        LOADI           : in     vl_logic;
        DATA            : inout  vl_logic_vector(11 downto 0);
        LOADF           : in     vl_logic;
        CONTINUAR       : in     vl_logic;
        START           : in     vl_logic;
        CYOUT           : out    vl_logic;
        postmux         : out    vl_logic_vector(11 downto 0);
        salidaFinal     : out    vl_logic_vector(11 downto 0);
        salidaInicial   : out    vl_logic_vector(11 downto 0)
    );
end Integrador;

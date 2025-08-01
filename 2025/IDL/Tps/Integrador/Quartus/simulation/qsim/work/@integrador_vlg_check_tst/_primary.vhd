library verilog;
use verilog.vl_types.all;
entity Integrador_vlg_check_tst is
    port(
        CYOUT           : in     vl_logic;
        DATA            : in     vl_logic_vector(11 downto 0);
        ERROR           : in     vl_logic;
        FIN             : in     vl_logic;
        PAUSE           : in     vl_logic;
        postmux         : in     vl_logic_vector(11 downto 0);
        postRegSumador  : in     vl_logic_vector(11 downto 0);
        Q0              : in     vl_logic;
        Q1              : in     vl_logic;
        Q2              : in     vl_logic;
        salidaFinal     : in     vl_logic_vector(11 downto 0);
        salidaInicial   : in     vl_logic_vector(11 downto 0);
        sampler_rx      : in     vl_logic
    );
end Integrador_vlg_check_tst;

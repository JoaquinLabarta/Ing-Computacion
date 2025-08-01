library verilog;
use verilog.vl_types.all;
entity probandoERROR is
    port(
        ERROR           : out    vl_logic;
        Q2              : in     vl_logic;
        Q1              : in     vl_logic;
        Q0              : in     vl_logic;
        valorFinal      : in     vl_logic_vector(11 downto 0);
        valorInicial    : in     vl_logic_vector(11 downto 0);
        updown          : in     vl_logic
    );
end probandoERROR;

library verilog;
use verilog.vl_types.all;
entity probandoERROR_vlg_sample_tst is
    port(
        Q0              : in     vl_logic;
        Q1              : in     vl_logic;
        Q2              : in     vl_logic;
        updown          : in     vl_logic;
        valorFinal      : in     vl_logic_vector(11 downto 0);
        valorInicial    : in     vl_logic_vector(11 downto 0);
        sampler_tx      : out    vl_logic
    );
end probandoERROR_vlg_sample_tst;

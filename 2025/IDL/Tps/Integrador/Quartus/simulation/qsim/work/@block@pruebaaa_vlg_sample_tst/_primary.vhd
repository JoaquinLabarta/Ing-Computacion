library verilog;
use verilog.vl_types.all;
entity BlockPruebaaa_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(11 downto 0);
        C               : in     vl_logic;
        DATA            : in     vl_logic_vector(11 downto 0);
        Z               : in     vl_logic_vector(11 downto 0);
        sampler_tx      : out    vl_logic
    );
end BlockPruebaaa_vlg_sample_tst;

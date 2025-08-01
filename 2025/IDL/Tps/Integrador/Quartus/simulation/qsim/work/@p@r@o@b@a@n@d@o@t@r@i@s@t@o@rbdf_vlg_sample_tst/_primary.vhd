library verilog;
use verilog.vl_types.all;
entity PROBANDOTRISTORbdf_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(11 downto 0);
        C               : in     vl_logic;
        DATA            : in     vl_logic_vector(11 downto 0);
        LOAD            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end PROBANDOTRISTORbdf_vlg_sample_tst;

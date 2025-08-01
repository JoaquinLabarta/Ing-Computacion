library verilog;
use verilog.vl_types.all;
entity Tristate12_vlg_sample_tst is
    port(
        DATA            : in     vl_logic_vector(11 downto 0);
        enable          : in     vl_logic;
        I               : in     vl_logic_vector(11 downto 0);
        sampler_tx      : out    vl_logic
    );
end Tristate12_vlg_sample_tst;

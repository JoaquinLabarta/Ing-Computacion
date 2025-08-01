library verilog;
use verilog.vl_types.all;
entity pruebaComparador_vlg_sample_tst is
    port(
        dataa           : in     vl_logic_vector(11 downto 0);
        datab           : in     vl_logic_vector(11 downto 0);
        sampler_tx      : out    vl_logic
    );
end pruebaComparador_vlg_sample_tst;

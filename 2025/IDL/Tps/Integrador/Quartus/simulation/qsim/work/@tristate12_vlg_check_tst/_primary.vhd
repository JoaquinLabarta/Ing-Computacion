library verilog;
use verilog.vl_types.all;
entity Tristate12_vlg_check_tst is
    port(
        DATA            : in     vl_logic_vector(11 downto 0);
        sampler_rx      : in     vl_logic
    );
end Tristate12_vlg_check_tst;

library verilog;
use verilog.vl_types.all;
entity PROBANDOTRISTORbdf_vlg_check_tst is
    port(
        DATA            : in     vl_logic_vector(11 downto 0);
        salidaExtra     : in     vl_logic_vector(11 downto 0);
        sampler_rx      : in     vl_logic
    );
end PROBANDOTRISTORbdf_vlg_check_tst;

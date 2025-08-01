library verilog;
use verilog.vl_types.all;
entity PROBANDOTRISTORbdf is
    port(
        DATA            : inout  vl_logic_vector(11 downto 0);
        C               : in     vl_logic;
        A               : in     vl_logic_vector(11 downto 0);
        salidaExtra     : out    vl_logic_vector(11 downto 0);
        LOAD            : in     vl_logic
    );
end PROBANDOTRISTORbdf;

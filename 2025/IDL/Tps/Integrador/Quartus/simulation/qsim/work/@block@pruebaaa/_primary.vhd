library verilog;
use verilog.vl_types.all;
entity BlockPruebaaa is
    port(
        DATA            : inout  vl_logic_vector(11 downto 0);
        C               : in     vl_logic;
        Z               : in     vl_logic_vector(11 downto 0);
        A               : in     vl_logic_vector(11 downto 0)
    );
end BlockPruebaaa;

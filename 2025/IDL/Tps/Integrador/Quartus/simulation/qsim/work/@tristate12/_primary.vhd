library verilog;
use verilog.vl_types.all;
entity Tristate12 is
    port(
        DATA            : inout  vl_logic_vector(11 downto 0);
        I               : in     vl_logic_vector(11 downto 0);
        enable          : in     vl_logic
    );
end Tristate12;

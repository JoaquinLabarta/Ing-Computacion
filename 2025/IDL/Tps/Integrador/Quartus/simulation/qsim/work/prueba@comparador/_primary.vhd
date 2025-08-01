library verilog;
use verilog.vl_types.all;
entity pruebaComparador is
    port(
        s1              : out    vl_logic;
        dataa           : in     vl_logic_vector(11 downto 0);
        datab           : in     vl_logic_vector(11 downto 0);
        s2              : out    vl_logic;
        s3              : out    vl_logic
    );
end pruebaComparador;

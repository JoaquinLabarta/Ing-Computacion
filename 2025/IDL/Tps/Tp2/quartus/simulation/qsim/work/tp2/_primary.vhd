library verilog;
use verilog.vl_types.all;
entity tp2 is
    port(
        B8              : out    vl_logic;
        CLK             : in     vl_logic;
        B7              : out    vl_logic;
        B6              : out    vl_logic;
        B5              : out    vl_logic;
        B4              : out    vl_logic;
        B3              : out    vl_logic;
        B2              : out    vl_logic;
        B1              : out    vl_logic;
        B0              : out    vl_logic;
        salida          : out    vl_logic;
        salida5         : out    vl_logic;
        CLEAR           : out    vl_logic;
        SB0             : out    vl_logic;
        SB1             : out    vl_logic;
        SB2             : out    vl_logic;
        SB3             : out    vl_logic;
        SB4             : out    vl_logic;
        SB5             : out    vl_logic;
        salida30        : out    vl_logic
    );
end tp2;

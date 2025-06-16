library verilog;
use verilog.vl_types.all;
entity tp2_vlg_check_tst is
    port(
        B0              : in     vl_logic;
        B1              : in     vl_logic;
        B2              : in     vl_logic;
        B3              : in     vl_logic;
        B4              : in     vl_logic;
        B5              : in     vl_logic;
        B6              : in     vl_logic;
        B7              : in     vl_logic;
        B8              : in     vl_logic;
        CLEAR           : in     vl_logic;
        salida          : in     vl_logic;
        salida5         : in     vl_logic;
        salida30        : in     vl_logic;
        SB0             : in     vl_logic;
        SB1             : in     vl_logic;
        SB2             : in     vl_logic;
        SB3             : in     vl_logic;
        SB4             : in     vl_logic;
        SB5             : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end tp2_vlg_check_tst;

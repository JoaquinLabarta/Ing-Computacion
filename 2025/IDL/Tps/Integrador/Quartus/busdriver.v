module bus_driver (
    input wire [11:0] contador,
    input wire EN_OUT,
    inout wire [11:0] DATA
);
    assign DATA = EN_OUT ? contador : 12'bz;
endmodule

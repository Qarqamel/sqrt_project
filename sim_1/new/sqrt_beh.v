`timescale 1ns / 1ps

module sqrt_beh();

//input
real x = 0.15625;

//magic constant
reg [63:0] magic_const = 'h5FE6EC85E7DE30DA;

//variables
real y;
real x_half;
reg [63:0] i;

initial
begin
    x_half = x/2;
    i = $realtobits(x);
    i = magic_const-(i>>1);
    y = $bitstoreal(i);
    $display("1/sqrt(x)=%f", y);
end

endmodule

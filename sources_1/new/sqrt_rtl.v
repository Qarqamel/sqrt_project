`timescale 1ns / 1ps

module sqrt_rtl( clock, reset, start, x_in, ready_out, y_out);

input clock, reset;
input start;
input [63:0] x_in;
output reg ready_out;
output reg [63:0] y_out;

parameter magic_const = 'h5FE6EC85E7DE30DA;
parameter S1 = 4'h01, S2 = 4'h02, S3 = 4'h03, S4 = 4'h04, S5 = 4'h05;

reg [3:0] state;
reg [63:0] x;
reg [63:0] x_half;

always @ (posedge clock) begin
    if(reset==1'b1) begin
        ready_out <= 1'b0;
        state <= S1;
        end
    else 
    begin
        case(state)
        S1: begin
            if(start == 1'b1) state <= S2; else state <= S1;
            end
        S2: begin
            x <= x_in;
            ready_out <= 0;
            state <= S3;
            end
        S3: begin
            x <= x>>1;
            state <= S4;
            end
        S4: begin
            x <= magic_const - x;
            state <= S5;
            end
        S5: begin
            y_out <= x;
            ready_out <= 1;
            state <= S1;
            end
        endcase
    end
end
endmodule

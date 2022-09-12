`timescale 1ns / 1ps

module sqrt_rtl_TB();

    reg clock, reset, start;
    reg [63:0] x_in;
    wire ready_out;
    wire [63:0] y_out;
    
    real real_result;
    
    sqrt_rtl sqrt(clock, reset, start, x_in, ready_out, y_out);
    
    initial
        clock <= 1'b1;
    always
        #5 clock <= ~clock;
        
    initial begin
        reset <= 1'b1;
        #10 reset <= 1'b0;
    end
    
    initial begin
        x_in <= $realtobits(0.15625);
        //x_in <= 'h3FC4000000000000;
        start <= 1'b0;
        #20 start <= 1'b1;
        #30 start <= 1'b0;
    end

    always @ (posedge ready_out) begin
        #10 real_result = $bitstoreal(y_out);
        $display("1/sqrt(x) = %f", real_result);
    end
    
endmodule

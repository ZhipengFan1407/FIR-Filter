`timescale 1ns/1ps
// A counter that starts counting from an activation of a signal, and sends out
// an enable signal to the output DFF
module counter(
    input reset,
    input clk,
    output reg count_reach
);

    reg [3 : 0] count = 4'b0000;
    
    always @(negedge clk) begin
        if (count != 4'b1111) begin
            count <= count + 1;
            count_reach <= 1'b0;
        end
        else begin
            count <= 4'b0000;
            count_reach <= 1'b1;
        end
    end

endmodule
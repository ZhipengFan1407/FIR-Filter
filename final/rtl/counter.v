`timescale 1us/1ns
// A counter that starts counting from an activation of a signal, and sends out
// an enable signal to the output DFF
module counter(
    input reset,
    input clk,
    output reg count_reach
);
    reg [3 : 0] count;

	initial begin
		count_reach <= 1'b0;
		count <= 4'b0000;
	end

   always @(posedge clk, posedge reset) begin
		
		if(reset == 1'b1) begin
			count <= 0;
		end
		else begin
			count <= count + 1;
	                if (count == 4'b1111) begin
        	                count_reach <= 1'b1;
	                end
        	        else begin
                	        count_reach <= 1'b0;
                	end

		end
		
		//count <= reset == 1 ? 1'b0 : count + 1;
		//if (count == 4'b1111) begin
		//	count_reach <= 1'b1;
		//	count_reach <= reset == 1 ? 1'b0: 1'b1;
		//end
		//else begin
		//	count_reach <= 1'b0;
		//end
   end

endmodule

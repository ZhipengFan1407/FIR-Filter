module shift (R, w, Clock, Q);
parameter n = 8;
input [n –1:0] R;
input w, Clock;
output reg [n –1:0] Q;
integer k;

always @(posedge Clock)
	for (k = 0; k < n –1; k = k+1) begin
	Q[k] < = Q[k+1];
	end
	Q[n –1] < = w;
end

endmodule
















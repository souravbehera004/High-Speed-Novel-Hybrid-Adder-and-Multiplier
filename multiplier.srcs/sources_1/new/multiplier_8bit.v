//Multiplier 8-bit
module multiplier_8bit (
    input  [7:0] A,
    input  [7:0] B,
    output [15:0] P
);
    wire [15:0] pp [7:0];
    wire [15:0] sum [6:0];

    // Partial product generation
    assign pp[0] = B[0] ? {8'b0, A}         : 16'b0;
    assign pp[1] = B[1] ? {7'b0, A, 1'b0}   : 16'b0;
    assign pp[2] = B[2] ? {6'b0, A, 2'b0}   : 16'b0;
    assign pp[3] = B[3] ? {5'b0, A, 3'b0}   : 16'b0;
    assign pp[4] = B[4] ? {4'b0, A, 4'b0}   : 16'b0;
    assign pp[5] = B[5] ? {3'b0, A, 5'b0}   : 16'b0;
    assign pp[6] = B[6] ? {2'b0, A, 6'b0}   : 16'b0;
    assign pp[7] = B[7] ? {1'b0, A, 7'b0}   : 16'b0;

    // Accumulate partial products using 16-bit hybrid adders
    adder16_hybrid add0 (.A(pp[0]), .B(pp[1]), .SUM(sum[0]));
    adder16_hybrid add1 (.A(sum[0]), .B(pp[2]), .SUM(sum[1]));
    adder16_hybrid add2 (.A(sum[1]), .B(pp[3]), .SUM(sum[2]));
    adder16_hybrid add3 (.A(sum[2]), .B(pp[4]), .SUM(sum[3]));
    adder16_hybrid add4 (.A(sum[3]), .B(pp[5]), .SUM(sum[4]));
    adder16_hybrid add5 (.A(sum[4]), .B(pp[6]), .SUM(sum[5]));
    adder16_hybrid add6 (.A(sum[5]), .B(pp[7]), .SUM(P));
endmodule


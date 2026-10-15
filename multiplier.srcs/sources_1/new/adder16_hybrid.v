//16 bit hybrid adder
module adder16_hybrid (
    input  [15:0] A,
    input  [15:0] B,
    output [15:0] SUM
);
    wire [7:0] sum_lo, sum_hi;
    wire carry_lo, carry_hi;

    // Lower byte
    hybrid_adder adder_lo (
        .A(A[7:0]),
        .B(B[7:0]),
        .SUM(sum_lo),
        .COUT(carry_lo)
    );

    // Upper byte with carry from lower byte
    hybrid_adder adder_hi (
        .A(A[15:8]),
        .B(B[15:8]+ carry_lo), // carry into MSB
        .SUM(sum_hi),
        .COUT(carry_hi)
    );

    assign SUM = {sum_hi, sum_lo};
endmodule


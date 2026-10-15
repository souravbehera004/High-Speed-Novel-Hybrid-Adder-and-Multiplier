// 8-bit hybrid adder
module hybrid_adder (
    input  [7:0] A,
    input  [7:0] B,
    output [7:0] SUM,
    output       COUT
);
    wire [3:0] sum_lo;
    wire [3:0] sum_hi;
    wire carry_lo;

    kogge_4bit ksa_lo (
        .A(A[3:0]),
        .B(B[3:0]),
        .SUM(sum_lo),
        .COUT(carry_lo)
    );

    cla_4bit cla_hi (
        .A(A[7:4]),
        .B(B[7:4]),
        .CIN(carry_lo),
        .SUM(sum_hi),
        .COUT(COUT)
    );

    assign SUM = {sum_hi, sum_lo};
endmodule
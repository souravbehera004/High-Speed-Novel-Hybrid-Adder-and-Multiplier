
// 4-bit carry lookahead adder 
module cla_4bit (
    input  [3:0] A,
    input  [3:0] B,
    input        CIN,
    output [3:0] SUM,
    output       COUT
);
    wire [3:0] G, P;
    wire [3:0] C;                                                                                      // internal carries: C[0] = CIN, C[1] = carry into bit1, ...

    assign G = A & B;                                                                                         // generate
    assign P = A ^ B;                                                                              // propagate

    assign C[0] = CIN;
    // carry lookahead equations
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign COUT = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])
                  | (P[3] & P[2] & P[1] & P[0] & C[0]);

    assign SUM[0] = P[0] ^ C[0];
    assign SUM[1] = P[1] ^ C[1];
    assign SUM[2] = P[2] ^ C[2];
    assign SUM[3] = P[3] ^ C[3];

endmodule


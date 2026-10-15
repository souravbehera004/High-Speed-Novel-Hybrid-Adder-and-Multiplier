// kogge_4bit.v
module kogge_4bit (
    input  [3:0] A,
    input  [3:0] B,
    output [3:0] SUM,
    output COUT
);
    wire [3:0] g, p;                                      // generate and propagate (level 0)
    wire [3:0] g1, p1;                                      // after level 1 (distance 1)
    wire [3:0] g2, p2;                                          // after level 2 (distance 2)
    wire c0, c1, c2, c3;                                        // internal carries (c0 is cin)

    assign g = A & B;
    assign p = A ^ B;

    // Level 1 (distance = 1)
    assign g1[0] = g[0];
    assign p1[0] = p[0];

    assign g1[1] = g[1] | (p[1] & g[0]);
    assign p1[1] = p[1] & p[0];

    assign g1[2] = g[2] | (p[2] & g[1]);
    assign p1[2] = p[2] & p[1];

    assign g1[3] = g[3] | (p[3] & g[2]);
    assign p1[3] = p[3] & p[2];

    // Level 2 (distance = 2)
    assign g2[0] = g1[0];
    assign p2[0] = p1[0];

    assign g2[1] = g1[1];
    assign p2[1] = p1[1];

    assign g2[2] = g1[2] | (p1[2] & g1[0]);
    assign p2[2] = p1[2] & p1[0];

    assign g2[3] = g1[3] | (p1[3] & g1[1]);
    assign p2[3] = p1[3] & p1[1];

    // carries with cin = 0
    assign c0 = 1'b0;
    assign c1 = g2[0] | (p2[0] & c0); // equals g2[0]
    assign c2 = g2[1] | (p2[1] & c0); // equals g2[1]
    assign c3 = g2[2] | (p2[2] & c0);
    assign COUT = g2[3] | (p2[3] & c0);

    // sums
    assign SUM[0] = p[0] ^ c0;
    assign SUM[1] = p[1] ^ c1;
    assign SUM[2] = p[2] ^ c2;
    assign SUM[3] = p[3] ^ c3;

endmodule
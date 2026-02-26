module full_adder (
    input a,b,cin,
    output sum,carry
);
    wire w1,w2,x;

    half_adder h1 (.a(a), .b(b), .sum(w1), .carry(w2));
    half_adder h2 (.a(w1), .b(cin), .sum(sum), .carry(x));
    assign carry = w2 | x;

endmodule
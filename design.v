
`timescale 1ns/1ps


module decoder2to4(
    input A,
    input B,
    input Enable,
    output [3:0] Y
);

    wire nA, nB;

    not (nA, A);
    not (nB, B);

    and (Y[0], Enable, nA, nB);
    and (Y[1], Enable, nA, B);
    and (Y[2], Enable, A, nB);
    and (Y[3], Enable, A, B);

endmodule



module decoder3to8(
    input [2:0] A,
    input Enable,
    output [7:0] Y
);

    wire Enable_L;
    wire Enable_H;

    
    and (Enable_L, Enable, ~A[2]);
    and (Enable_H, Enable, A[2]);

    
    decoder2to4 D0(
        .A(A[1]),
        .B(A[0]),
        .Enable(Enable_L),
        .Y(Y[3:0])
    );

    
    decoder2to4 D1(
        .A(A[1]),
        .B(A[0]),
        .Enable(Enable_H),
        .Y(Y[7:4])
    );

endmodule
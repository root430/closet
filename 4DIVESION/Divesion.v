module Divesion(Clk,Start,Done,a,b,c,d,e,f);
	input Clk,Start;
	input[3:0] a;
	input[3:0] b;
	
	output reg Done;
	output reg[3:0] c;
	output reg[3:0] d;
	output reg[3:0] e;
	output reg[3:0] f;
	
	reg[3:0] temp;
	reg Flag;
	    always @(posedge Clk)
        begin
		  e[3:0] <= a[3:0];
		  f[3:0] <= b[3:0];
            if(Start)
                begin
                    Flag <= 1;
                    Done <= 0;
                    temp[3:0] <= a[3:0];
                    c[3:0] <= 4'b0;          //把0000赋值给c
						  d[3:0] <= 4'b0;  
                end
            if((a[3:0] == 4'b0)&&(b[3:0] == 4'b0))
                begin
                    Done <= 0;
                end
            if((a[3:0] < b[3:0])&&(Done == 0)&&(Flag == 1))  //判断a，b大小，如小于则商为0，余数为被除数
                begin
                    c[3:0] <= 4'b0;
                    d[3:0] <= a[3:0];
                    Done <= 1;
                    Flag <= 0;
                end
            if((a[3:0] == b[3:0])&&(Done == 0)&&(Flag == 1))  //a，b相等，则商为1，余数为0
                begin
                    c[3:0] <= 4'b0001;
                    d[3:0] <= 4'b0;
                    Done <= 1;
                    Flag <= 0;
                end
            if((b[3:0] == 4'b0)&&(Done == 0)&&(Flag == 1))  //如果被除数为0，输出F，表示错误
                begin
                    c[3:0] <= 4'b1111;
                    d[3:0] <= 4'b1111;
                    Done <= 1;
                    Flag <= 0;
                end
            if((temp[3:0] >= b[3:0])&&(Done == 0)&&(Flag == 1))  //如果a大于b，则使用移位相减法
                begin
                    temp[3:0] <= temp[3:0]-b[3:0];
                    c[3:0] <= c[3:0] + 1;
                end
            if((temp[3:0] < b[3:0])&&(Done == 0)&&(Flag == 1))
                begin
                    d[3:0] <= temp[3:0];
                    Done <= 1;
                    Flag <= 0;
                end
        end
endmodule

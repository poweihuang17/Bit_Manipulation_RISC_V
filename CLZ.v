module CLZ(
input [31:0] rs1,
output [31:0] rd
);

//Only use least 5 bit in rd.
assign rd[31:5]=27'd0;

//First stage
wire or_upper_16,or_down_16;
assign or_upper_16=|rs1[31:16];
assign or_down_16=|rs1[15:0];
assign condition_1={or_upper_16,or_down_16};
wire [15:0] result_stage1;

always@(*)
    begin
    case(condition_1)
        2'b00:
            begin
            //Still need to define the result of all 0.
            rd[4]=1'b0;
            result_stage1=rs1[15:0];
            end
        2'b11,2'b10:
            begin
            rd[4]=1'b0;
            result_stage1=rs1[31:16];
            end
        2'b01:
            begin
            rd[4]=1'b1;
            result_stage1=rs1[15:0];
            end
    end
//Second stage
wire or_upper_8,or_down_8;
assign or_upper_8=|result_stage1[16:8];
assign or_down_8=|rs1[7:0];
assign condition_2={or_upper_8,or_down_8};
wire [7:0] result_stage2;

always@(*)
    begin
    case(condition_2)
        2'b00:
            begin
            //Still need to define the result of all 0.
            rd[3]=1'b0;
            result_stage2=result_stage[7:0];
            end
        2'b11,2'b10:
            begin
            rd[3]=1'b0;
            result_stage2=result_stage1[15:8];
            end
        2'b01:
            begin
            rd[3]=1'b1;
            result_stage2=result_stage1[7:0];
            end
    end

//Third stage
wire or_upper_4,or_down_4;
assign or_upper_4=|result_stage2[7:4];
assign or_down_4=|result_stage2[3:0];
assign condition_3={or_upper_4,or_down_4};
wire [3:0] result_stage3;

always@(*)
    begin
    case(condition_3)
        2'b00:
            begin
            //Still need to define the result of all 0.
            rd[2]=1'b0;
            result_stage3=result_stage2[3:0];
            end
        2'b11,2'b10:
            begin
            rd[2]=1'b0;
            result_stage3=result_stage2[7:4];
            end
        2'b01:
            begin
            rd[2]=1'b1;
            result_stage3=result_stage2[3:0];
            end
    end

//Fourth stage
wire or_upper_2,or_down_2;
assign or_upper_2=|result_stage3[3:2];
assign or_down_2=|result_stage3[1:0];
assign condition_2={or_upper_2,or_down_2};
wire [3:0] result_stage4;

always@(*)
    begin
    case(condition_4)
        2'b00:
            begin
            //Still need to define the result of all 0.
            rd[1]=1'b0;
            result_stage4=result_stage3[1:0];
            end
        2'b11,2'b10:
            begin
            rd[1]=1'b0;
            result_stage4=result_stage3[3:2];
            end
        2'b01:
            begin
            rd[1]=1'b0;
            result_stage4=result_stage3[1:0];
            end
    end



//Fifth stage
assign condition_1=result_stage4;

always@(*)
    begin
    case(condition_1)
        2'b00:
            begin
            //Still need to define the result of all 0.
            rd[0]=1'b0;
            end
        2'b11,2'b10:
            begin
            rd[0]=1'b0;
            end
        2'b01:
            begin
            rd[0]=1'b1;
            end
    end
endmodule

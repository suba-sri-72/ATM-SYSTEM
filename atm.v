module atm(
input clk,rst,cardin,pin_valid,
input [3:0] pin,
input [15:0] amount,
input [1:0] sel,
input cancel,

output dispense_cash,
output reg [15:0] balance_amount,
output reg [15:0] deposit_amount);

reg [3:0] ps,ns;
reg [15:0] acc_balance;

parameter [3:0] storedpin=4'b0101;

parameter s0=4'b0000,s1=4'b0001,
s2=4'b0010,s3=4'b0011,
s4=4'b0100,s5=4'b0101,
s6=4'b0110,s7=4'b0111,
s8=4'b1000,s9=4'b1001,
s10=4'b1010;

// Seq and balance 
always @(posedge clk) begin
    if(rst) begin
        ps <= s0;
        acc_balance <= 16'd9000;
    end
    else begin 
        ps <= ns;

        if(ps==s7)
            acc_balance <= acc_balance + amount;

        else if(ps==s10 && amount<=acc_balance)
            acc_balance <= acc_balance - amount;
    end
end

// Balance display
always @(*) begin
    balance_amount=0;
    case(ps)
        s5: balance_amount=acc_balance;
        s7: balance_amount=acc_balance+amount;
        s10: balance_amount=acc_balance-amount;
        default: balance_amount=acc_balance;
    endcase
end

// Deposit amount
always @(*) begin
    deposit_amount=0;

    if(ps==s7)
        deposit_amount=acc_balance+amount;
end

// Next state 
always @(*) begin
    ns=ps;

    case(ps)

        s0: begin
            if(cardin)
                ns=s1;
            else
                ns=s0;
        end

        s1: ns=s2;

        s2: begin
            if(pin_valid)
                ns=s3;
            else
                ns=s0;
        end

        s3: begin
            if(pin==storedpin)
                ns=s4;
            else
                ns=s2;
        end

        s4: begin
            case(sel)
                2'b00: ns=s5;
                2'b01: ns=s6;
                2'b10: ns=s7;
                2'b11: ns=s8;
                default: ns=s4;
            endcase
        end

        s5: ns=s0;

        s6: begin
            if(amount>acc_balance)
                ns=s9;
            else
                ns=s10;
        end

        s7: ns=s0;

        s8: begin
            if(cancel)
                ns=s0;
            else
                ns=s8;
        end

        s9: ns=s0;

        s10: ns=s0;

        default: ns=s0;

    endcase
end

assign dispense_cash=(ps==s10);

endmodule



module atm__tb;
reg clk, rst, cardin, pin_valid, cancel;
reg [3:0]pin;
reg [15:0]amount;
reg [1:0] sel;
wire dispense_cash;
wire [15:0] balance_amount;
wire [15:0] deposit_amount;
atm dut(clk, rst, cardin, pin_valid, pin, amount, sel, cancel,dispense_cash, balance_amount, deposit_amount);
initial
       	{clk,rst} = 0;
always #5 clk = ~clk;
initial begin
        $monitor("Time=%0t State=%0d Sel=%b Amount=%0d Dispense=%b Balance=%0d",
                 $time, dut.ps, sel, amount, dispense_cash, balance_amount);
end
initial begin
        rst = 1; 
	cardin = 0; 
	pin_valid = 0; 
	pin = 0;
        amount = 0; 
	sel = 0; 
	cancel = 0;
        #20 rst = 0;                                    // t=20
        // balance
        #10 cardin = 1;                                 // t=30  s0  s1
        #10 cardin = 0;                                 // s1  s2
        #10 pin_valid = 1;pin = 4'b0101;               // s2  s3
        #10 pin_valid = 0;sel = 2'b00;                 // s3  s4 
        #20 $display("Balance enquiry = %0d", balance_amount);
        //withdraw 2000 
        #10 cardin = 1;
        #10 cardin = 0;
        #10 pin_valid = 1;
        #10 pin_valid = 0;sel = 2'b01;amount = 16'd2000;
        #30 $display("Withdraw:Dispense=%b Balance=%0d (1 7000)",dispense_cash, balance_amount);
        #10 $display("After withdraw: Balance=%0d (7000)", balance_amount);
        // insufficient balance
        cardin = 1;
        #10 cardin = 0;
        #10 pin_valid = 1;
        #10 pin_valid = 0;sel = 2'b01;amount = 16'd10000;
        #30 $display("Insufficient: Dispense=%b Balance=%0d (0, 7000)",dispense_cash, balance_amount);

        //deposit 1000
        #10 cardin = 1;
        #10 cardin = 0;
        #10 pin_valid = 1;
        #10 pin_valid = 0;sel = 2'b10;amount = 16'd1000;
        #20 $display("Deposit: deposit_amount=%0d (8000)", deposit_amount); //bal+amout
        #10 $display("Updated balance=%0d (8000)", balance_amount);

        //Test 5: wrong PIN ()
        cardin = 1;
        #10 cardin = 0;
        #10 pin_valid = 1; pin = 4'b0001;
        #10 pin_valid = 0;
        #20 $display("Wrong pin: state=%0b nextstate=%0b ", dut.ps, dut.ns);

        // cancel (sel=11 - s8)
        cardin = 1;
        #10 cardin = 0;
        #10 pin_valid = 1;pin = 4'b0101;
        #10 pin_valid = 0;sel = 2'b11;
        #20 cancel = 1;
        #10 cancel = 0;
        $display("Cancel: state=%0d (s0)", dut.ps);
        #20 $finish;
    end
endmodule
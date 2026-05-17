class load_test extends base_test;
	function new();
		super.new();
	endfunction 
	virtual task run_scenario();
		wait(dut_vif.presetn == 1);
		$display("============================load_up============================");
		write(8'h03, 8'h03);
		write(8'h02, 8'h64);  //0x64 = 100 decimal
		write(8'h00, 8'h04);
		write(8'h00, 8'h01);
		repeat(170) @(posedge dut_vif.ker_clk);
		compare(8'h01, 8'h01);
		if(dut_vif.interrupt == 1) begin
			$display("%0t: Interrupt trigger, load up case correct", $time);
		end else begin
			$display("%0t: Interrupt is not trigger, load up case fail", $time);
			error_cnt++;
		end
		dut_vif.presetn = 0;
		#100;
		dut_vif.presetn = 1;
		$display("============================load_down============================");
		write(8'h03, 8'h03);
		write(8'h02, 8'h64); //0x64 = 100 decimal
		write(8'h00, 8'h04);
		write(8'h00, 8'h02);
		write(8'h00, 8'h03);
		repeat(110) @(posedge dut_vif.ker_clk);
		compare(8'h01, 8'h02);
		if(dut_vif.interrupt == 1) begin
			$display("%0t: Interrupt trigger, load up case correct", $time);
		end else begin
			$display("%0t: Interrupt is not trigger, load up case fail", $time);
			error_cnt++;
		end

	endtask
endclass
	

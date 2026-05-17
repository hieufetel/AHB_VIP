class cross_divide_test extends base_test;
	
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
		wait(dut_vif.presetn == 1);
		$display("%0t: ==============cross divide test================", $time);
		write(8'h03, 8'h03);
		write(8'h00, 8'h01);
		repeat(100) @(posedge dut_vif.ker_clk);
		write(8'h00, 8'h09);   //Change div_val to 01: div_val = 2
		@(posedge dut_vif.ker_clk);
		compare(8'h00, 8'h09);
		repeat(180) @(posedge dut_vif.ker_clk);
		if(dut_vif.interrupt == 0) begin 
			$display("%0t: clock divide is change while timer enable", $time);
			error_cnt++;
		end else begin
			$display("0t: clock divide is not change", $time);
		end

	
	endtask
endclass
		

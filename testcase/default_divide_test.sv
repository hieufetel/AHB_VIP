class default_divide_test extends base_test;

	function new();
		super.new();
	endfunction

	virtual task run_scenario();
		time t1, t2;
		real period;
		wait(dut_vif.presetn == 1);
		$display("%0t: ==============default divide test================", $time);
		$display("%0t: ==============count_up_test======================", $time);
		write(8'h03, 8'h03);
		write(8'h00, 8'h01);
		repeat(270) @(posedge dut_vif.ker_clk); 
		compare(8'h01, 8'h01);//check interrupt asserted
		@(posedge dut_vif.ker_clk);
		t1 = $time;
		@(posedge dut_vif.ker_clk);
		t2 = $time;
		period = t2 - t1;
		if(period == 5000) begin
			$display("%0t: PASS: Default count up test is satisfied", $time);
		end else begin
			$display("%0t: FAIL: Default count up test is not satisfied", $time);
			error_cnt++;
		end
		dut_vif.presetn = 0; 
		#100; 
		dut_vif.presetn = 1;
		$display("%0t: ==============count_down_test======================", $time);
		write(8'h03, 8'h03);
		write(8'h00, 8'h02);
		write(8'h00, 8'h03);
		repeat(270) @(posedge dut_vif.ker_clk);
		compare(8'h01, 8'h02);
		@(posedge dut_vif.ker_clk);
		t1 = $time;
		@(posedge dut_vif.ker_clk);
		t2 = $time;
		period = t2 - t1;
		if(period == 5000) begin
			$display("%0t: PASS: Default count down test is satisfied", $time);
		end else begin
			$display("%0t: FAIL: Default count down test is not satisfied", $time);
			error_cnt++;
		end



	endtask
endclass

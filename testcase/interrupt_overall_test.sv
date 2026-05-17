class interrupt_overall_test extends base_test;

	function new();
		super.new();
	endfunction

	virtual task run_scenario();
	wait(dut_vif.presetn == 1);
	$display("%0t: ==================================Overflow Interrupt==========================", $time);
	write(8'h03, 8'h03);
	write(8'h00, 8'h01);
	repeat(260) @(posedge dut_vif.ker_clk);
	compare(8'h01, 8'h01);
	if(dut_vif.interrupt == 1) begin
		$display("%0t: PASS Overflow Interrupt is trigger when reach max value", $time);
	end else begin
		$display("%0t: FAIL Overflow Interrupt is not trigger when reach max value", $time);
		error_cnt++;
	end
	dut_vif.presetn =0;
	#100;
	dut_vif.presetn = 1;
	$display("%0t: ==================================Underflow Interrupt==========================", $time);
	write(8'h03, 8'h03);
	write(8'h00, 8'h02);
	write(8'h00, 8'h03);
	repeat(260) @(posedge dut_vif.ker_clk);
	compare(8'h01, 8'h02);
	if(dut_vif.interrupt == 1) begin
		$display("%0t: PASS Underflow Interrupt is trigger when reach max value", $time);
	end else begin
		$display("%0t: FAIL Underflow Interrupt is not trigger when reach max value", $time);
		error_cnt++;
	end


	endtask
endclass

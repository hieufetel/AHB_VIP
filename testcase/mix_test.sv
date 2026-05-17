class mix_test extends base_test;
	
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
	wait(dut_vif.presetn == 1);
	$display("%0t: ===============================Change timer_en while counting====================", $time);
	$display("%0t: ===============================count_up_test====================", $time);
	write(8'h03, 8'h03);
	write(8'h00, 8'h01);
	repeat(100) @(posedge dut_vif.ker_clk);
	write(8'h00, 8'h00);
	repeat(170) @(posedge dut_vif.ker_clk);
	compare(8'h01, 8'h00);
	if(dut_vif.interrupt == 0) begin
		$display("%0t: Pass: Counter does not count", $time);
	end else begin
		$display("%0t: Fail: Counter counts up, Interrupt trigger", $time);
		error_cnt++;
	end
	dut_vif.presetn = 0;
	#100;
	dut_vif.presetn = 1;
	$display("%0t: ===============================count_down_test====================", $time);
	write(8'h03, 8'h03);
	write(8'h00, 8'h02);
	write(8'h00, 8'h03);
	repeat(100) @(posedge dut_vif.ker_clk);
	write(8'h00, 8'h02);
	repeat(170) @(posedge dut_vif.ker_clk);
	compare(8'h01, 8'h00);
	if(dut_vif.interrupt == 0) begin
		$display("%0t: Pass: Counter does not count", $time);
	end else begin
		$display("%0t: Fail: Counter counts up, Interrupt trigger", $time);
		error_cnt++;
	end
	dut_vif.presetn = 0;
	#100;
	dut_vif.presetn = 1;
	$display("%0t: ===============================Load data from TDR while counter is counting====================", $time);
	$display("%0t: ===============================count_up_test====================", $time);
	write(8'h03, 8'h03);
	write(8'h02, 8'hc8); // 0xc8 = 200 decimal
	write(8'h00, 8'h01);
	repeat(5) @(posedge dut_vif.ker_clk);
	write(8'h00, 8'h00);
	write(8'h00, 8'h04);
	write(8'h00, 8'h01);
	repeat(65) @(posedge dut_vif.ker_clk);
	compare(8'h01, 8'h01);
	if(dut_vif.interrupt == 1) begin
		$display("%0t: Pass: Load data success while counting", $time);
	end else begin
		$display("%0t: Fail: Load data unsuccess while counting", $time);
		error_cnt++;
	end
	dut_vif.presetn = 0;
	#100;
	dut_vif.presetn = 1;
	$display("%0t: ===============================count_down_test====================", $time);
	write(8'h03, 8'h03);
	write(8'h02, 8'hc8); // 0xc8 = 200 decimal
	write(8'h00, 8'h02);
	write(8'h00, 8'h03);
	repeat(5) @(posedge dut_vif.ker_clk);
	write(8'h00, 8'h02);
	write(8'h00, 8'h04);
	write(8'h00, 8'h03);
	repeat(215) @(posedge dut_vif.ker_clk);
	compare(8'h01, 8'h02);
	if(dut_vif.interrupt == 1) begin
		$display("%0t: Pass: Load data success while counting", $time);
	end else begin
		$display("%0t: Fail: Load data unsuccess while counting", $time);
		error_cnt++;
	end


	endtask
endclass

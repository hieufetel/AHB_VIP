class fly_check_register_test extends base_test;

	function new();
		super.new();
	endfunction

	virtual task run_scenario();
	bit[7:0] rd_data;
	wait(dut_vif.presetn == 1);
	write(8'h00, 8'hAA);
	write(8'h01, 8'hBB);
	write(8'h02, 8'hCC);
	write(8'h03, 8'hDD);
	#100;
	dut_vif.presetn = 1;
	#100;
	dut_vif.presetn = 0;
	compare(8'h00, 8'h00);
	compare(8'h01, 8'h00);
	compare(8'h02, 8'h00);
	compare(8'h03, 8'h00);
	endtask
endclass

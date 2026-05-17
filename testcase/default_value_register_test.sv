class default_value_register_test extends base_test;

	
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
	bit[7:0] rd_data;
	wait(dut_vif.presetn == 1);
	$display("%0t: ==============default value test================", $time);
	compare(8'h00, 8'h00);
	compare(8'h01, 8'h00);
	compare(8'h02, 8'h00);
	compare(8'h03, 8'h00);
	endtask
endclass

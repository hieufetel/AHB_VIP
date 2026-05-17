class random extends base_test;
	function new();
		super.new();
	endfunction 

	virtual task run_scenario();
		wait(dut_vif.presetn == 1);
		//write(8'h02, 8'hF0);
		//write(8'h00, 8'h04);
		//write(8'h03, 8'h01);
		//write(8'h00, 8'h01);
		//#3000;
		//compare(8'h01, 8'h01);
		//compare(8'h00, 8'h1F);
		//compare(8'h03, 8'h01);
		write(8'h03, 8'h03);
		write(8'h00, 8'h01);
		repeat(270) @(posedge dut_vif.ker_clk); 
		compare(8'h01, 8'h01);
	endtask
endclass

class read_write_register_test extends base_test;
	function new();
		super.new();
	endfunction

	virtual task run_scenario();
	wait(dut_vif.presetn == 1);
	$display("====================TCR value================");
	write(8'h00, 8'h00);
	compare(8'h00, 8'h00);
	write(8'h00, 8'h55);
	compare(8'h00, 8'h15);
	write(8'h00, 8'haa);
	compare(8'h00, 8'h0a);
	write(8'h00, 8'h37);
	compare(8'h00, 8'h17);
	write(8'h00, 8'hff);
	compare(8'h00, 8'h1f); //This trigger the count down process, so the underflow asserted
	write(8'h00, 8'h00);	
	$display("====================TSR value================");
	write(8'h01, 8'h02);//clear overflow process
	compare(8'h01, 8'h00);
	write(8'h01, 8'h55);
	compare(8'h01, 8'h00);
	write(8'h01, 8'haa);
	compare(8'h01, 8'h00);
	write(8'h01, 8'h37);
	compare(8'h01, 8'h00);
	write(8'h01, 8'hff);
	compare(8'h01, 8'h00);
	
	$display("====================TDR value================");
	write(8'h02, 8'h00);
	compare(8'h02, 8'h00);
	write(8'h02, 8'h55);
	compare(8'h02, 8'h55);
	write(8'h02, 8'haa);
	compare(8'h02, 8'haa);
	write(8'h02, 8'h37);
	compare(8'h02, 8'h37);
	write(8'h02, 8'hff);
	compare(8'h02, 8'hff);
	
	$display("====================TIER value================");
	write(8'h03, 8'h00);
	compare(8'h03, 8'h00);
	write(8'h03, 8'h55);
	compare(8'h03, 8'h01);
	write(8'h03, 8'haa);
	compare(8'h03, 8'h02);
	write(8'h03, 8'h37);
	compare(8'h03, 8'h03);
	write(8'h03, 8'hff);
	compare(8'h03, 8'h03);
	endtask
endclass	

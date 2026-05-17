class reserved_check_test extends base_test;

	function new();
		super.new();
	endfunction

	virtual task run_scenario();
		bit[7:0] temp;
		bit[7:0] addr;
		wait(dut_vif.presetn == 1);
		$display("====================Reserved check================");
		write(8'h00, 8'hFF);
        	//write(8'h01, 8'hFF);
		//write(8'h02, 8'hFF);
		//write(8'h03, 8'hFF);
		#100; 
		$display("====================TCR register================");
		read(8'h00, temp);
		compare(8'h00, 8'h1F); 	       
		dut_vif.presetn = 0;
		#100;
		dut_vif.presetn = 1;
			
        	write(8'h01, 8'hFF);
		$display("====================TSR register================");
		read(8'h01, temp);
		compare(8'h01, 8'h00);  
		
		dut_vif.presetn = 0;
		#100;
		dut_vif.presetn = 1;

		write(8'h02, 8'hFF);
		$display("====================TDR register================");
		read(8'h02, temp);
		compare(8'h02, 8'hFF);
		
		dut_vif.presetn = 0;
		#100;
		dut_vif.presetn = 1;

		write(8'h03, 8'hFF);
		$display("====================TIE register================");
		read(8'h03, temp);
		compare(8'h03, 8'h03);	
		
		$display("====================others register================");
		for(addr = 8'h04; addr <= 8'h0F; addr++) begin
 			write(addr, 8'hFF);
	       	        compare(addr, 8'h00);
		end      
		write(8'hFF, 8'hFF);
		compare(8'hFF, 8'h00);
	endtask
endclass





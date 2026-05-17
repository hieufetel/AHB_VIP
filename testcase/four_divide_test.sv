class four_divide_test extends base_test;

	function new();
		super.new();
	endfunction

	virtual task run_scenario();
		wait(dut_vif.presetn == 1);
		$display("%0t: ==============divide test by 4================", $time);
		$display("%0t: ==============count_up_test======================", $time);
		write(8'h03, 8'h03);
		write(8'h00, 8'h10);
		write(8'h00, 8'h11);
		repeat(1060) @(posedge dut_vif.ker_clk);
		compare(8'h01, 8'h01);
		if(dut_vif.interrupt == 1) begin
			$display("%0t: Interrupt trigger", $time);
		end else begin 
			$display("%0t: Interrupt is not trigger", $time);
			error_cnt++;
		end



		dut_vif.presetn = 0; 
		#100; 
		dut_vif.presetn = 1;

		$display("%0t: ==============count_down_test======================", $time);
		write(8'h03, 8'h03);
		write(8'h00, 8'h12);
		write(8'h00, 8'h13);
		repeat(1060) @(posedge dut_vif.ker_clk);
		compare(8'h01, 8'h02);
		if(dut_vif.interrupt == 1) begin
			$display("%0t: Interrupt trigger", $time);
		end else begin 
			$display("%0t: Interrupt is not trigger", $time);
			error_cnt++;
		end

	endtask
endclass


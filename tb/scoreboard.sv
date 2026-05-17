class scoreboard;
	mailbox #(packet) m2s_mb;
	`include "coverage.sv"
	//bit[7:0] ref_data [bit[7:0]];
	int error_cnt; //ERROR internal
	function new(mailbox #(packet) m2s_mb);
		this.m2s_mb = m2s_mb;
		APB_GROUP = new();
		apb_pkt = new();
	endfunction

	task run();
		packet pkt;
		while(1) begin
			m2s_mb.get(pkt);
      			$display("%0t: [scoreboard] Get packet from monitor: %s: addr = 8'h%h, data = %h", $time,pkt.transfer.name(),pkt.addr,pkt.data);
			sample_apb_fc(pkt);
		end
	endtask
	
	function void report (int error_cnt);
		int total_error;
		total_error = this.error_cnt + error_cnt;
		if(total_error == 0) 
			$display("%0t: [scoreboard] TEST PASSED", $time);
		else
			$display("%0t: [scoreboard] TEST FAILED, total error_cnt is %0d", $time, total_error);
	endfunction

	function cmp(bit[7:0] addr, bit[7:0] exp_data, bit[7:0] act_data);
		if(act_data === exp_data) begin
			$display("%0t: [scoreboard] Data comparision at addr 8'h%h is matching 8'h%h", $time, addr, act_data);
			return 0;
		end else begin
			$display("%0t: [scoreboard] Data comparision at addr 8'h%h is not matching, Exp: 8'h%h, Act: 8'h%h", $time, addr, exp_data, act_data);
			return 1;
		end
	endfunction

	function void sample_apb_fc(packet pkt);
		$cast(apb_pkt,pkt);
		APB_GROUP.sample();
	endfunction
endclass


				

	
	//function void sample_apb_fc(packet pkt);
	//	$cast(apb_trans, pkt);
	//	APB_GROUP.sample();
	//endfunction

	

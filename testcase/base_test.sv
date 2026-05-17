class base_test;
	int error_cnt;
	environment env;
	
	virtual dut_if dut_vif;

	function new();
		error_cnt = 0;
	endfunction

	function void build();
		env = new(dut_vif);
		env.build();
	endfunction

	task write(bit[7:0] addr, bit[7:0] data);
		packet pkt = new();
		pkt.addr = addr;
		pkt.data = data;
		pkt.transfer = packet::WRITE;
		env.stim.send_pkt(pkt);
		@(env.drv.xfer_done);
	endtask


	task read(bit[7:0] addr, ref bit[7:0] data);
		packet pkt = new();
		pkt.addr = addr;
		pkt.transfer = packet::READ;
		env.stim.send_pkt(pkt);
  		@(env.drv.xfer_done);
		data = pkt.data;
	endtask
	task  compare(bit[7:0] addr,  bit [7:0] exp_data);
		bit [7:0] act_data;
	  	read(addr, act_data);
	    	error_cnt += env.scb.cmp(addr, exp_data, act_data);
	endtask

	virtual task run_scenario();
	endtask

	task run_test();
		build();
		fork
			env.run();
			run_scenario();
		join_any
		#100;
		env.scb.report(error_cnt);
		#3us;
		$display("%0t: [base_test] End simulation", $time);
		$finish;
	endtask


endclass

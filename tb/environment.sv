class environment;

	stimulus stim;
        driver drv;
	monitor mnt;
	scoreboard scb;
	mailbox #(packet) s2d_mb;
	mailbox #(packet) m2s_mb;
	virtual dut_if dut_vif;
	

	function new(virtual dut_if dut_vif);
		this.dut_vif = dut_vif;
	endfunction

	function void build();
		s2d_mb = new();
		m2s_mb = new();
		stim = new(s2d_mb);
		drv = new(s2d_mb, dut_vif);
		mnt = new(m2s_mb, dut_vif);
		scb = new(m2s_mb);
	endfunction	

	task run();
		fork
			stim.run();
			drv.run();
			mnt.run();
			scb.run();
		join_any
	endtask
endclass
			

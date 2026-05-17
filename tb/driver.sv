class driver;
	mailbox #(packet) s2d_mb;
	virtual dut_if dut_vif;
	event xfer_done;

	function new(mailbox #(packet) s2d_mb, virtual dut_if dut_vif);
	       this.s2d_mb = s2d_mb;
	       this.dut_vif = dut_vif;
	endfunction

	task run();
		packet pkt;
		while(1) begin
			s2d_mb.get(pkt);
			$display("%0t: [driver] Get packet from the stimulus", $time);
			@(posedge dut_vif.pclk);
			dut_vif.psel = 1;
			dut_vif.penable = 0;
			dut_vif.paddr = pkt.addr;
			dut_vif.pwrite = (pkt.transfer == packet::WRITE) ? 1 : 0;
	       		dut_vif.pwdata = pkt.data;
			@(posedge dut_vif.pclk);
			dut_vif.penable = 1;
			wait(dut_vif.pready == 1);
			if(pkt.transfer == packet::READ)
				pkt.data = dut_vif.prdata;
			@(posedge dut_vif.pclk);
			dut_vif.psel = 0;
			dut_vif.penable = 0;
			-> xfer_done;
		end
	endtask
endclass
			


		

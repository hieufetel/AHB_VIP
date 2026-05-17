class monitor;
	mailbox #(packet) m2s_mb;
	virtual dut_if dut_vif;

	function new(mailbox #(packet) m2s_mb, virtual dut_if dut_vif);
		this.m2s_mb = m2s_mb;
		this.dut_vif = dut_vif;
	endfunction

	task run();
		packet pkt;
		$display("%0t [monitor] Start monitor transaction", $time);
		while(1) begin
		@(posedge dut_vif.pclk);
		#1;
		//$display("%0t: [monitor] The psel=%d, penable=%d, pready=%d", $time, dut_vif.psel, dut_vif.penable, dut_vif.pready);
		if(dut_vif.psel && dut_vif.penable && dut_vif.pready) begin
		pkt = new();	
		pkt.addr = dut_vif.paddr;
		pkt.transfer = (dut_vif.pwrite) ?  packet::WRITE : packet::READ;
		if(pkt.transfer == packet::WRITE) begin 
			pkt.data = dut_vif.pwdata;
		end else begin
			pkt.data = dut_vif.prdata;
		end
		//$display("%0t: [monitor] Data capture is 8'h%h, send to Scoreboard", $time, pkt.data);
		$display("%0t [monitor] Captured APB transaction",$time);
      		m2s_mb.put(pkt);
		end
	end
	endtask
endclass




	  		
			

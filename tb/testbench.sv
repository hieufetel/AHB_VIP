`timescale 1ns/1ps

module testbench; 
  import timer_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  timer_top u_dut(
    .ker_clk(d_if.ker_clk),       
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .interrupt(d_if.interrupt));

  initial begin
    d_if.presetn = 0;
    #100ns d_if.presetn = 1;
  end

  // 50 MHz
  initial begin
	  
    d_if.pclk = 0;
    d_if.paddr = 0;
    d_if.psel = 0;
    d_if.penable=0;
    d_if.pwrite=0;
    d_if.pwdata=0;
    forever begin 
      #10ns;
      d_if.pclk = ~d_if.pclk;
    end
  end
 
  // 200 MHz
  initial begin
    d_if.ker_clk = 1;
    forever begin 
      #2.5ns;
      d_if.ker_clk = ~d_if.ker_clk;
    end
  end


  initial begin
    #1ms;
    $display("[testbench] Time out....Seems your tb is hang!");
    $finish;
  end

	base_test base;
	default_value_register_test     df;
    	read_write_register_test        rw;	
	fly_check_register_test  	fl;
	reserved_check_test		rs;
	random				rd;
	default_divide_test		d0;
	two_divide_test			d2;
	four_divide_test		d4;
	eight_divide_test		d8;
	cross_divide_test		cr;
	load_test			ld;
	mix_test			mx;
	interrupt_overall_test		intr;
	interrupt_mask			intr_m;
	interrupt_clear_test		intr_c;
  initial begin
	  base = new();
	  df = new();
	  rw = new();
	  fl = new();
	  rs = new();
	  rd = new();
	  d0 = new();
	  d2 = new();
	  d4 = new();
	  d8 = new();
	  cr = new();
	  ld = new();
	  mx = new();
	  intr = new();
	  intr_m = new();
	  intr_c = new();
	  if($test$plusargs("default_value_register_test")) begin
		  $display("%0t: [testbench] Run default_value_register_test", $time);
		  base = df;
	  end
	  if($test$plusargs("read_write_register_test")) begin
		  $display("%0t: [testbench] Run read_write_register_test", $time);
		  base = rw;
	  end
	  if($test$plusargs("fly_check_register_test")) begin
		  $display("%0t: [testbench] Run fly_check_register_test", $time);
		  base = fl;
	  end
	  if($test$plusargs("reserved_check_test")) begin
		  $display("%0t: [testbench] Run reserved_check_test", $time);
		  base = rs;
	  end
	  if($test$plusargs("random")) begin
		  $display("%0t: [testbench] Run random_test", $time);
		  base = rd;
	  end
	  if($test$plusargs("default_divide_test")) begin
		  $display("%0t: [testbench] Run default_divide_test", $time);
		  base = d0;
	  end
	  if($test$plusargs("divide_by_two_test")) begin
		  $display("%0t: [testbench] Run divide_by_two_test", $time);
		  base = d2;
	  end
	  if($test$plusargs("divide_by_four_test")) begin
		  $display("%0t: [testbench] Run divide_by_four_test", $time);
		  base = d4;
	  end
	  if($test$plusargs("divide_by_eight_test")) begin
		  $display("%0t: [testbench] Run divide_by_eight_test", $time);
		  base = d8;
	  end
	  if($test$plusargs("cross_divide_test")) begin
		  $display("%0t: [testbench] Run cross_divide_test", $time);
		  base = cr;
	  end
	  if($test$plusargs("load_test")) begin
		  $display("%0t: [testbench] Run load_test", $time);
		  base = ld;
	  end
	  if($test$plusargs("mix_test")) begin
		  $display("%0t: [testbench] Run mix_test", $time);
		  base = mx;
	  end
	  if($test$plusargs("interrupt_overall_test")) begin
		  $display("%0t: [testbench] Run interrupt_overall_test", $time);
		  base = intr;
	  end
	  if($test$plusargs("interrupt_mask_test")) begin
		  $display("%0t: [testbench] Run interrupt_mask_test", $time);
		  base = intr_m;
	  end
	  if($test$plusargs("interrupt_clear_test")) begin
		  $display("%0t: [testbench] Run interrupt_clear_test", $time);
		  base = intr_c;
	  end

	  base.dut_vif = d_if;
	  base.run_test();
  end
	

//  logic div_0 = 0;
//
//
// property no_divide_test;
//	@(posedge dut_vif.ker_clk)
//

//  property apb_address_stable;
//	  @(posedge apb_if.pclk)
//	  (apb_if.psel && apb_if.penable && apb_if.pready) |-> $stable(apb_if.paddr);
//  endproperty
//
//  assert property(apb_address_stable)
//  	  $display("Address stable check done");
//  else
//	  $display("Address stable check failed");
//
   
endmodule

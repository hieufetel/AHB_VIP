package test_pkg;

  import timer_pkg::*;
 
  `include "base_test.sv"
  `include "default_value_register_test.sv"
  `include "read_write_register_test.sv"
  `include "fly_check_register_test.sv"
  `include "reserved_check_test.sv"
  `include "random.sv"
  `include "default_divide_test.sv"
  `include "two_divide_test.sv"
  `include "four_divide_test.sv"
  `include "eight_divide_test.sv"
  `include "cross_divide_test.sv"
  `include "load_test.sv"
  `include "mix_test.sv"
  `include "interrupt_overall_test.sv"
  `include "interrupt_mask.sv"
  `include "interrupt_clear_test.sv"
endpackage

packet apb_pkt;

covergroup APB_GROUP;

	apb_transfer: coverpoint apb_pkt.transfer {
		bins apb_read  = {packet::READ};
		bins apb_write = {packet::WRITE};
	}

	apb_address: coverpoint apb_pkt.addr {
		bins TCR_addr = {8'h00};
		bins TSR_addr = {8'h01};
		bins TDR_addr = {8'h02};
		bins TIE_addr = {8'h03};
	}

	apb_data: coverpoint apb_pkt.data {
		//TCR bins
		bins TCR_count_up 		= {8'h01};
		bins TCR_count_down 		= {8'h03};
		bins TCR_load			= {8'h04};
		bins TCR_div2			= {8'h08};
		bins TCR_div2_count_up		= {8'h09};
		bins TCR_div2_count_down	= {8'h0B};
		bins TCR_div4			= {8'h10};
		bins TCR_div4_count_up		= {8'h11};
		bins TCR_div4_count_down	= {8'h13};
		bins TCR_div8			= {8'h18};
		bins TCR_div8_count_up		= {8'h19};
		bins TCR_div8_count_down	= {8'h1B};
		
		//TSR bins
		bins TSR_clear_ovf		= {8'h01};
		bins TSR_clear_udf		= {8'h02};

		//TDR bins
		bins TDR_data 			= {[8'h00:8'hFF]};

		//TIE bins
		bins TIE_ovf_and_udf  			= {8'h03};
	}

	apb_transaction: cross apb_transfer, apb_address;

	count_up_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins count_up = !binsof(apb_transfer) intersect {packet::WRITE} || 
				       !binsof(apb_address)  intersect {8'h00} || 
			      	       !binsof(apb_data)     intersect {8'h01};
		        }

	count_down_feature: cross apb_transfer, apb_address, apb_data {
 		ignore_bins count_down = !binsof(apb_transfer) intersect {packet::WRITE} ||
					 !binsof(apb_address)  intersect {8'h00} || 
			 		 !binsof(apb_data)     intersect {8'h03};
			}

	load_enable_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins load_enable = !binsof(apb_transfer) intersect {packet::WRITE} || 
					  !binsof(apb_address) intersect {8'h00} ||
					  !binsof(apb_data)    intersect {8'h04};
			}

	load_data_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins load_data = !binsof(apb_transfer) intersect {packet::WRITE} ||
					!binsof(apb_address)  intersect {8'h02} ||
					!binsof(apb_data) intersect {8'h64};
			}

	count_up_div2_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins div2_up = !binsof(apb_transfer) intersect {packet::WRITE} ||
				      !binsof(apb_address) intersect  {8'h00} ||
				      !binsof(apb_data)    intersect  {8'h09};
		      }

	count_down_div2_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins div2_down = !binsof(apb_transfer) intersect {packet::WRITE} ||
				      	!binsof(apb_address) intersect  {8'h00} ||
				      	!binsof(apb_data)    intersect  {8'h0B};
		      }

	count_up_div4_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins div4_up = !binsof(apb_transfer) intersect {packet::WRITE} ||
				      !binsof(apb_address) intersect  {8'h00} ||
				      !binsof(apb_data)    intersect  {8'h11};
		      }

	count_down_div4_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins div4_down = !binsof(apb_transfer) intersect {packet::WRITE} ||
				      !binsof(apb_address) intersect  {8'h00} ||
				      !binsof(apb_data)    intersect  {8'h13};
		      }

	count_up_div8_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins div8_up = !binsof(apb_transfer) intersect {packet::WRITE} ||
				      !binsof(apb_address) intersect  {8'h00} ||
				      !binsof(apb_data)    intersect  {8'h19};
		      }

	count_down_div8_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins div8_up = !binsof(apb_transfer) intersect {packet::WRITE} ||
				      !binsof(apb_address) intersect  {8'h00} ||
				      !binsof(apb_data)    intersect  {8'h1B};
		      }
	
	both_ovf_udf_enable_feature: cross apb_transfer, apb_address, apb_data {
	      	ignore_bins ovf_udf = !binsof(apb_transfer) intersect {packet::WRITE} ||
				      !binsof(apb_address)  intersect {8'h03} ||
			      	      !binsof(apb_data)	    intersect {8'h03};
		      }

	clear_ovf_feature: cross apb_transfer, apb_address, apb_data {
  		ignore_bins clear_ovf = !binsof(apb_transfer) intersect {packet::WRITE} ||
					!binsof(apb_address)  intersect {8'h01} ||
					!binsof(apb_data)     intersect {8'h01};
			}

	clear_udf_feature: cross apb_transfer, apb_address, apb_data {
		ignore_bins clear_udf = !binsof(apb_transfer) intersect {packet::WRITE} ||
					!binsof(apb_address)  intersect {8'h01} ||
					!binsof(apb_data)     intersect {8'h02};
			}



	











	



endgroup

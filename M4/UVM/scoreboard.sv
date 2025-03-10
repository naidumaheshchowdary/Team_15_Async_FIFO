`include "rd_agent.sv"
`include "wr_agent.sv"
class scoreboard extends uvm_test;
	`uvm_component_utils(scoreboard)
	
	uvm_analysis_port #(wr_sq_item) sc_wr_port;
	uvm_analysis_port #(rd_sq_item) sc_rd_port;
	
	wr_sq_item tx_wr[$];
	rd_sq_item tx_rd[$];
	
	function new(string name = "scoreboard", uvm_component parent);
		super.new(name,parent);
		`uvm_info("scoreboard", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("scoreboard", "build_phase", UVM_HIGH)
		
		sc_wr_port = new("sc_wr_port",this);
		sc_rd_port = new("sc_rd_port",this);
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("scoreboard", "connect_phase", UVM_HIGH)
	endfunction
		
	//write_tx_wr method
	function void write(wr_sq_item wr_item);
		if(wr_item.winc) begin
			tx_wr.push_back(wr_item);
		end
	endfunction
	
	//write_tx_rd method
	function void read(rd_sq_item rd_item);
		if(rd_item.rinc) begin
			tx_rd.push_back(rd_item);
		end
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("Scoreboard", "Inside run_phase", UVM_HIGH)
		forever begin
			wr_sq_item curr_trans_w;
			rd_sq_item curr_trans_r;
			wait(tx_wr.size!= 0)
			curr_trans_w = tx_wr.pop_front();
			//wait(tx_rd.size(!= 0))
			//curr_trans_r = tx_rd.pop_front();
			//compare_read_writes(curr_trans_w,curr_trans_r);
		end
	endtask
/*task compare_read_writes (int a,int b);
	
	int par_flag=0,full_flag=0;
	if(tx_wr.size() > tx_rd.size()) begin 
	$display("Comparing for partial reads");
	
	for (int i=0;i<tx_rd.size();i++) begin 
		if(tx_rd[i].write_data!=tx_wr[i].read_data) begin
			par_flag=1;
			$display("Incorrect Write data %d and read %d ",tx_rd[i],tx_wr[i]);
			break;
			end
		end
	end
	else if(tx_wr.size() == tx_rd.size()) begin 
	$display("Comparing for full reads");
	
	for (int i=0;i<tx_rd.size();i++) begin 
		if(tx_rd[i].write_data!=tx_wr[i].read_data) begin
			full_flag=1;
			$display("Incorrect Write data %d and read %d ",tx_rd[i],tx_wr[i]);
			break;
			end
		end
	end
	
	if(a!==b) $display("Incorrect transactions are taking place  %d read  and %d write",a,b);
	else $display("Correct transactions taking place read writes");
	
	if(a!==b) $display("Incorrect transactions are taking place %d read and %d write",a,b);
	else $display("Correct transactions taking place in full read writes");
	
	endtask*/
	
endclass
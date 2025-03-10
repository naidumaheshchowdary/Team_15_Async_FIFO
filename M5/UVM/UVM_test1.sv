import uvm_pkg::*;

`include "uvm_macros.svh"
`include "UVM_environment.sv"



class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    environment env;
    wr_sq w_seq;
    rd_sq r_seq;
    virtual FIFO_int vif;

    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
		`uvm_info("base_test", "Inside constructor",UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase); 
        super.build_phase(phase);
		`uvm_info("base_test", "Inside build_phase",UVM_LOW)
        env = environment::type_id::create("env", this);

        if (!uvm_config_db#(virtual FIFO_int)::get(this, "", "vif", vif)) begin
            `uvm_fatal("FIFO/DRV/NOVIF", "No virtual interface specified for this test instance")
        end 
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
		`uvm_info("base_test", "Inside connect_phase",UVM_LOW)
    endfunction 

    function void end_of_elaboration();
        super.end_of_elaboration();
		`uvm_info("base_test", "Inside end_of_elaboration_phase",UVM_LOW)
        uvm_root::get().print_topology();
    endfunction

    task run_phase(uvm_phase phase );
        env.wa.wd.trans_count_wr=913;
        env.ra.rd.trans_count_rd=456;

        env.wa.wm.trans_count_wr=913;
        env.ra.rm.trans_count_rd=456;
		`uvm_info("fifo_base_test", "Inside run_phase",UVM_LOW)

        phase.raise_objection(this, "Starting wr_sq in main phase");

        fork
            begin
                $display("/t Starting sequence w_seq run_phase");
                w_seq = wr_sq::type_id::create("w_seq", this);
                
                w_seq.start(env.wa.wsr);
            end
            begin
                $display("/t Starting sequence r_seq run_phase");
                r_seq = rd_sq::type_id::create("r_seq", this);
                r_seq.start(env.ra.rsr);
            end
        join
      
        #100ns;
 		
      	env.scb.compare_flags();
        phase.drop_objection(this , "Finished fifo_seq in main phase");


        #2000;
        $finish;
    endtask

endclass

//reads and writes parallelly
class write_read_test extends base_test;

   `uvm_component_utils(write_read_test)
  
   wr_sq_bug write_seq;
   rd_sq_bug read_seq;
  
   function new(string name = "write_read_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      write_seq = wr_sq_bug::type_id::create("write_seq");
      read_seq = rd_sq_bug::type_id::create("read_seq");
      `uvm_info("write_read_test","Inside the build_phase of write_read_test_concurrent",UVM_MEDIUM)
   endfunction

   task run_phase(uvm_phase phase); 
     phase.raise_objection(this);
     phase.phase_done.set_drain_time(this, 20);
     fork
      write_seq.start(env.wa.wsr);
      read_seq.start(env.ra.rsr);
     join
     phase.drop_objection(this);
   endtask

endclass


class full_test extends uvm_test;
    `uvm_component_utils(full_test)

    environment env;
    wr_sq_full w_seq;
    rd_sq_full r_seq;
    virtual FIFO_int vif;

    function new(string name = "full_test", uvm_component parent = null);
        super.new(name, parent);
		`uvm_info("full_test", "Inside constructor",UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase); 
        super.build_phase(phase);
		`uvm_info("full_test", "Inside build_phase",UVM_LOW)
        env = environment::type_id::create("env", this);

        if (!uvm_config_db#(virtual FIFO_int)::get(this, "", "vif", vif)) begin
            `uvm_fatal("FIFO/DRV/NOVIF", "No virtual interface specified for this test instance")
        end 
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
		`uvm_info("full_test", "Inside connect_phase",UVM_LOW)
    endfunction 

    function void end_of_elaboration();
        super.end_of_elaboration();
		`uvm_info("full_test", "Inside end_of_elaboration",UVM_LOW)
        uvm_root::get().print_topology();
    endfunction

    task run_phase(uvm_phase phase );
        env.wa.wd.trans_count_wr=456;
        env.ra.rd.trans_count_rd=0;

        env.wa.wm.trans_count_wr=456;
        env.ra.rm.trans_count_rd=0;
		
		`uvm_info("full_test", "Inside end_of_elaboration",UVM_LOW)

        phase.raise_objection(this, "Starting fifo_write_seq in main phase");

        fork
            begin
                $display("/t Starting sequence w_seq run_phase");
                w_seq = wr_sq_full::type_id::create("w_seq", this);
                
                w_seq.start(env.wa.wsr);
            end
            begin
                $display("/t Starting sequence r_seq run_phase");
                r_seq = rd_sq_full::type_id::create("r_seq", this);
                r_seq.start(env.ra.rsr);
            end
        join
      
        #100ns;
 		
      	env.scb.compare_flags();
        phase.drop_objection(this , "Finished fifo_seq in main phase");


        #2000;
        $finish;
    endtask

endclass


class random_test extends uvm_test;
  `uvm_component_utils(random_test)

    environment env;
    wr_sq_random w_seq;
    rd_sq_random r_seq;
    virtual FIFO_int vif;

  function new(string name = "random_test", uvm_component parent = null);
        super.new(name, parent);
		`uvm_info("random_test", "Inside constructor",UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase); 
        super.build_phase(phase);
		`uvm_info("random_test", "Inside build_phase",UVM_LOW)
        env = environment::type_id::create("env", this);

        if (!uvm_config_db#(virtual FIFO_int)::get(this, "", "vif", vif)) begin
            `uvm_fatal("FIFO/DRV/NOVIF", "No virtual interface specified for this test instance")
        end 
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
		`uvm_info("random_test", "Inside connect_phase",UVM_LOW)
    endfunction 

    function void end_of_elaboration();
        super.end_of_elaboration();
		`uvm_info("random_test", "Inside end_of_elaboration_phase",UVM_LOW)
        uvm_root::get().print_topology();
    endfunction

    task run_phase(uvm_phase phase );
        env.wa.wd.trans_count_wr=100;
        env.ra.rd.trans_count_rd=100;

        env.wa.wm.trans_count_wr=100;
        env.ra.rm.trans_count_rd=100;
		
		`uvm_info("random_test", "Inside run_phase",UVM_LOW)

        phase.raise_objection(this, "Starting fifo_write_seq in main phase");

        fork
            begin
                $display("/t Starting sequence w_seq run_phase");
                w_seq = wr_sq_random::type_id::create("w_seq", this);
                
                w_seq.start(env.wa.wsr);
            end
            begin
                $display("/t Starting sequence r_seq run_phase");
                r_seq = rd_sq_random::type_id::create("r_seq", this);
                r_seq.start(env.ra.rsr);
            end
        join
      
        #100ns;
 		
      	env.scb.compare_flags();
        phase.drop_objection(this , "Finished fifo_seq in main phase");


        #2000;
        $finish;
    endtask

endclass


class half_empty_test extends uvm_test;
    `uvm_component_utils(half_empty_test)

    environment env;
    wr_sq_half_empty w_seq;
    rd_sq_half_empty r_seq;
    virtual FIFO_int vif;

    function new(string name = "half_empty_test", uvm_component parent = null);
        super.new(name, parent);
		`uvm_info("half_empty_test", "Inside constructor",UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase); 
        super.build_phase(phase);
		`uvm_info("half_empty_test", "Inside build_phase",UVM_LOW)
        env = environment::type_id::create("env", this);

        if (!uvm_config_db#(virtual FIFO_int)::get(this, "", "vif", vif)) begin
            `uvm_fatal("FIFO/DRV/NOVIF", "No virtual interface specified for this test instance")
        end 
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
		`uvm_info("half_empty_test", "Inside connect_phase",UVM_LOW)
    endfunction 

    function void end_of_elaboration();
        super.end_of_elaboration();
		`uvm_info("half_empty_test", "Inside end_of_elaboration",UVM_LOW)
        uvm_root::get().print_topology();
    endfunction

    task run_phase(uvm_phase phase );
        env.wa.wd.trans_count_wr=229;
        env.ra.rd.trans_count_rd=1;

        env.wa.wm.trans_count_wr=229;
        env.ra.rm.trans_count_rd=1;
		
		`uvm_info("half_empty_test", "Inside end_of_elaboration",UVM_LOW)

        phase.raise_objection(this, "Starting fifo_write_seq in main phase");

        fork
            begin
                $display("/t Starting sequence w_seq run_phase");
                w_seq = wr_sq_half_empty::type_id::create("w_seq", this);
                
                w_seq.start(env.wa.wsr);
            end
            begin
                $display("/t Starting sequence r_seq run_phase");
                r_seq = rd_sq_half_empty::type_id::create("r_seq", this);
                r_seq.start(env.ra.rsr);
            end
        join
      
        #100ns;
 		
      	env.scb.compare_flags();
        phase.drop_objection(this , "Finished fifo_seq in main phase");


        #2000;
        $finish;
    endtask

endclass
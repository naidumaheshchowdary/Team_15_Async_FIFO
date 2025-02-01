module async_fifo_tb;

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 4;

  logic wr_en, wr_clk, wr_reset;
  logic rd_en, rd_clk, rd_reset;
  logic [DATA_WIDTH-1:0] wr_data;
  wire [DATA_WIDTH-1:0] rd_data;
  wire fifo_full, fifo_empty;
  logic [DATA_WIDTH-1:0] expected_data[$];
  logic [DATA_WIDTH-1:0] captured_data;

  // Instantiate the asynchronous FIFO
  Asynchronous_FIFO #(.DSIZE(DATA_WIDTH), .ADDRESS_SIZE(ADDR_WIDTH)) fifo_inst (
    .winc(wr_en),
    .wclk(wr_clk),
    .wrst(wr_reset),
    .rinc(rd_en),
    .rclk(rd_clk),
    .rrst(rd_reset),
    .wdata(wr_data),
    .rdata(rd_data),
    .wfull(fifo_full),
    .rempty(fifo_empty)
  );

  // Clock generation
  initial begin
    wr_clk = 0;
    rd_clk = 0;
    forever begin
      #4.1667 wr_clk = ~wr_clk; // 120 MHz write clock (1/120e6 ˜ 8.333 ns period, half period ˜ 4.1667 ns)
      #10 rd_clk = ~rd_clk;     // 50 MHz read clock (1/50e6 = 20 ns period, half period = 10 ns)
    end
  end

  // Write process
  initial begin
    wr_en = 0;
    wr_data = 0;
    wr_reset = 0;
    repeat(5) @(posedge wr_clk); // Wait for a few cycles
    wr_reset = 1; // Release reset

    for (int iteration = 0; iteration < 2; iteration++) begin
      for (int i = 0; i < 460; i++) begin
        @(posedge wr_clk iff !fifo_full); // Wait until FIFO is not full
        wr_en = (i % 4 == 0) ? 1 : 0; // Enable write every 4 cycles (3 idle cycles)
        if (wr_en) begin
          wr_data = $urandom; // Generate random data
          expected_data.push_front(wr_data); // Store expected data
	  $display("Write successfully");
        end
      end
      #1; // Small delay
    end
  end

  // Read process
  initial begin
    rd_en = 0;
    rd_reset = 0;
    repeat(5) @(posedge rd_clk); // Wait for a few cycles
    rd_reset = 1; // Release reset

    for (int iteration = 0; iteration < 2; iteration++) begin
      for (int i = 0; i < 460; i++) begin
        @(posedge rd_clk iff !fifo_empty); // Wait until FIFO is not empty
        rd_en = (i % 3 == 0) ? 1 : 0; // Enable read every 3 cycles (2 idle cycles)
        if (rd_en) begin
          captured_data = expected_data.pop_back(); // Retrieve expected data
          $display("Data Check: Read = %h", rd_data);
        end
      end
    end
    $finish; // End simulation
  end

endmodule

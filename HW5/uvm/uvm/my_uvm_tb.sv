
import uvm_pkg::*;
import my_uvm_package::*;

`include "my_uvm_if.sv"

`timescale 1 ns / 1 ns

module my_uvm_tb;

    my_uvm_if vif();

    udp_top udp_top(
        .clk(vif.clock),
        .reset(vif.reset),
        //sof eof
        .in_wr_eof(vif.in_wr_eof),
        .in_wr_sof(vif.in_wr_sof),
        //input fifo
        .in_wr_en(vif.in_wr_en),
        .in_din(vif.in_din),
        .in_full(vif.in_full),
        //output fifo
        .out_rd_en(vif.out_rd_en),
        .out_dout(vif.out_dout),
        .out_empty(vif.out_empty)
        
    );

    initial begin
        // store the vif so it can be retrieved by the driver & monitor
        uvm_resource_db#(virtual my_uvm_if)::set
            (.scope("ifs"), .name("vif"), .val(vif));

        // run the test
        run_test("my_uvm_test");        
    end

    // reset
    initial begin
        vif.clock <= 1'b1;
        vif.reset <= 1'b0;
        @(posedge vif.clock);
        vif.reset <= 1'b1;
        @(posedge vif.clock);
        vif.reset <= 1'b0;
    end

    // 10ns clock
    always
        #(CLOCK_PERIOD/2) vif.clock = ~vif.clock;
endmodule







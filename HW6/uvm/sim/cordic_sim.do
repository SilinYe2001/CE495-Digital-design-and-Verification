
setenv LMC_TIMEUNIT -9
vlib work
vmap work work

vlog -work work "../sv/cordic_stage.sv"
vlog -work work "../sv/cordic_top.sv"
vlog -work work "../sv/cordic.sv"
vlog -work work "../sv/fifo.sv"

# uvm library
vlog -work work +incdir+$env(UVM_HOME)/src $env(UVM_HOME)/src/uvm.sv
vlog -work work +incdir+$env(UVM_HOME)/src $env(UVM_HOME)/src/uvm_macros.svh
vlog -work work +incdir+$env(UVM_HOME)/src $env(MTI_HOME)/verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv

# uvm package
vlog -work work +incdir+$env(UVM_HOME)/src "../uvm/my_uvm_pkg.sv"
vlog -work work +incdir+$env(UVM_HOME)/src "../uvm/my_uvm_tb.sv"

# start uvm simulation
vsim -classdebug -voptargs=+acc +notimingchecks -L work work.my_uvm_tb -wlf my_uvm_tb.wlf -sv_lib lib/uvm_dpi -dpicpppath /usr/bin/gcc +incdir+$env(MTI_HOME)/verilog_src/questa_uvm_pkg-1.2/src/


do cordic_wave.do

run -all
#quit;
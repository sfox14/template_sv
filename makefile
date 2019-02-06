# Makefile for Vivado simulation

# Top level arguments
TOP :=
ECHO = @echo

# current directory
pwd := $(CURDIR)

# source files
vsrc =	$(wildcard $(pwd)/src/main/hdl/*.v) \
	$(wildcard $(pwd)/src/main/hdl/*.sv) \
	$(wildcard $(pwd)/src/test/hdl/*.v)\
	$(wildcard $(pwd)/src/test/hdl/*.sv)

# include paths
iflags = -i $(pwd)/src/main/hdl -i $(pwd)/src/test/hdl

# vcd dump flags
TCL_VCD := src/test/resources/vcd.tcl
tflags := -tclbatch $(pwd)/$(TCL_VCD)

all: test

test: 
	mkdir -p test-outputs; cd test-outputs; $(ECHO) $(CURDIR); \
	xvlog $(vsrc) $(iflags) -nolog; \
	xelab -debug typical -s top_sim $(TOP) -sv -nolog --timescale 1ns/1ps; \
	xsim top_sim -R -stats $(tflags) -onfinish quit; \
	mv dump.vcd ../top_sim.vcd	

clean:
	rm -rf test-outputs/ *.vcd .Xil/
	
help:
	$(ECHO) "Makefile Usage:"
	$(ECHO)
	$(ECHO) "Example"
	$(ECHO)	"-------"
	$(ECHO) "make TOP=<target_test_bench>"
	$(ECHO) "   Simulates the target test bench using Vivado in batch mode."
	$(ECHO) "   A .vcd file is created which can be opened with any waveform viewer"
	$(ECHO) 
	$(ECHO) "Options"
	$(ECHO) "-------"
	$(ECHO) "clean"
	$(ECHO) "   Remove all generated files in test-outputs"
	$(ECHO)
	$(ECHO)	"User Arguments"
	$(ECHO)	"---------"
	$(ECHO) "TOP"
	$(ECHO) "   top module name in the target test bench"
	$(ECHO) "   eg. fifo_tb"
	$(ECHO)
	$(ECHO) "Please ensure that all source files can be retrieved from the"
	$(ECHO) "following include flags:"
	$(ECHO) "   "$(iflags)
	$(ECHO) "And the top module can be found here:"
	$(ECHO) "   "$(vsrc)
	$(ECHO) 
	$(ECHO) "Internal Arguments"
	$(ECHO) "------------------"
	$(ECHO) "TCL_VCD"
	$(ECHO)	"   tcl file used to generate the vcd dump"
	$(ECHO)
	$(ECHO) "Extension"
	$(ECHO) "---------"
	$(ECHO)	"To open a simulation using the Vivado gui, run:"
	$(ECHO) "   make TOP=<target_test_bench>"
	$(ECHO) "   cd test-outputs"
	$(ECHO) "   xsim top_sim -gui [-view <wave_config_file.wcfg]"
	$(ECHO)
     
	

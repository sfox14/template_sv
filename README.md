## Project Template

This repository provides a project template for tesing new verilog (and system verilog) projects. Open a terminal and run: 

```
make TOP=first_counter_tb
```

This will launch a Vivado simulation for `first_counter_tb` in batch mode, and will dump the waveform in `top_sim.vcd`. The `test-outputs` directory will also be created containing all other generated files.

## Repository Structure

* `src`: The application and test source files
	* `main`:  Application sources 
		* `hdl`: Core user verilog and system verilog files
		* `resources`: Other files and scripts (including third party resources)
	* `test`: Test sources
		* `hdl`: Core user verilog and system verilog testbench files
		* `resources`: Other simulation files and scripts 		
 



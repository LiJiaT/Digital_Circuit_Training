@echo off
set xv_path=F:\\SoftWare\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim Sim_behav -key {Behavioral:sim_1:Functional:Sim} -tclbatch Sim.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

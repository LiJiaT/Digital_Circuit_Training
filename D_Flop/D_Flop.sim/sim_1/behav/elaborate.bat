@echo off
set xv_path=F:\\SoftWare\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 6b9f6f940f2e4f668235d2ec4fefeb24 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot Sim_behav xil_defaultlib.Sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

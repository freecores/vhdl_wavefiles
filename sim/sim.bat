ghdl -a  ../src/Wavefiles-p.vhd
ghdl -a  ../src/Testbench-ea.vhd

del test.log
ghdl -r Testbench --vcd=test.vcd 2> test.log
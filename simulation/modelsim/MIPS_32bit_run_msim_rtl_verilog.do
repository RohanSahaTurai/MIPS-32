transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/data_memory.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/MIPS_32bit.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/ALU_32bit.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/ALU_Control.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/Control_Unit.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/top_level.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/Instruction_memory.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/register_file.v}

vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS_32bit {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS_32bit/test.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  test

add wave *
view structure
view signals
run -all

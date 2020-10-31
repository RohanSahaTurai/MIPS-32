transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/data_memory.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/MIPS_32bit.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/ALU_32bit.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/ALU_Control.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/Control_Unit.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/top_level.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/Instruction_memory.v}
vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/register_file.v}

vlog -vlog01compat -work work +incdir+E:/UTS_Current/Academics/2020\ Spring/48451\ Embedded\ Systems\ Studio\ A/MIPS-32 {E:/UTS_Current/Academics/2020 Spring/48451 Embedded Systems Studio A/MIPS-32/test.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  test

add wave *
view structure
view signals
run -all

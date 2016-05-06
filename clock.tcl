#
# Vivado (TM) v2014.4 (64-bit)
#
# clock.tcl: Tcl script for re-creating project 'clock'
#
# Generated by Vivado on Fri May 06 18:39:45 EDT 2016
# IP Build 1070531 on Tue Nov 18 01:10:18 MST 2014
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************
# NOTE: In order to use this script for source control purposes, please make sure that the
#       following files are added to the source control system:-
#
# 1. This project restoration tcl script (clock.tcl) that was generated.
#
# 2. The following source(s) files that were local or imported into the original project.
#    (Please see the '$orig_proj_dir' and '$origin_dir' variable setting below at the start of the script)
#
#    <none>
#
# 3. The following remote source files that were added to the original project:-
#
#    "/home/guest/cae/fpga/ntpserver/hdl/util_pkg.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/regs.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/dac.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/fan.vhd"
#    "/home/guest/cae/fpga/ntpserver/cpu/cpu.bd"
#    "/home/guest/cae/fpga/ntpserver/hdl/clock_.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/tsc.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/bcdtime.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/syspll.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/clock.vhd"
#    "/home/guest/cae/fpga/ntpserver/ip/ocxo_clk_pll/ocxo_clk_pll.xci"
#    "/home/guest/cae/fpga/ntpserver/xdc/pin.xdc"
#    "/home/guest/cae/fpga/ntpserver/ip/ocxo_clk_pll/ocxo_clk_pll_clk_wiz.vhd"
#    "/home/guest/cae/fpga/ntpserver/ip/ocxo_clk_pll/ocxo_clk_pll.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/util_pkg.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/tb_pkg.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/regs.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/fan.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/cpu_test.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/clock_.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/tsc.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/bcdtime.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/dac.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/syspll.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/clock.vhd"
#    "/home/guest/cae/fpga/ntpserver/hdl/clock_tb.vhd"
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/clock"]"

# Create project
create_project clock ./clock

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects clock]
set_property "board_part" "em.avnet.com:microzed_7010:part0:1.0" $obj
set_property "default_lib" "work" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/hdl/util_pkg.vhd"]"\
 "[file normalize "$origin_dir/hdl/regs.vhd"]"\
 "[file normalize "$origin_dir/hdl/dac.vhd"]"\
 "[file normalize "$origin_dir/hdl/fan.vhd"]"\
 "[file normalize "$origin_dir/cpu/cpu.bd"]"\
 "[file normalize "$origin_dir/hdl/clock_.vhd"]"\
 "[file normalize "$origin_dir/hdl/tsc.vhd"]"\
 "[file normalize "$origin_dir/hdl/bcdtime.vhd"]"\
 "[file normalize "$origin_dir/hdl/syspll.vhd"]"\
 "[file normalize "$origin_dir/hdl/clock.vhd"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/hdl/util_pkg.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/regs.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/dac.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/fan.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/cpu/cpu.bd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
if { ![get_property "is_locked" $file_obj] } {
  set_property "generate_synth_checkpoint" "0" $file_obj
}
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/clock_.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/tsc.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/bcdtime.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/syspll.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/clock.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj


# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "top" "clock" $obj

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/ip/ocxo_clk_pll/ocxo_clk_pll.xci"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/ip/ocxo_clk_pll/ocxo_clk_pll.xci"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "library" "work" $file_obj
if { ![get_property "is_locked" $file_obj] } {
  set_property "synth_checkpoint_mode" "Singular" $file_obj
}


# Set 'sources_1' fileset file properties for local files
# None

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/xdc/pin.xdc"]"
set file_added [add_files -norecurse -fileset $obj $file]
set file "$origin_dir/xdc/pin.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property "file_type" "XDC" $file_obj
set_property "library" "work" $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property "target_constrs_file" "[file normalize "$origin_dir/xdc/pin.xdc"]" $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
set files [list \
 "[file normalize "$origin_dir/ip/ocxo_clk_pll/ocxo_clk_pll_clk_wiz.vhd"]"\
 "[file normalize "$origin_dir/ip/ocxo_clk_pll/ocxo_clk_pll.vhd"]"\
 "[file normalize "$origin_dir/hdl/util_pkg.vhd"]"\
 "[file normalize "$origin_dir/hdl/tb_pkg.vhd"]"\
 "[file normalize "$origin_dir/hdl/regs.vhd"]"\
 "[file normalize "$origin_dir/hdl/fan.vhd"]"\
 "[file normalize "$origin_dir/hdl/cpu_test.vhd"]"\
 "[file normalize "$origin_dir/hdl/clock_.vhd"]"\
 "[file normalize "$origin_dir/hdl/tsc.vhd"]"\
 "[file normalize "$origin_dir/hdl/bcdtime.vhd"]"\
 "[file normalize "$origin_dir/hdl/dac.vhd"]"\
 "[file normalize "$origin_dir/hdl/syspll.vhd"]"\
 "[file normalize "$origin_dir/hdl/clock.vhd"]"\
 "[file normalize "$origin_dir/hdl/clock_tb.vhd"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_1' fileset file properties for remote files
set file "$origin_dir/ip/ocxo_clk_pll/ocxo_clk_pll_clk_wiz.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/ip/ocxo_clk_pll/ocxo_clk_pll.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/util_pkg.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/tb_pkg.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/regs.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/fan.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/cpu_test.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/clock_.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/tsc.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/bcdtime.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/dac.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/syspll.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/clock.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj

set file "$origin_dir/hdl/clock_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "library" "work" $file_obj


# Set 'sim_1' fileset file properties for local files
# None

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "runtime" "100us" $obj
set_property "source_set" "" $obj
set_property "top" "clock_tb" $obj
set_property "xsim.simulate.runtime" "100us" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7z010clg400-1 -flow {Vivado Synthesis 2014} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2014" [get_runs synth_1]
}
set obj [get_runs synth_1]

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7z010clg400-1 -flow {Vivado Implementation 2014} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2014" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property "steps.write_bitstream.args.bin_file" "1" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:clock"

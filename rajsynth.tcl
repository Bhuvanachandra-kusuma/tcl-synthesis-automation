#!/bin/env tclsh

set enable_prelayout_timing 1

set working_dir [exec pwd]

set vsd_array_length [llength [split [lindex $argv 0] .]]

set input [lindex [split [lindex $argv 0] .] [expr {$vsd_array_length-1}]]

if {![regexp {^csv} $input] || $argc!=1} {

    puts "Error in usage"

    puts "Usage: ./rajsynth <.csv>"

    puts "where <.csv> file has required inputs"

    exit

} else {

    set filename [lindex $argv 0]

    package require csv

    package require struct::matrix

    struct::matrix m

    set f [open $filename]

    csv::read2matrix $f m , auto

    close $f

    m link my_arr

    set num_of_rows [m rows]

    set i 0

    while {$i < $num_of_rows} {

        puts "\nInfo: Setting $my_arr(0,$i) as '$my_arr(1,$i)'"

        if {$i == 0} {

            set [string map {" " ""} $my_arr(0,$i)] $my_arr(1,$i)

        } else {

            set [string map {" " ""} $my_arr(0,$i)] [file normalize $my_arr(1,$i)]

        }

        set i [expr {$i+1}]

    }

}

puts "\nInfo: Listing initial variables and their values:"

puts "------------------------------------------------------"

puts "DesignName = $DesignName"

puts "OutputDirectory = $OutputDirectory"

puts "NetlistDirectory = $NetlistDirectory"

puts "EarlyLibraryPath = $EarlyLibraryPath"

puts "LateLibraryPath = $LateLibraryPath"

puts "ConstraintsFile = $ConstraintsFile"

if ![file isdirectory $OutputDirectory] {

    puts "\nInfo: Cannot find the directory $OutputDirectory. Creating $OutputDirectory"

    file mkdir $OutputDirectory

} else {

    puts "\nInfo: Output directory found in path $OutputDirectory"

}

if ![file isdirectory $NetlistDirectory] {

    puts "\nInfo: Cannot find the RTL netlist directory $NetlistDirectory. Exiting..."

    exit

} else {

    puts "\nInfo: RTL netlist directory found in path $NetlistDirectory"

}

if { ! [file exists $EarlyLibraryPath] } {

    puts "\nError: Cannot find the early cell library in path $EarlyLibraryPath. Exiting...."

} else {

    puts "\nInfo: Early cell library found in path $EarlyLibraryPath"

}

if { ! [file exists $LateLibraryPath] } {

    puts "\nError: Cannot find the late cell library in path $LateLibraryPath. Exiting...."

} else {

    puts "\nInfo: Late cell library found in path $LateLibraryPath"

}

if { ! [file exists $ConstraintsFile] } {

    puts "\nError: Cannot find ConstraintFile in path $ConstraintsFile. Exiting...."

} else {

    puts "\nInfo: ConstraintFile found in path $ConstraintsFile"

}

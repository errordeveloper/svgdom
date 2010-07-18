#!/usr/bin/tclsh

package require tdom

namespace eval ::svgdom {

variable xml_rev "1.0"
variable xml_enc "utf-8"

variable svg_std "http://www.w3.org/2000/svg"
variable svg_rev "1.2"

proc plist {canv_size data_list} {

variable xml_rev; variable xml_enc
variable svg_rev; variable svg_std

	variable tree [dom createDocument xml]
	variable root [$tree documentElement]
	
	$root setAttribute version $xml_rev
	$root setAttribute encoding $xml_enc
	
	variable node [$tree createElement svg]
	$node setAttribute width [lindex $canv_size 0]
	$node setAttribute height [lindex $canv_size 1]
	$node setAttribute version $svg_rev
	$node setAttribute xmlns $svg_std
	
	foreach leaf $data_list {

	variable _tag [$tree createElement [lindex $leaf 0]]

	if {[llength $leaf] != 1} {

	foreach _par [lrange $leaf 1 end] { 

			$_tag setAttribute [lindex $_par 0] [lindex $_par 1]

			}

	}


	$node appendChild $_tag
	}

	$root appendChild $node; puts [$root asXML] }


variable testit	{

		{rect {x 1cm} {y 1cm} {width 1cm} {height 1cm}}
		{rect {x 10mm} {y 5mm} {width 1.05cm} {height 2.04cm}}

		}

plist {20cm 30cm} $testit

}

package provide svgdom 0.01

# Copyright (C) Carlos A. R. de Souza, 12/27/2008,12/28/2008
# This file can be distributed under the ISC license.

package require Ttk
package require msgcat

namespace import ::msgcat::*

set internal_path [file normalize [file dirname [info script]]]
mcload [file join ${::internal_path} {Translation catalogs}]

#This is useful is this program is running from a starkit.
variable ttk_dialog_module_internal_path [file dirname [info script]]

#Default return value.
set ::ttk_message_box_return_value "ok"


namespace eval ::ttk::dialog_module {
	variable icon_path [file join $ttk_dialog_module_internal_path "Icons/"]
	variable invalid_default_button_error [mc "Invalid default button \"%s\"."]
	variable italic_font [font create ttk_message_dialog_Italic_font {*}[font actual TkDefaultFont] -slant italic]
	variable unrecognized_parameter [mc "Unrecognized parameter: %s"]
	variable unrecognized_parameter_input [mc "Unrecognized input for %s parameter."]
	variable window_icon ""
	variable window_name ""
}

namespace eval ::ttk::dialog_module::paths {
	variable error_icon [file join ${::ttk::dialog_module::icon_path} dialog-error.png]
	variable information_icon [file join ${::ttk::dialog_module::icon_path} dialog-information.png]
	variable question_icon [file join ${::ttk::dialog_module::icon_path} dialog-question.png]
	variable warning_icon [file join ${::ttk::dialog_module::icon_path} dialog-warning.png]
}

proc ::ttk::centralize_window {window_widget} {
	
	wm withdraw $window_widget
	update 
	
	set total_height [winfo screenheight .]
	set total_width [winfo screenwidth .]
	
	set window_height [winfo reqheight $window_widget]
	set window_width [winfo reqwidth $window_widget]
	
	
	set height_center [ expr ($total_height - $window_height) /2]
	set width_center [ expr ($total_width - $window_width) / 2]
	
	wm geometry  $window_widget ${window_width}x${window_height}+$width_center+$height_center
	wm deiconify $window_widget
}

proc ::ttk::messageBox args {
	
	switch ${::tcl_platform(platform)} {
		unix {
			ttk::unix_messageBox {*}$args
		}
		default {
			tk_messageBox {*}$args
		}
	}
}

proc ::ttk::unix_messageBox args {
	variable ::ttk::dialog_module::unrecognized_parameter
	variable ::ttk::dialog_module::unrecognized_parameter_input
	variable ::ttk::dialog_module::window_name
	
	set detail_string {}
	set message_string {}

	set symbolic_button_name {}
	set window_icon_type info
	set window_identifier [expr int(rand() * 10000)]
	set window_name .window_${window_identifier}
	set window_title {}
	
	#What kind of buttons will be grid?
	set grid_type ok
	set default_button {}
	set index 0
	set last_item [llength $args]
	
	for {set index 0} {$index < $last_item} {set index [expr $index + 2]} {
		set token [lindex $args $index]
		set parameter [lindex $args [expr $index + 1]]
		
		switch $token {
			-default {
				set default_button [validate_parameter $parameter {ok abort retry ignore yes no}]
			} 
			-detail {
				set detail_string $parameter
			} 
			-icon {
				set window_icon_type [validate_parameter $parameter {error info question warning}]
			} 
			-message {
				set message_string $parameter
			} 
			-parent {
				if {$parameter != "."} {
					set window_name ${parameter}.window_${window_identifier}
				}
			} 
			-title {
				set window_title $parameter
			} 
			-type {
				set grid_type [ \
					validate_parameter \
					$parameter \
					{abortretryignore ok okcancel retrycancel yesno yesnocancel}
				]
			} 
			default {
				error [format $unrecognized_argument $token]
			}
		}
	}
	
	if {$default_button != ""} {
		if {![::ttk::unix_messageBox_check_default_parameter $default_button]} {
			return
		}
	}
		
	::ttk::unix_messageBox_draw \
		$window_icon_type \
		$window_title \
		$message_string \
		$detail_string \
		$grid_type \
		$default_button 
		
	return ${::ttk_message_box_return_value}
}

#Checks if the -default parameter, if set, is set correctly
proc ::ttk::unix_messageBox_check_default_parameter {default_button} {
	variable ::ttk::dialog_module::invalid_default_button_error 
	set ok 1
	
	if {!($default_button in {ok yes no cancel ignore abort retry})} {
		return -code error [format  $invalid_default_button_error $default_button]
	}
	return $ok
}

proc ::ttk::unix_messageBox_draw { \
	window_icon_type \
	window_title \
	message_text \
	details_text \
	grid_type \
	default_focus \
} {
	variable ::ttk::dialog_module::window_icon
	variable ::ttk::dialog_module::window_name
	variable ::ttk::dialog_module::italic_font
	variable ::ttk::dialog_module::paths::error_icon
	variable ::ttk::dialog_module::paths::information_icon
	variable ::ttk::dialog_module::paths::question_icon
	variable ::ttk::dialog_module::paths::warning_icon
	
	set vertical_padding {0i 0.20i}
	
	toplevel $window_name 
	wm title $window_name $window_title
	
	ttk::frame $window_name.top_frame -padding 3
		
	switch $window_icon_type {
		error {
			set window_icon [image create photo -file $error_icon]
		}
		info {
			set window_icon [image create photo -file $information_icon]
		}
		question {
			set window_icon [image create photo -file $question_icon]
		}
		warning {
			set window_icon [image create photo -file $warning_icon]
		}
		default {
			set window_icon [image create photo -file $information_icon]
		}
	}
	
	if {$details_text != ""} {
		label $window_name.top_frame.details_label -text "${details_text}\n" \
		-font $italic_font
	} \
	else {
		label $window_name.top_frame.details_label -text {}
	}
	
	ttk::label $window_name.top_frame.icon_label -image $window_icon
	ttk::label $window_name.top_frame.message_label -text $message_text
	ttk::frame $window_name.top_frame.button_frame 
	
	#First set of buttons: abort, retry and ignore.
	button $window_name.top_frame.button_frame.abort_button \
	-text [mc "Abort"] -width 10 -command {::ttk::unix_messageBox_quit "abort"}
	 
	
	button $window_name.top_frame.button_frame.ignore_button \
	-text [mc "Ignore"] -width 10 -command {::ttk::unix_messageBox_quit "ignore"}
	
	button $window_name.top_frame.button_frame.retry_button \
	-text [mc "Retry"] -width 10 -command {::ttk::unix_messageBox_quit "retry"}
	
	#Second set of buttons: yes and no.
	button $window_name.top_frame.button_frame.yes_button \
	-text [mc "Yes"] -width 10 -command {::ttk::unix_messageBox_quit "yes"}
	
	
	button $window_name.top_frame.button_frame.no_button \
	-text [mc "No"] -width 10 -command {::ttk::unix_messageBox_quit "no"}
	
	
	#Third set of buttons: ok and cancel.
	button $window_name.top_frame.button_frame.ok_button \
	-text [mc "Ok"] -width 10 -command {::ttk::unix_messageBox_quit "ok"}
	
	button $window_name.top_frame.button_frame.cancel_button \
	-text [mc "Cancel"] -width 10 -command  {::ttk::unix_messageBox_quit "cancel"}
	
	grid $window_name.top_frame -row 0 -column 0 -sticky news 
	grid $window_name.top_frame.icon_label -row 0 -column 0 
	grid $window_name.top_frame.message_label -row 0 -column 1
	grid $window_name.top_frame.details_label -row 1 -column 1 -sticky w
	grid $window_name.top_frame.button_frame -row 2 -column 0 -columnspan 2
	
	switch $grid_type {
		abortretryignore {
			grid $window_name.top_frame.button_frame.abort_button -row 0 -column 0  -pady $vertical_padding
			grid $window_name.top_frame.button_frame.retry_button -row 0 -column 1  -pady $vertical_padding
			grid $window_name.top_frame.button_frame.ignore_button -row 0 -column 2  -pady $vertical_padding
		} 
		ok {
			grid $window_name.top_frame.button_frame.ok_button -row 0 -column 0 \
			-sticky we -padx 5 -pady $vertical_padding
		} 
		okcancel {
			grid $window_name.top_frame.button_frame.ok_button -row 0 -column 0 -pady $vertical_padding
			grid $window_name.top_frame.button_frame.cancel_button -row 0 -column 1  -pady $vertical_padding
		} 
		retrycancel {
			grid $window_name.top_frame.button_frame.retry_button -row 0 -column 0  -pady $vertical_padding
			grid $window_name.top_frame.button_frame.cancel_button -row 0 -column 1  -pady $vertical_padding
		} 
		yesno {
			grid $window_name.top_frame.button_frame.yes_button -row 0 -column 0 -pady $vertical_padding
			grid $window_name.top_frame.button_frame.no_button -row 0 -column 1  -pady $vertical_padding
		} 
		yesnocancel {
			grid $window_name.top_frame.button_frame.yes_button -row 0 -column 0  -pady $vertical_padding
			grid $window_name.top_frame.button_frame.no_button -row 0 -column 1 -pady $vertical_padding
			grid $window_name.top_frame.button_frame.cancel_button -row 0 -column 2  -pady $vertical_padding
		}
	}
	
	switch $default_focus {
		ok {
			focus  $window_name.top_frame.button_frame.ok_button
		} 
		cancel {
			focus  $window_name.top_frame.button_frame.cancel_button
		} 
		abort {
			focus  $window_name.top_frame.button_frame.abort_button
		}
		retry {
			focus  $window_name.top_frame.button_frame.retry_button
		}
		ignore {
			focus  $window_name.top_frame.button_frame.ignore_button
		}
		yes {
			focus  $window_name.top_frame.button_frame.yes_button
		}
		no {
			focus  $window_name.top_frame.button_frame.no_button
		}
		cancel {
			focus  $window_name.top_frame.button_frame.cancel_button
		}
	}
	::ttk::centralize_window $window_name
	
	wm protocol $window_name WM_DELETE_WINDOW  {::ttk::unix_messageBox_quit "ok"}
	vwait ::ttk_message_box_return_value
}

#Check if parameter is any of the list, and if so, returns it.
proc ::ttk::validate_parameter {input_parameter input_list} {
	variable ::ttk::dialog_module::unrecognized_parameter_input 
	
	if {!($input_parameter in $input_list)} {
		return -code error [format $unrecognized_parameter_input $input_parameter]
	}
	
	return $input_parameter
}

proc ::ttk::unix_messageBox_quit {return_value} {
	variable ::ttk::dialog_module::window_name
	
	set ::ttk_message_box_return_value $return_value
	
	if {[info exist window_name]} {
		destroy $window_name
	}
	
	if {[info exist ${::ttk::dialog_module::window_icon}]} {
		image delete ${::ttk::dialog_module::window_icon}
	}
	return
}
@tool
extends EditorPlugin

var control := MarginContainer.new()
var panel: Control
var default_parent: Control

func _enter_tree():
	var script_editor := EditorInterface.get_script_editor()
	script_editor.editor_script_changed.connect(on_script_changed)
	
	default_parent = script_editor.get_child(0).get_child(1)
	panel = default_parent.get_child(0)
	panel.reparent(control)
	
	control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	control.size_flags_vertical = Control.SIZE_EXPAND_FILL
	control.name = "Scripts"
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, control)

func on_script_changed(scr: Script):
	var parent: TabContainer = control.get_parent()
	parent.current_tab = control.get_index()

func _exit_tree():
	panel.reparent(default_parent)
	default_parent.move_child(panel, 0)
	remove_control_from_docks(control)

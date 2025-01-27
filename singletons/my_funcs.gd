extends Node

#gets a list of all the children of a parent in a given group
func get_children_in_group(Parent, GroupName):
	var wanted = []
	
	var all = Parent.get_children()
	for i in all:
		if i.is_in_group(GroupName):
			wanted.append(i)
			
	return wanted

# gets the first parent of a sceen that s in a particular group
func get_fst_parent_in(child, group):
	var parent = child.get_parent()
	while not parent.is_in_group(group):
		child = parent
		parent = child.get_parent()
		
		if parent == null:
			break
	return parent


func get_child_w_var_equals(Parent, Var, X):
	var children = Parent.get_children()
	for i in children:
		if Var in i:
			if i.Var == X:
				return i
				break

extends GridContainer

func unselectButtons(selectedButton):
	for child in get_children():
		if child != selectedButton:
			child.unselectButton()

func setItem(pieceName):
	for child in get_children():
		if child.getName() == pieceName:
			child.setItem()

extends GridContainer

func unselectButtons(selectedButton):
	for child in get_children():
		if child != selectedButton:
			child.unselectButton()

func unselectPreviews(selectedButton):
	for child in get_children():
		if child != selectedButton:
			child.unselectPreview()

func setItem(pieceName):
	for child in get_children():
		if child.getName() == pieceName:
			child.setItem()

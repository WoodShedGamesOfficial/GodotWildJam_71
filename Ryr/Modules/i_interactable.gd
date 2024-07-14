extends Area2D

class_name IInteractable

signal on_interacted

func interact(interactor : Node2D) :
	print("You interact with this")
	on_interacted.emit()

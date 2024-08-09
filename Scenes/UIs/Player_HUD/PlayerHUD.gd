extends Control
@onready var full_heart = preload("res://Assets/Sprites/Full_Heart.png")
@onready var empty_heart = preload("res://Assets/Sprites/Empty_Heart.png")
@onready var full_charge = preload("res://Assets/Sprites/Full_Charge.png")
@onready var empty_charge = preload("res://Assets/Sprites/Empty_Charge.png")
@export var player : CharacterBody3D

func _process(delta):
	match player.hp:
		0:
			$Hearts/HeartContainer1/Heart1.texture = empty_heart
			$Hearts/HeartContainer2/Heart2.texture = empty_heart
			$Hearts/HeartContainer3/Heart3.texture = empty_heart
		1:
			$Hearts/HeartContainer1/Heart1.texture = full_heart
			$Hearts/HeartContainer2/Heart2.texture = empty_heart
			$Hearts/HeartContainer3/Heart3.texture = empty_heart
		2:
			$Hearts/HeartContainer1/Heart1.texture = full_heart
			$Hearts/HeartContainer2/Heart2.texture = full_heart
			$Hearts/HeartContainer3/Heart3.texture = empty_heart
		3:
			$Hearts/HeartContainer1/Heart1.texture = full_heart
			$Hearts/HeartContainer2/Heart2.texture = full_heart
			$Hearts/HeartContainer3/Heart3.texture = full_heart
	if(player.has_device):
		match player.charges:
			0:
				$Charges/ChargeContainer1/Charge1.texture = empty_charge
				$Charges/ChargeContainer2/Charge2.texture = empty_charge
				$Charges/ChargeContainer3/Charge3.texture = empty_charge
			1:
				$Charges/ChargeContainer1/Charge1.texture = full_charge
				$Charges/ChargeContainer2/Charge2.texture = empty_charge
				$Charges/ChargeContainer3/Charge3.texture = empty_charge
			2:
				$Charges/ChargeContainer1/Charge1.texture = full_charge
				$Charges/ChargeContainer2/Charge2.texture = full_charge
				$Charges/ChargeContainer3/Charge3.texture = empty_charge
			3:
				$Charges/ChargeContainer1/Charge1.texture = full_charge
				$Charges/ChargeContainer2/Charge2.texture = full_charge
				$Charges/ChargeContainer3/Charge3.texture = full_charge
	
	

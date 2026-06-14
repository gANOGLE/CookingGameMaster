extends Label
@onready var score: Label = $"."

func _process(delta: float) -> void:
	if Global.score != 0:
		add_theme_color_override("font_outline_color", Color.WHITE)
		add_theme_constant_override("outline_size", 4)
		if Global.score > 200:
			text = 'Could be better.. :('
			score.set("theme_override_colors/font_color", Color.CRIMSON)
		elif Global.score > 100:
			text = 'Meh.'
			score.set("theme_override_colors/font_color", Color.ORANGE)
		elif Global.score > 50:
			text = 'Good!'
			score.set("theme_override_colors/font_color", Color.SEA_GREEN)
		elif Global.score > 30:
			text = 'Great!'
			score.set("theme_override_colors/font_color", Color.ROYAL_BLUE)
		elif Global.score > 20:
			text = 'Amazing!'
			score.set("theme_override_colors/font_color", Color.LIGHT_YELLOW)
		else:
			text = 'PERFECT!!!'
			score.set("theme_override_colors/font_color", Color.PURPLE)

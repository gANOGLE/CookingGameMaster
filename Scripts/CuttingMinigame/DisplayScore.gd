extends Label
@onready var score: Label = $"."

func _process(_delta: float) -> void:
	if Global.score != 0:  
		add_theme_color_override("font_outline_color", Color.WHITE)
		add_theme_constant_override("outline_size", 4)
		if Global.score == 999:
			text = 'you...missed'
			score.set("theme_override_colors/font_color", Color.CRIMSON)
		elif Global.score > 125:
			text = 'could be better..:('
			score.set("theme_override_colors/font_color", Color.CRIMSON)
		elif Global.score > 75:
			text = 'Meh.'
			score.set("theme_override_colors/font_color", Color.ORANGE)
		elif Global.score > 45:
			text = 'Good!'
			score.set("theme_override_colors/font_color", Color.SEA_GREEN)
		elif Global.score > 25:
			text = 'Great!'
			score.set("theme_override_colors/font_color", Color.ROYAL_BLUE)
		elif Global.score > 10:
			text = 'Amazing!'
			score.set("theme_override_colors/font_color", Color.YELLOW)
		else:
			text = 'PERFECT! :D'
			score.set("theme_override_colors/font_color", Color.PURPLE)
	else:
		add_theme_color_override("font_outline_color", Color.WHITE)
		add_theme_constant_override("outline_size", 4)
		text = 'That was...'
		score.set("theme_override_colors/font_color", Color.BLACK)

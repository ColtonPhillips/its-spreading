extends Control

@export var bg_color : Color = Color.BLACK
@export var to_scene : PackedScene = null
@export var title_color := Color.BLUE_VIOLET
@export var text_color := Color.WHITE
@export var title_font : FontFile = null
@export var text_font : FontFile = null
@export var Music : AudioStream = null
@export var Use_Video_Audio : bool = false
@export var Video : VideoStream = null

const section_time := 2.0
const line_time := 1
const base_speed := 32
const speed_up_multiplier := 1.5

var scroll_speed : float = base_speed
var speed_up := false

@onready var colorrect := $ColorRect
@onready var videoplayer := $VideoStreamPlayer
@onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"A game by 'Team Workshy'",
		"",
		"",
		
	],[
		"We are...",
		"",
		"",
		"",
		"Colton Phillips",
		"Rose Dubord-Goulet",
		"Lee Gauthier",
		"Boyad Hollingshead",
		"Scott Hannan"
	],[
		"Original Story",
		"Colton Phillips"
	],[
		"Lead Programmer",
		"Colton Phillips"
	],[
		"Lead Artist",
		"Rose Dubord-Goulet"
	],[
		"Game Design",
		"Rose Dubord-Goulet",
		"Colton Phillips"
	],[
		"Music and Sound By",
		"Lee Gauthier"
	],[
		"Additional Programming",
		"Boyad Hollingshead",
		"Scott Hansan",
		"",
		"",
		"",		
	],[
		"Submitted for your approval",
		"This game was developed in ",
		"330 hours for the 2024",
		"'Pirate Software Game Jam'",
		"",
	],[
		"MIT Open Source Authors",
		"CREDITS - Copyright",
		"  (c) 2019 Ben Bishop",
		"https://github.com/",
		"  Draconis-25/AG-Credits",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
	],[
		"In Memorial",
		"",
		"",
		"",
		"моя мама",
		"",
		"",
		"",
		"Mon ami",
		"",
		"",
		"",
		"ᓵᑭᐦᐃᑐᐃᐧᐣ",
		"(sakihitowin)",
		"",
		"",
		"",
		"And to my crokinole partner:"
	],[
		"In Love",
		"",
		"",
		"",
		"Becky Phillips",
		"Oct 18 1962 - Mar. 3 2023",
		""
	]
]

func _ready():
	shader_material = sprite_2d.material as ShaderMaterial
	colorrect.color = bg_color
	videoplayer.set_stream(Video)
	if !Use_Video_Audio:
		var stream = AudioStreamPlayer.new()
		stream.set_stream(Music)
		add_child(stream)
		videoplayer.set_volume_db(-80)
		stream.play()
	else:
		videoplayer.set_volume_db(0)
	videoplayer.play()
	

var shader_material : ShaderMaterial
@onready var sprite_2d = $ColorRect/Sprite2D

func _process(delta):
	shader_material.set_shader_parameter("time", Time.get_ticks_msec() / 8000.0)
	
	scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.set_global_position(l.get_global_position() - Vector2(0, scroll_speed))
			if l.get_global_position().y < l.get_line_height() - 30:
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		if to_scene != null:
			var path = to_scene.get_path()
			get_tree().change_scene_to_file(path)
		else:
			get_tree().quit()


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		if title_font != null:
			new_line.set("theme_override_fonts/font", title_font)
		new_line.set("theme_override_colors/font_color", title_color)
	
	else:
		if text_font != null:
			new_line.set("theme_override_fonts/font", text_font)
		new_line.set("theme_override_colors/font_color", text_color)
	
	new_line.position.snapped(Vector2.ONE)
	
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false


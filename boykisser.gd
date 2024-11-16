extends Node

var drag_offset : Vector2
var dragging := false
var kisses := 0
var music := false


func _process(delta):
	if dragging == true:
		get_window().position += Vector2i(get_window().get_mouse_position() - drag_offset)

func _on_music_button_pressed():
	music = !music
	if music == false:
		$Control/MusicButton.texture_normal = load("res://2d-assets/ui-buttons/music-off.png")
		$SongPlayer.stop()
	else:
		$Control/MusicButton.texture_normal = load("res://2d-assets/ui-buttons/music.png")
		$SongPlayer.play()
	
func _on_kiss_button_pressed():
	$MeowPlayer.play()
	$Boykisser.frame = 0
	$Boykisser.play("happy")
	kisses += 1
	if (randi()%20)+5 < kisses:
		kisses = 0
		$HeartParticles.restart()
	

func _on_move_button_button_down():
	drag_offset = get_window().get_mouse_position()
	dragging = true


func _on_move_button_button_up():
	dragging = false


func _on_close_button_pressed():
	$Boykisser.play("byebye")


func _on_boykisser_animation_finished():
	if $Boykisser.animation == "byebye":
		get_tree().quit()

func _on_song_player_finished():
	if music == true:
		$SongPlayer.play()

func _on_meow_player_finished():
	var n = (randi() % 4) + 1
	$MeowPlayer.stream = load("res://audio-assets/meow." + str(n) + ".mp3")

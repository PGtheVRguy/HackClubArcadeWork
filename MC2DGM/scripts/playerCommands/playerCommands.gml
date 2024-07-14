function tp(_x, _y)
{
	obj_player.x = _x
	obj_player.y = _y
	return $"Teleported to {_x},{_y}"
}

function setSpeed(_spd)
{
	obj_player.walk_spd = _spd
	return $"Set speed to {_spd}"
}

function help()
{
	show_debug_message("tp x, y -- Teleports the player")
	show_debug_message("setSpeed speed -- Sets the player speed")
	return "Help page 1/1"
}
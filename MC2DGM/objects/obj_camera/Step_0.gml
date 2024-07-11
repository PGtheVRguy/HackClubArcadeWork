
/*
if(keyboard_check(ord("A")))
{
	x -= moveSpeed;
}

if(keyboard_check(ord("D")))
{
	x += moveSpeed;
}

if(keyboard_check(ord("W")))
{
	y -= moveSpeed;
}

if(keyboard_check(ord("S")))
{
	y += moveSpeed;
}*/



if(keyboard_check_pressed(ord("R")))
{
	randomize()
	show_debug_message($"NEW CHUNKS: {random_get_seed()}")
	ds_map_clear(global.chunks)
}

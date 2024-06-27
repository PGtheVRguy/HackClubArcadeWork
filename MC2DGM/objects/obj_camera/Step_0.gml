

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
}
if(keyboard_check_pressed(ord("R")))
{
	ds_map_clear(global.chunks)
}



hsp = (input_check("right") - input_check("left")) * walk_spd
vsp = (input_check("down") - input_check("up")) * walk_spd

x += hsp;
y += vsp;

/*
if(input_check_pressed("lclick"))
{
	placeTile(1,mouse_x,mouse_y)
}
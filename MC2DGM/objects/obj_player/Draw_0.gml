

var _spd = abs(hsp)+abs(vsp);


if(abs(_spd) > 0)
{
	spr += 0.05;
	if(spr > 3)
	{
		spr = 1;
	}
	if(spr < 1)
	{
		spr = 1;
	}
}
else
{
	spr = 0;
}


if(hsp > 0)
{
	dir = 1;
}
if(hsp < 0)
{
	dir = -1;
}


draw_sprite_ext(spr_player, spr, x, y, dir, 1, 0, -1, 1)





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

draw_sprite(spr_gui_outline, 0, snap(mouse_x-8), snap(mouse_y-8))


if(snap(mouse_x-8) != lastCursorPos[0])
{
	breakTime = 0
}
if(snap(mouse_y-8) != lastCursorPos[1])
{
	breakTime = 0
}


if(input_check("rclick"))
{
	breakTime++
	
	var _ti = getTile(snapChunkPos(mouse_x-8), snapChunkPos(mouse_y-8))
	
	
	try
	{
		var _timeToBreak = _ti.hardness*60
	
	
	//show_debug_message($"Mining at"

		if(_ti.hardness != 0)
		{
			draw_sprite(spr_gui_breaking, (breakTime/_timeToBreak)*8, snap(mouse_x-8), snap(mouse_y-8))
			if(breakTime > _timeToBreak)
			{
				placeTile(obj_tiles.ti_air, mouse_x, mouse_y, 1)
				var _it = variable_instance_get(obj_tiles, _ti.drop)
				addInventory(_it)
				//ds_grid_set(global.inventory, 0, 0, _it)
				show_debug_message(_it)
			
			}
		}
	}
	catch(_exception)
	{
		
	}


}
else
{
	breakTime = 0
}



lastCursorPos[0] = snap(mouse_x-8)
lastCursorPos[1] = snap(mouse_y-8)



//debug//*/*
/*
#region debug
var _t = getTile(snapChunkPos(mouse_x-8),snapChunkPos(mouse_y-8))
draw_text(x,y,$"x:{snapChunkPos(mouse_x-8)},y:{snapChunkPos(mouse_y-8)},\ntile:{_t}")


#endregion


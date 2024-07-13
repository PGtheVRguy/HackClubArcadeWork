drawHotbar(currentItem)

if(mouse_wheel_up())
{
	currentItem++;
}
if(mouse_wheel_down())
{
	currentItem--;
}
if(currentItem > 9)
{
	currentItem = 1;
}
if(currentItem = 0)
{
	currentItem = 9;
}



if(input_check_pressed("inventory"))
{
	if(invOpen = false)
	{
		invOpen = true
	}
	else
	{
		invOpen = false
	}
}

if(invOpen)
{
	#region crafting
	
	for(i = 0; i < 10; i++)
	{
		var _fr = isEven(i)
		draw_sprite(spr_gui_craftSel, _fr, ((guiWidth()/2)+8), (32+16) + ((sprite_get_height(spr_gui_craftSel) - 1)*i))
	}
	
	#endregion
	
	
	
	
	draw_sprite(spr_gui_inv,0, guiWidth()/2, 32)
	
	var _x = guiWidth()/2
	var _y = 32
	
	//draw_sprite(spr_items,0,_x-87, _y+98)
	
	var _cx = 0
	var _cy = 1
	
	repeat(ds_grid_width(global.inventory) * (ds_grid_height(global.inventory)-1))
	{
		
		if(_cx > ds_grid_width(global.inventory)-1)
		{
			_cx = 0
			_cy += 1
		}
		
		
		if(ds_grid_get(global.inventory, _cx, _cy) != 0)
		{
			var _i = ds_grid_get(global.inventory, _cx, _cy)
			draw_sprite(spr_items, _i.sprite, (guiWidth()/2-87)+(_cx*16)+(_cx*5), ((_cy-2)*21)+_y+98)
			
			
		}
		//draw_sprite(spr_items, 0, (guiWidth()/2-87)+(_cx*16)+(_cx*5), ((_cy-2)*21)+_y+98)
		_cx++
		
	}
	invBlur = lerp(invBlur, 10, 0.05)
	
}
else
{
	invBlur = lerp(invBlur, 0, 0.08)
}

fx_set_parameter(_fxInvBlur, "g_RecursiveBlurRadius", invBlur); //10 is max
layer_set_fx("effect", _fxInvBlur)
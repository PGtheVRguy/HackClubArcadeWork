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
	

	
	for(i = 0; i < ds_list_size(global.recipeList); i++)
	{
		var _fr = isEven(i)
		
		var _itPosX = ((guiWidth()/2)+8)
		var _itPosY = (32+16) + ((sprite_get_height(spr_gui_craftSel) - 1)*i)
		
		
		var _wid = sprite_get_width(spr_gui_craftSel)
		var _hei = sprite_get_height(spr_gui_craftSel)
		
		
		draw_sprite(spr_gui_craftSel, _fr, _itPosX, _itPosY)
		
		

		
		
		
		var _recipe = ds_list_find_value(global.recipeList, i)
		
		
		if(mouseAt(_itPosX+(_wid/2), _itPosY+(_hei/2), _wid/2, _hei/2))
		{
			draw_sprite(spr_gui_craftSel, 2, _itPosX, _itPosY)
			if(input_check_pressed("lclick"))
			{
				craft(_recipe)
			}
		}
		
		draw_sprite(spr_items, _recipe[0].sprite, _itPosX+10, _itPosY+8)
		var _f = 1
		repeat(array_length(_recipe)-1)
		{
			draw_sprite(spr_items, _recipe[_f].sprite, _itPosX+sprite_get_width(spr_gui_craftSel)-(20*_f), _itPosY+8)
			_f++
		}
		
		
		
		
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
		if(mouseAt((guiWidth()/2-87)+(_cx*16)+(_cx*5), ((_cy-2)*21)+_y+98+21, 8, 8))
		{
			if(input_check_pressed("lclick"))
			{
				if(ds_grid_get(global.inventory, _cx, _cy) != pickedItem)
				{
					var _pi = pickedItem
					pickedItem = ds_grid_get(global.inventory, _cx, _cy+1)
					ds_grid_set(global.inventory, _cx, _cy+1, _pi)
					show_debug_message(pickedItem)
					
				}
				else
				{
					ds_grid_set(global.inventoryCount, _cx, _cy+1, ds_grid_get(global.inventoryCount, _cx, _cy+1) +1)
				}
				
			}
		}
		if(pickedItem != 0)
		{
			draw_sprite(spr_items, pickedItem.sprite, mouseX(), mouseY())
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
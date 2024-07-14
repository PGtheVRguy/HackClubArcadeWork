function guiWidth()
{
	return display_get_gui_width()
}
function guiHeight()
{
	return display_get_gui_height()
}

function drawHotbar(_ci)
{
	var _size = 9
	var _spr = spr_gui_hotbar
	
	var _initX = (guiWidth()/2)-(sprite_get_width(_spr)*9)/2
	
	var _rep = 0
	var _x = 0
	var _y = guiHeight()-32
	repeat(_size)
	{
		_x = _initX + _rep*16
		draw_sprite(spr_gui_hotbar, 0, _x, _y)
		
		var _it = ds_grid_get(global.inventory, _rep, 0)
		var _ic = ds_grid_get(global.inventoryCount, _rep, 0)
		
		if(_it != 0)
		{
			draw_sprite(spr_items, _it.sprite, _x, _y)
			draw_text(_x,_y,_ic)
		}
		if(mouseAt(_x, _y, 7, 7) && (obj_player.invOpen))
		{
			obj_player.pickedItem = inventoryManagement(_rep, 0, obj_player.pickedItem)
		}
		
		_rep++
	}
	
	draw_sprite(spr_gui_hotbar, 1, _initX + 16*(currentItem-1), _y)
	
	/*for(var _i = _initX; _i < _size; _i += 16)
	{
		draw_sprite(spr_gui_hotbar, 0, _i, guiHeight()-32)
	}*/
	
	
}

function inventoryManagement(_cx, _cy, pickedItem)
{
	if(input_check_pressed("lclick"))
	{
		
		if(pickedItem = 0)
		{
			var _it = ds_grid_get(global.inventory, _cx, _cy)
			if(ds_grid_get(global.inventoryCount, _cx, _cy) = 1)
			{
				ds_grid_set(global.inventory, _cx, _cy, 0)
				ds_grid_set(global.inventoryCount, _cx, _cy, 0)
			}
			else
			{
				ds_grid_set(global.inventoryCount, _cx, _cy, ds_grid_get(global.inventoryCount, _cx, _cy) - 1)
			}
			pickedItem = _it
		}
		else
		{
			if(ds_grid_get(global.inventory, _cx, _cy) = pickedItem)
			{
				ds_grid_set(global.inventoryCount, _cx, _cy, ds_grid_get(global.inventoryCount, _cx, _cy) +1)
				pickedItem = 0
			}
			else
			{
				ds_grid_set(global.inventory, _cx, _cy, pickedItem)
				ds_grid_set(global.inventoryCount, _cx, _cy, 1)
				
				pickedItem = 0
			}
		}

	}
	return pickedItem
}
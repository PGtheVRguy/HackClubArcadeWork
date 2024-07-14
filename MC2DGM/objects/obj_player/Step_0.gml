
if(!invOpen)
{
	hsp = (input_check("right") - input_check("left")) * walk_spd
	vsp = (input_check("down") - input_check("up")) * walk_spd
}
else
{
	hsp = 0
	vsp = 0
}
x += hsp;
y += vsp;


if(input_check_pressed("lclick") && (!invOpen))
{
	

	
	var _item = ds_grid_get(global.inventory, currentItem-1, 0)
	var _count = ds_grid_get(global.inventoryCount, currentItem-1, 0)
	
	
	if(_item != 0)
	{
		var _pl = variable_instance_get(obj_tiles, _item.place)
		ds_grid_set(global.inventoryCount, currentItem-1, 0, _count-1)
		if(_count-1 = 0)
		{
			ds_grid_set(global.inventory, currentItem-1, 0, 0)
		}
		placeTile(_pl,mouse_x,mouse_y)
		
	}
}
ds_grid_set(global.inventory, 3, 3, obj_tiles.ti_dirt)
ds_grid_set(global.inventoryCount, 3, 3, 1)
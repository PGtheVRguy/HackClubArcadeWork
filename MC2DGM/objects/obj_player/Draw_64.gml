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


/*
#region debug

var _it = ds_grid_get(global.inventory, 0, 0)

if(_it != 0)
{
	draw_sprite(spr_items, _it.sprite, 20, 20)
}

#endregion
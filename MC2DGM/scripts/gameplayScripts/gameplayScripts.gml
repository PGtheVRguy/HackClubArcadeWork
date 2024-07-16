function createTiles()
{
	ti_air =
	{
		sprite : 0,
		drop: "it_air",
		hardness: 0,
		name: "Air"
	}
	ti_grass = 
	{
		sprite: 1,
		drop: "it_dirt",
		hardness: 1.5,
		name: "Grass"
	}
	ti_dirt = 
	{
		sprite: 2,
		drop: "it_dirt",
		hardness: 1,
		name: "Dirt"
	}
	ti_sand =
	{
		sprite: 3,
		drop: "it_sand",
		hardness: 1,
		name: "Sand"
	}
	ti_water =
	{
		sprite: 4,
		drop: "it_water",
		hardness: 0,
		name: "Water"
	}
	ti_stone =
	{
		sprite: 5,
		drop: "it_stone",
		hardness: 3,
		name: "Stone"
	}
	ti_log =
	{
		sprite: 6,
		drop: "it_log",
		hardness: 2,
		name: "Log"
	}
	ti_wood =
	{
		sprite: 8,
		drop: "it_wood",
		hardness: 2,
		name: "Wood Planks"
	}
	ti_leaves =
	{
		sprite: 7,
		drop: "it_unobainable",
		hardness: 1,
		name: "Leaves"
	}
	ti_ironOre =
	{
		sprite: 9,
		drop: "it_iron",
		hardness: 2,
		name: "Iron Ore"
	}
	ti_goldOre =
	{
		sprite: 10,
		drop: "it_gold",
		hardness: 3,
		name: "Gold Ore"
	}
	ti_diamondOre =
	{
		sprite: 11,
		drop: "it_diamond",
		hardness: 4,
		name: "Diamond Ore"
	}
	
}


function createItems()
{
	
	it_dirt =
	{
		sprite: 0,
		name: "Sludge of Dirt",
		place: "ti_dirt"
		
	}
	it_sand =
	{
		sprite: 2,
		name: "Pile of Sand",
		place: "ti_sand"
		
	}
	it_stone =
	{
		sprite: 1,
		name: "Rock",
		place: "ti_stone"
		
	}
	it_log =
	{
		sprite: 3,
		name: "Log Scrap",
		place: "ti_log"
		
	}
	it_wood =
	{
		sprite: 4,
		name: "Wood Planks",
		place: "ti_wood"
		
	}
	it_iron =
	{
		sprite: 8,
		name: "Iron",
		place: "ti_air"
		
	}
	it_gold =
	{
		sprite: 9,
		name: "Gold",
		place: "ti_air"
		
	}
	it_diamond =
	{
		sprite: 10,
		name: "Diamond",
		place: "ti_air"
		
	}
	it_ironPick =
	{
		sprite: 5,
		name: "Iron Pickaxe",
		place: "ti_air",
		tool: 1.5
		
	}
	it_goldPick =
	{
		sprite: 6,
		name: "Gold Pickaxe",
		place: "ti_air",
		tool: 2
		
	}
	it_diamondPick =
	{
		sprite: 7,
		name: "Diamond Pickaxe",
		place: "ti_air",
		tool: 2.5
	}
	it_unobainable =
	{
		sprite: 1,
		name: "Unobtainable",
		place: "ti_air"
		
	}
}

function createRecipes()
{
	
	//RECIPES ARE ARRAYS! FIRST ITEM IS THE OUTPUT, THE REST ARE INPUTS!
	//re_sand = [it_sand, it_dirt, it_stone]//DEBUG
	//re_stone = [it_stone, it_dirt]//DEBUG
	re_wood = [it_wood, it_log]
	re_ironPick = [it_ironPick, it_wood, it_iron, it_iron]
	re_goldPick = [it_goldPick, it_wood, it_gold, it_gold]
	re_diamondPick = [it_diamondPick, it_wood, it_diamond, it_diamond]
}


function snap(_val)
{
	return (round(_val/16))*16
}
function snapChunkPos(_val)
{
	var _i = (round(_val/16))*16
	
	if(_i < 0)
	{
		_i += 0;
	}
	return _i
	
	
}


function addInventory(_item)
{
	
	if(_item = obj_tiles.it_unobainable)
	{
		return false
	}
	
	var _x = 0
	var _y = 0
	repeat(ds_grid_width(global.inventory) * ds_grid_height(global.inventory))
	{
		
		
		if(_x > ds_grid_width(global.inventory))
		{
			_x = 0
			_y++;
		}
		
		if(ds_grid_get(global.inventory,_x,_y) == 0)
		{
			ds_grid_set(global.inventory, _x, _y, _item)
			ds_grid_set(global.inventoryCount, _x, _y, 1)
			return true;
		}
		
		if(ds_grid_get(global.inventory,_x,_y) == _item)
		{
			var _c = ds_grid_get(global.inventoryCount, _x, _y)
			ds_grid_set(global.inventoryCount, _x, _y, _c+1)
			return true;
		}
		
		
		
		
		_x++
	}
	return false;
}
function removeInventory(_item)
{
	var _x = 0
	var _y = 0
	repeat(ds_grid_width(global.inventory) * ds_grid_height(global.inventory))
	{
		
		
		if(_x > ds_grid_width(global.inventory))
		{
			_x = 0
			_y++;
		}
		
		if(ds_grid_get(global.inventory,_x,_y) == _item)
		{
			if(ds_grid_get(global.inventoryCount, _x, _y) > 1)
			{
				ds_grid_set(global.inventoryCount, _x, _y, ds_grid_get(global.inventoryCount, _x, _y) - 1)
			}
			else
			{
				if(ds_grid_get(global.inventoryCount, _x, _y) == 1)
				{
					ds_grid_set(global.inventoryCount, _x, _y, 0)
					ds_grid_set(global.inventory, _x, _y, 0)
				}
			}
			
		}
		
		
		
		
		
		_x++
	}
	return false;
}
function inventoryHas(_item)
{
	var _x = 0
	var _y = 0
	repeat(ds_grid_width(global.inventory) * ds_grid_height(global.inventory))
	{
		
		
		if(_x > ds_grid_width(global.inventory))
		{
			_x = 0
			_y++;
		}
		
		if(ds_grid_get(global.inventory,_x,_y) == _item)
		{
			return true
		}
		_x++
	}
	return false;
}

function isEven(_i)
{
	if _i % 2 == 1
	{
		return false
	}
	else
	{
		return true
	}
}

function mouseX()
{
	var _mx = device_mouse_x_to_gui(0)
	return _mx
}
function mouseY()
{
	var _my = device_mouse_y_to_gui(0)
	return _my
}


function mouseAt(x,y,radx,rady) 
{
	var mx = mouseX()
	var my = mouseY()
	//show_debug_message($"x:{mx} y:{my}")
	//draw_rectangle(x-radx, y-rady, x+radx, y+rady, true)
	if (mx < x+radx) and (mx > x-radx) and (my > y-rady) and (my < y+rady)
	{
		return true
	}
	else{return false}
}

function craft(_item)
{
	show_debug_message(_item)
	show_debug_message(array_length(_item))
	var _i = 1
	repeat(array_length(_item) - 1)
	{
		if(!inventoryHas(_item[_i]))
		{
			return false
		}
		_i++
	}
	_i = 1
	repeat(array_length(_item) - 1)
	{
		removeInventory(_item[_i])
		_i++
	}
	addInventory(_item[0])
}
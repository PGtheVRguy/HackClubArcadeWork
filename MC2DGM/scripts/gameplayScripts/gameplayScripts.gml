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
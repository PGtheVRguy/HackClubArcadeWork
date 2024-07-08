function createTiles()
{
	ti_air =
	{
		sprite : 0,
		drop: "it_air",
		hardness: 0
	}
	ti_grass = 
	{
		sprite: 1,
		drop: "it_dirt",
		hardness: 1.5
	}
	ti_dirt = 
	{
		sprite: 2,
		drop: "it_dirt",
		hardness: 1
	}
	ti_sand =
	{
		sprite: 3,
		drop: "it_sand",
		hardness: 1
	}
	ti_water =
	{
		sprite: 4,
		drop: "it_water",
		hardness: 0
	}
	ti_stone =
	{
		sprite: 5,
		drop: "it_stone",
		hardness: 3
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
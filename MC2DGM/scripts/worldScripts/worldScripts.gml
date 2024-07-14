// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function worldScripts(){

}

function generateChunk(_chunkX, _chunkY){ //map_id
	show_debug_message($"GENERATING NEW CHUNKS X:{_chunkX}, Y:{_chunkY}")
	

	
	
	/*var _c = ds_grid_create(16,16) //Creates the chunk
	ds_grid_clear(_c, 0)
	ds_grid_set_region(_c, 0, 0, 16, 16, 1)
	ds_grid_set_region(_c, irandom_range(0,16), irandom_range(0,16), irandom_range(0,16), irandom_range(0,16), 2)*/
	
	var _c = generatePerlinChunk(_chunkX, _chunkY)
	
	
	var _ymap = ds_map_find_value(global.chunks, _chunkX)
	
	if(_ymap == undefined)
	{
		_ymap = ds_map_create()
	}
	
	
	
	ds_map_add(_ymap, _chunkY, _c); //sets the Y
	
	
	ds_map_set(global.chunks, _chunkX, _ymap) //sets the X
	
	
	#region debug
	
	var _x = ds_map_find_value(global.chunks, _chunkX)
	var _y = ds_map_find_value(_x, _chunkY)
	//show_debug_message(_y)
	
	
	#endregion
	
}


function offsetChunks(furthestX)
{
	//show_debug_message($"CHANGING LAYER: {furthestX*256}")
	var lay_id = layer_get_id("tiles");
	layer_x(lay_id, furthestX*256)

}

function renderChunk(_chunkX, _chunkY)
{
	//show_debug_message($"X:{json_encode(global.chunks)}")
	
	
	try
	{
		var e = ds_map_find_value(ds_map_find_value(global.chunks, _chunkX), _chunkY)
		//show_debug_message($"tried to generate {e}")
		if(e = undefined)
		{
			generateChunk(_chunkX, _chunkY)
		}
	}
	catch(_exception)
	{
		//show_debug_message("GENERATING FROM WORLDPLACER OBJECT")
		generateChunk(_chunkX, _chunkY)
	}
	
	
	
	
	

	var _c = ds_map_find_value(global.chunks, _chunkX)
	//show_debug_message($"Y:{json_encode(_c)}")
	_c = ds_map_find_value(_c, _chunkY)
	
	var _ch0 = _c[0]
	var _ch1 = _c[1]
	var _ch2 = _c[2]
	//show_debug_message(_ch1)
	
	
	
	//The way we setup the chun system is 
	//having a ds_map inside a ds_map
	// So we go into the X ds_map then read from the Y ds_map
	//				  ||
	//READS Y 2ND >   ||
	//				  ||
	//			   =================
	//				  ^ READS X 1st
	//
	//
	/*
	try
	{
		var _cx = ds_grid_width(_c)
		var _cy = ds_grid_height(_c)
		var _break = false
	}
	catch(_exception)
	{
		generateChunk(_chunkX, _chunkY)
		show_debug_message("GENERATING FROM worldScripts.gml SCRIPT")
		var _break = true
		exit;
	}*/
	try
	{
		var _cx = ds_grid_width(_ch1)
		var _cy = ds_grid_height(_ch1)

		//show_debug_message($"{_cx}*{_cy}")
		var _rx = -1
		var _ry = 0
	
		repeat(_cx * _cy)
		{
			if(_rx > 14)
			{
				_ry++
				_rx = -1
				if(_ry = 16)
				{
					break;				
				}
			}
			_rx++
			var _i = ds_grid_get(_ch1, _rx, _ry)
			draw_sprite_part(spr_tileset, 0, (_i.sprite)*16, 0, 16, 16, (_rx*16)+_chunkX*256, (_ry*16)+_chunkY*256)
			
			var _i2 = ds_grid_get(_ch2, _rx, _ry)
			draw_sprite_part(spr_tileset, 0, (_i2.sprite)*16, 0, 16, 16, (_rx*16)+_chunkX*256, (_ry*16)+_chunkY*256)
			
			
			if(ds_grid_get(_ch2, _rx, _ry).name != "Air")
			{
				var _t = getTile((_rx*16)+_chunkX*256, ((_ry*16)+_chunkY*256)-16, 2)
				if(_t = obj_tiles.ti_air)
				{
					//show_debug_message("AH")
					draw_sprite_ext(spr_shadow, 0, (_rx*16)+_chunkX*256, ((_ry*16)+_chunkY*256)-16, 1, 1, 0, -1, 0.45)
					
				}
				draw_sprite_ext(spr_shadow, 0, (_rx*16)+_chunkX*256, ((_ry*16)+_chunkY*256)-16, 1, 1, 0, -1, 0.45)
			}
			
			//var _i = ds_grid_get(_ch2, _rx, _ry)
			//draw_sprite_part(spr_tileset, 0, (_i.sprite)*16, 0, 16, 16, (_rx*16)+_chunkX*256, (_ry*16)+_chunkY*256)
			
		}
	}
	catch(_exception)
	{
		//hi
	}
}


function placeTile(_tile, _x, _y, _layer = -1)
{
	var currentChunkX = int64(_x/256)
	var currentChunkY = int64(_y/256)
	
	if(_x/256 < 0)
	{
		currentChunkX -= 1
	}
	if(_y/256 < 0)
	{
		currentChunkY -= 1
	}
	
	
	//show_debug_message($"Y:{json_encode(_c)}")
	try
	{
		var _c = ds_map_find_value(global.chunks, currentChunkX)
		_c = ds_map_find_value(_c, currentChunkY)
		
		var _ch0 = _c[0]
		var _ch1 = _c[1]
		var _ch2 = _c[2]
		
		var _tx = int64(_x/16)
		var _ty = int64(_y/16)
		
		//Come back later to add placing based on layer
		
		var _mx = _tx - currentChunkX*16
		var _my = _ty - currentChunkY*16
		
		if(_x/256 < 0)
		{
			_mx -= 1
		}
		if(_y/256 < 0)
		{
			_my -= 1
		}
		
		
		var _l = _layer
		if(_layer == -1)
		{
			_l = 2
			if(ds_grid_get(_ch2, _mx, _my).name = "Air")
			{
				_l = 2
				if(ds_grid_get(_ch1, _mx, _my).name = "Air")
				{
					_l = 1
				}
			}
			
		}
		
		if(_l = -1)
		{
			_l = 1
		}
		
		var _chunkLayer = _c[_l]
		show_debug_message($"Placed tile at {_mx}, {_my} at layer {_layer}" )
		show_debug_message(_c)
		
		ds_grid_set(_chunkLayer, _mx, _my, _tile)
		
	}
	catch(_exception)
	{
		show_debug_message("tryign to place in chunks that dont exist!!!")
		var _c = "NOT REAL!"
		var _mx = 0
		var _my = 0
	}
	
	
	//show_debug_message($"CLICKED CHUNK: {currentChunkX}, {currentChunkY}. ds_grid: {_c}\n at {_mx}, {_my}")
	//show_debug_message($"Placed {_tile}")
}
function removeTile(_x, _y)
{
	
	var _tile = obj_tiles.ti_air
	var currentChunkX = int64(_x/256)
	var currentChunkY = int64(_y/256)
	
	if(_x/256 < 0)
	{
		currentChunkX -= 1
	}
	if(_y/256 < 0)
	{
		currentChunkY -= 1
	}
	
	
	//show_debug_message($"Y:{json_encode(_c)}")
	try
	{
		var _c = ds_map_find_value(global.chunks, currentChunkX)
		_c = ds_map_find_value(_c, currentChunkY)
		
		var _ch0 = _c[0]
		var _ch1 = _c[1]
		var _ch2 = _c[2]
		
		var _tx = int64(_x/16)
		var _ty = int64(_y/16)
		
		//Come back later to add placing based on layer
		
		var _mx = _tx - currentChunkX*16
		var _my = _ty - currentChunkY*16
		
		if(_x/256 < 0)
		{
			_mx -= 1
		}
		if(_y/256 < 0)
		{
			_my -= 1
		}
		
		
		
		var _l = 2
		repeat(2)
		{
			if(ds_grid_get(_c[_l], _mx, _my).name == "Air")
			{
				_l--
				
			}
			//show_debug_message(ds_grid_get(_c[_l], _mx, _my))
		}
		//_l++

		_l = clamp(_l, 0, 2)
		
		show_debug_message($"Placed tile at {_mx}, {_my} at layer {_l}" )
		
		var _chunkLayer = _c[_l]
		
		//show_debug_message(_c)
		
		ds_grid_set(_chunkLayer, _mx, _my, _tile)
		
	}
	catch(_exception)
	{
		show_debug_message("tryign to place in chunks that dont exist!!!")
		var _c = "NOT REAL!"
		var _mx = 0
		var _my = 0
	}
	
	
	//show_debug_message($"CLICKED CHUNK: {currentChunkX}, {currentChunkY}. ds_grid: {_c}\n at {_mx}, {_my}")
	//show_debug_message($"Placed {_tile}")
}
function getTile(_x, _y, _layer = -1)
{
	var currentChunkX = int64(_x/256)
	var currentChunkY = int64(_y/256)
	
	//show_debug_message($"Not rouned:{_x/256} rounded:{int64(_x/256)}")
	
	if((_x/256) < 0)
	{
		currentChunkX -= 1
		if(_x/256 == int64(_x/256))
		{
			currentChunkX++;
		}
	}
	if((_y/256) < 0)
	{
		currentChunkY -= 1
		if(_y/256 == int64(_y/256))
		{
			currentChunkY++;
		}
	}
	

	

	
	
	//show_debug_message($"Y:{json_encode(_c)}")
	try
	{
		var _c = ds_map_find_value(global.chunks, currentChunkX)
		_c = ds_map_find_value(_c, currentChunkY)
		
		var _ch0 = _c[0]
		var _ch1 = _c[1]
		var _ch2 = _c[2]
		
		
		var _tx = int64(_x/16)
		var _ty = int64(_y/16)
		
		
		var _mx = _tx - currentChunkX*16
		var _my = _ty - currentChunkY*16
		/*
		if(_x/256 < 0)
		{
			_mx -= 1
		}
		if(_y/256 < 0)
		{
			_my -= 1
		}*/
		if(_layer = -1)
		{
			var _l = 2
			repeat(2)
			{
				if(ds_grid_get(_c[_l], _mx, _my).name == "Air")
				{
					_l--
				
				}
				//show_debug_message(ds_grid_get(_c[_l], _mx, _my))
			}
		}
		else
		{
			var _l = _layer
		}
		
		var _ret = ds_grid_get(_c[_l], _mx, _my)
		if(_ret = undefined)
		{
			return obj_tiles.ti_air
		}
		
		return _ret
		
		//ds_grid_set(_c, _mx, _my, _tile)
		
	}
	catch(_exception)
	{
		show_debug_message("no chunk")
		var _ch1 = "NOT REAL!"
		var _mx = 0
		var _my = 0
		return obj_tiles.ti_air
	}
	
	

}
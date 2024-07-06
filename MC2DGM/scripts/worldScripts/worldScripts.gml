// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function worldScripts(){

}

function generateChunk(_chunkX, _chunkY){ //map_id
	show_debug_message($"GENERATING NEW CHUNKS X:{_chunkX}, Y:{_chunkY}")
	

	
	
	var _c = ds_grid_create(16,16) //Creates the chunk
	ds_grid_clear(_c, 0)
	ds_grid_set_region(_c, 0, 0, 16, 16, 1)
	ds_grid_set_region(_c, irandom_range(0,16), irandom_range(0,16), irandom_range(0,16), irandom_range(0,16), 2)
	
	_c = generatePerlinChunk(_chunkX, _chunkY)
	
	
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
		var _cx = ds_grid_width(_c)
		var _cy = ds_grid_height(_c)

	
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
			var _i = ds_grid_get(_c, _rx, _ry)
			draw_sprite_part(spr_tileset, 0, _i*16, 0, 16, 16, (_rx*16)+_chunkX*256, (_ry*16)+_chunkY*256)
			//draw_sprite(spr_tileset, 0, _rx*16, _ry*16)
		}
	}
	catch(_exception)
	{
		//hi
	}
}


function placeTile(_tile, _x, _y)
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
		
		
		var _tx = int64(_x/16)
		var _ty = int64(_y/16)
		
		
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
		
		ds_grid_set(_c, _mx, _my, 1)
		
	}
	catch(_exception)
	{
		show_debug_message("tryign to place in chunks that dont exist!!!")
		var _c = "NOT REAL!"
		var _mx = 0
		var _my = 0
	}
	
	
	show_debug_message($"CLICKED CHUNK: {currentChunkX}, {currentChunkY}. ds_grid: {_c}\n at {_mx}, {_my}")
}
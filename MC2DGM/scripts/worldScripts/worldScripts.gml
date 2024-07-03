// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function worldScripts(){

}

function generateChunk(_chunkX, _chunkY){ //map_id
	var _c = ds_grid_create(16,16) //Creates the chunk
	ds_grid_clear(_c, 0)
	ds_grid_set_region(_c, 0, 0, 16, 16, 1)
	
	var _ymap = ds_map_create()
	
	ds_map_set(_ymap, _chunkY, _c); //sets the Y
	
	
	ds_map_set(global.chunks, _chunkX, _ymap) //sets the X
	//ds_list_set(global.chunks, _chunkX, _c)
	
	//global.chunks[_chunkX] = _c //sets the main chunks array to hold the chunk
	
	/*
	if(_chunkX < furthestX)
	{
		furthestX = _chunkX
		offsetChunks(furthestX)
	}
	if(room_width < _chunkX*256)
	{
		room_set_width(room, _chunkX*256)
		room_width = _chunkX*256
		//room_width = _chunkX*256
		show_debug_message($"CHANGING ROOM SIZE! {room_width}")
	}
	updateChunk(map_id, _chunkX)*/
}
/*
function updateChunk(map_id,_chunkX){
	try{
		//var _c = global.chunks[_chunkX] //pulls the chunk thingy
		//var _c = ds_list_find_value(global.chunks, _chunkX)
		
		var _c = ds_map_find_value(global.chunks, _chunkX)
		
		var _cx = ds_grid_width(_c)
		var _cy = ds_grid_height(_c)
	
		var _rx = 0
		var _ry = 0
	
		repeat(_cx * _cy)
		{
			_rx++
			if(_rx > 15)
			{
				_ry++
				_rx = 0
				if(_ry = 256)
				{
					break;				
				}

			}
		
			var _t = ds_grid_get(_c, _rx , _ry )
			if(_t != 0)
			{
				//var data = tilemap_get_at_pixel(map_id, ix, iy);
				var mx = tilemap_get_cell_x_at_pixel(map_id, _rx * 16, _ry * 16);
				//show_debug_message(mx)
				var my = tilemap_get_cell_y_at_pixel(map_id, _ry * 16, _rx * 16);
				var data = tilemap_get(map_id, mx, my);

				show_debug_message($"Placing tile {_t} at {_rx},{_ry}")

				var ind = tile_get_index(data);
				data = tile_set_index(data, _t);
			
				tilemap_set_at_pixel(map_id, data, (_rx*16)+((256)*_chunkX), _ry*16); 
			}
		
		}
	}
	catch(_exception)
	{
		show_debug_message(_exception)
	}
	
}*/

function offsetChunks(furthestX)
{
	show_debug_message($"CHANGING LAYER: {furthestX*256}")
	var lay_id = layer_get_id("tiles");
	layer_x(lay_id, furthestX*256)

}

function renderChunk(_chunkX, _chunkY)
{
	var _c = ds_map_find_value(global.chunks, _chunkX)
	_c = ds_map_find_value(_c, _chunkY)
	
	
	//The way we setup the chun system is 
	//having a ds_map inside a ds_map
	// So we go into the X ds_map then read from the Y ds_map
	//
	//
	
	
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

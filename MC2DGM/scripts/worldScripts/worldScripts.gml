// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function worldScripts(){

}

function generateChunk(_chunkX, map_id){
	var _c = ds_grid_create(16,256) //Creates the chunk
	ds_grid_clear(_c, 0)
	for(var i = 0; i < 16; i++) //This is just a debug chunk
	{
		ds_grid_set(_c, i, 60, 2)
	}
	ds_grid_set_region(_c, 0, 61, 16, 256, 1)
	
	global.chunks[_chunkX] = _c //sets the main chunks array to hold the chunk
	
	updateChunk(map_id, _chunkX)
	
}

function updateChunk(map_id,_chunkX){
	var _c = global.chunks[_chunkX] //pulls the chunk thingy
	
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
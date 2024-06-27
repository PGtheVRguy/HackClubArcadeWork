
global.chunks = ds_map_create()

var lay_id = layer_get_id("tiles");

layer_x(lay_id, 0) //We will use this to reorintate the 0,0 of the world
layer_y(lay_id, 0)

furthestX = 0

map_id = layer_tilemap_get_id(lay_id);

var ix = 16
var iy = 16


placeTile = 1
//var data = tilemap_get_at_pixel(map_id, ix, iy);
var mx = tilemap_get_cell_x_at_pixel(map_id, 1, 1);
var my = tilemap_get_cell_y_at_pixel(map_id, 1, 1);
var data = tilemap_get(map_id, mx, my);



var ind = tile_get_index(data);
data = tile_set_index(data, placeTile);

tilemap_set_at_pixel(map_id, data, ix, iy); //debug spot



generateChunk(0, map_id)
show_debug_overlay(true)
//show_debug_message($"placed tile at x:{_loadEntity.pos_x} y: {_loadEntity.pos_y} with tile of {placeTile}")
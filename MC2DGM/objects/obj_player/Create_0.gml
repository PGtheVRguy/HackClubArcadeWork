x = 0;
y = 0;

spr = 0

hsp = 0;
vsp = 0;

walk_spd = 1;

dir = 1

breakTime = 0

lastCursorPos[0] = 0
lastCursorPos[1] = 0

currentItem = 1

invOpen = false

global.inventory = ds_grid_create(9,4);
ds_grid_clear(global.inventory, 0)
global.inventoryCount = ds_grid_create(ds_grid_width(global.inventory), ds_grid_height(global.inventory));
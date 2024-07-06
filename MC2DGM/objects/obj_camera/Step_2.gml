

x = obj_player.x
y = obj_player.y

if(mouse_wheel_up())
{
	zoom -= 0.1
	camWidth = 455*zoom
	camHeight = 256*zoom
	//display_set_gui_size(455*zoom,256*zoom)
	camera_set_view_size(view_camera[0],camWidth,camHeight)

}
if(mouse_wheel_down())
{
	zoom += 0.1
	camWidth = 455*zoom
	camHeight = 256*zoom
	//display_set_gui_size(455*zoom,256*zoom)
	camera_set_view_size(view_camera[0],camWidth,camHeight)

}
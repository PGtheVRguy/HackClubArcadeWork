

_x = lerp(_x, targetPlayer.x, 0.05)
_y = lerp(_y, targetPlayer.y, 0.05)

camZoom = 1





#region 2D camera
	camera_set_view_pos(view_camera[0],_x-(camWidth/2),_y-(camHeight/2))
	
#endregion

#region 3D camera
/*
//with(all){depth = depth}
layer_force_draw_depth(true,0)
gpu_set_cullmode(cull_noculling)
var camera = camera_get_active()
camera_set_view_mat(camera, matrix_build_lookat(_x,_y, -540*camZoom, _x, _y, 0, 0, 1, 0))

camera_set_proj_mat(camera,matrix_build_projection_ortho(window_get_width()/camZoom,window_get_height()/camZoom,-999,320000000))
//camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(clamp(10,1,256), (window_get_width()/window_get_height()),0, 32000.0))  
layer_force_draw_depth(true, 0)

camera_apply(camera)
//gpu_set_cullmode(cull_counterclockwise)
//with (obj_3DObject) event_perform(ev_draw, 0);
gpu_set_cullmode(cull_noculling)
//show_debug_message("camX border: " + string((x+window_get_width()/2)*camZoom))*/
#endregion

/*
if(input_check_pressed("d_editor"))
{
	if(instance_exists(obj_leveleditor))
	{
		instance_destroy(obj_leveleditor)
	}
	else
	{
		instance_create_layer(_x, _y, layer, obj_leveleditor)
	}
}*/

oMx = mouse_x
oMy = mouse_y
shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment(){
  vec4 texture_color = texture(TEXTURE, UV);
  vec3 targetColor = vec3(0.0823529412, 0.996078431, 0.0862745098);
  if (distance(texture_color.rgb, targetColor) < 0.6){
  //if(texture_color.rgb == targetColor){
     texture_color.a = 0.0;  //将Alpha通道值设为0,显示为透明
  }
  COLOR = texture_color; 
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

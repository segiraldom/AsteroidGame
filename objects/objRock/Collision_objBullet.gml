
instance_destroy(other);
if sprite_index == sprRockBig{
	sprite_index = sprRockSmall;
	instance_copy(true);
}else{
	instance_destroy();	
}

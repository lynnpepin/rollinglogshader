/* TODO:
 * 1. Add noisy texture
 * 2. Recalculate normals
 * 3. Make it a better rolling-log shape (convery-belt / cloth-over-tube)
 */
shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);
uniform sampler2D texture_metallic : hint_white;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_white;
uniform vec4 roughness_texture_channel;
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;


void vertex() {
	UV=UV*uv1_scale.xy+uv1_offset.xy;
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	ALBEDO.g += .2;
	float metallic_tex = dot(texture(texture_metallic,base_uv),metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	float roughness_tex = dot(texture(texture_roughness,base_uv),roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;
	SPECULAR = specular;
}

uniform vec3 player_pos = vec3(0.0, 0.0, 0.0);

void vertex() {
	//float dist_zy = length(CAMERA_MATRIX[3].zy - VERTEX.zy);
	//float dist_xy = length(CAMERA_MATRIX[3].xy - VERTEX.xy);
	float dist_zy = length(player_pos.zy - VERTEX.zy);
	float dist_xy = length(player_pos.xy - VERTEX.xy);
	VERTEX.y -= pow(dist_zy/5.0, 2.0);
	VERTEX.y -= pow(dist_xy/15.0, 2.0);
}

/*
void vertex() {
	VERTEX.y += cos(2.0 * sqrt(pow(VERTEX.x - 20.0, 2) + pow(VERTEX.z + 20.0, 2)));
}
*/
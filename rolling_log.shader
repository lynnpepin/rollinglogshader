/* TODO: Recalculate normals, cleanup
 */
shader_type spatial;
uniform float PI = 3.14159265358979323846264;
uniform vec3 player_pos = vec3(0.0, 0.0, 0.0);
uniform bool active = false;


// https://godot-es-docs.readthedocs.io/en/latest/tutorials/shading/vertex_displacement_with_shaders.html
// hash and noise function to add simple texture to the plane
float hash(vec2 p) {
  return fract(sin(dot(p * 17.17, vec2(14.91, 67.31))) * 4791.9511);
}

float noise(vec2 x) {
  vec2 p = floor(x);
  vec2 f = fract(x);
  f = f * f * (3.0 - 2.0 * f);
  vec2 a = vec2(1.0, 0.0);
  return mix(mix(hash(p + a.yy), hash(p + a.xy), f.x),
         mix(hash(p + a.yx), hash(p + a.xx), f.x), f.y);
}

float fbm(vec2 x) {
  float height = 0.0;
  float amplitude = 0.5;
  float frequency = 3.0;
  for (int i = 0; i < 6; i++){
    height += noise(x * frequency) * amplitude;
    amplitude *= 0.5;
    frequency *= 2.0;
  }
  return height;
}

uniform vec3 original_vertex;


void vertex() {
	// Add some noise
	COLOR.rgb += 0.0;
	//VERTEX.y += 1.0*fbm(VERTEX.xz) - 0.5;
	
	// Now let's do displacements to "roll log"
	float dist_z = VERTEX.z - player_pos.z;
	float dist_y = VERTEX.y; // - player_pos.y;
	float RADIUS = 10.0;
	float Dz = PI*RADIUS/2.0;
	float theta = dist_z / RADIUS;
	int side;
	
	// Calculate which "side" we're on
	// 1 and -1 represent "hanging towel"
	// 0 represents the "rolling log" part
	if (active) {
		if (dist_z > Dz) {
			side = 1;
		} else if (dist_z < -Dz) {
			side = -1;
		} else {
			side = 0;
		}
		
		// Sides still do not work as expected!
		if (side == 1) {
			VERTEX.y = -(dist_z - Dz) - RADIUS;
			VERTEX.z = dist_y + RADIUS;
		}
		if (side == -1) {
			VERTEX.y = (dist_z + Dz) - RADIUS;
			VERTEX.z = - (dist_y + RADIUS)
		}
		if (side == 0) {
			VERTEX.y = (dist_y + RADIUS)*cos(theta) - RADIUS;
			VERTEX.z = (dist_y + RADIUS)*sin(theta) ;
		}
		
		VERTEX.z += player_pos.z;
		
		// todo - recalculate normals
	}
}

void fragment() {
	//ALBEDO = vec3(0.1, 0.3, 0.1);
	ALBEDO = vec3(0.1, 0.3, 0.05);
}

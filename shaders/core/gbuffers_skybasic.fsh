#version 330 compatibility
#include "/shader.h"

uniform int renderStage;
uniform vec3 skyColor;

in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	if (renderStage == MC_RENDER_STAGE_STARS) {
		color = glcolor;
	} else {
		color.rgb = pow(skyColor, vec3(1.0 / GAMMA_CORRECTION));
	}
}

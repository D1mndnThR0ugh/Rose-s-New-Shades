#version 330 compatibility
#include "/shader.h"
/*
const int colortex0Format = RGBA16F;
*/
uniform sampler2D gtexture;
uniform int worldTime;
uniform int moonPhase;
uniform vec3 fogColor;
uniform float far;
uniform float rainStrength;
uniform float thunderStrength;
uniform float darknessFactor;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 vertcoord;

/* RENDERTARGETS: 0,1 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lmdata;

void dothelighting(vec3 suncolor, vec3 mooncolor, vec3 blockcolor, vec3 worldcolor) {
	color = texture(gtexture, texcoord) * glcolor;
	color.rgb = pow(color.rgb, vec3(GAMMA_CORRECTION));
	lmdata = vec4(lmcoord, 0.0, 1.0);
	float skylight = clamp(2.0 * sin((worldTime / 24000.0) * 6.28) + 1.0, 0.0, 1.0) * ((4.0 - (rainStrength + thunderStrength)) / 4.0);
	float sunstr = lmcoord.g * skylight;
	float moonstr = lmcoord.g * ((1.0 - skylight) * ((abs(4.0 - moonPhase) / 5.0) + 0.2));
	float blockstr = clamp(lmcoord.r - sunstr, 0.0, 1.0);
	color.rgb *= (sunstr * suncolor) + (moonstr * mooncolor) + (blockstr * blockcolor / (1.0 + (4.0 * darknessFactor))) + (worldcolor * (1.0 - darknessFactor));
	if (color.a < 0.1) {
		discard;
	}
}
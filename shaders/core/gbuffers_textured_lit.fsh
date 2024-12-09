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
uniform float screenBrightness;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 vertcoord;
in vec3 normal;

const float blockface = 6.0 - BLOCKFACE_SHADING;

/* RENDERTARGETS: 0,1 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lmdata;

void dothelighting(vec3 suncolor, vec3 mooncolor, vec3 blockcolor, vec3 worldcolor, float shadows) {
	color = texture(gtexture, texcoord) * glcolor;
	color.rgb = pow(color.rgb, vec3(GAMMA_CORRECTION));
	#if BLOCKFACE_SHADING > 0.0
		color.rgb *= (normal.y + (blockface - 1.0)) / blockface;
	#endif
	lmdata = vec4(lmcoord, 0.0, 1.0);
	lmdata.g *= (smoothstep(13.5, 14.5, lmcoord.g * 15.0) * shadows) + (1.0 - shadows);
	float skylight = clamp(2.0 * sin((worldTime / 24000.0) * 6.28) + 1.0, 0.0, 1.0) * ((4.0 - (rainStrength + thunderStrength)) / 4.0);
	float sunstr = lmdata.g * skylight;
	float moonstr = lmdata.g * ((1.0 - skylight) * ((abs(4.0 - moonPhase) / 5.0) + 0.2));
	float blockstr = clamp(lmdata.r - sunstr, 0.0, 1.0);
	color.rgb *= (sunstr * suncolor) + (moonstr * mooncolor) + (blockstr * blockcolor / (1.0 + (4.0 * darknessFactor))) + ((screenBrightness * worldcolor) * (1.0 - darknessFactor));
	if (color.a < 0.1) {
		discard;
	}
}

#version 330 compatibility
#include "/shader.h"
/*
const int colortex0Format = RGBA16F;
*/
uniform sampler2D gtexture;
uniform int worldTime;
uniform int moonPhase;
uniform bool hasSkylight;
uniform vec3 fogColor;
uniform float far;
uniform float rainStrength;
uniform float thunderStrength;
uniform float darknessFactor;
uniform float screenBrightness;
uniform float nightVision;
uniform float blindness;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 vertcoord;
in vec3 normal;
in vec2 entity;

const float blockface = 6.0 - BLOCKFACE_SHADING;

/* RENDERTARGETS: 0,1,2,3,4 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 textures;
layout(location = 2) out vec4 lmdata;
layout(location = 3) out vec4 faces;
layout(location = 4) out vec4 lmcolor;

void dothelighting(vec3 suncolor, vec3 mooncolor, vec3 blockcolor, vec3 worldcolor) {
	textures = texture(gtexture, texcoord);
	color = textures * glcolor * vec4(vec3(1.0 - blindness), 1.0) + vec4(vec3(blindness), 0.0);
	color.rgb = pow(color.rgb, vec3(GAMMA_CORRECTION));
	faces = glcolor;
	#if BLOCKFACE_SHADING > 0.0
		faces.rgb *= (normal.y + (blockface - 1.0)) / blockface;
		color.rgb *= (normal.y + (blockface - 1.0)) / blockface;
	#endif
	lmdata = vec4(lmcoord, 0.0, 1.0);
	float shade = lmcoord.g;
	if(entity.y == 1) {
		shade *= ((smoothstep(13.0, 14.0, lmcoord.g * 15.0) * SH_FL) + (1.0 - SH_FL));
	} else {
		shade *= ((smoothstep(13.5, 14.5, lmcoord.g * 15.0) * SH_FL) + (1.0 - SH_FL));
	}
	float daylight = clamp(2.0 * sin((worldTime / 24000.0) * 6.28) + 1.0, 0.0, 1.0) * ((4.0 - (rainStrength + thunderStrength)) / 4.0);
	float sunstr = shade * daylight;
	float moonstr = shade * ((1.0 - daylight) * ((abs(4.0 - moonPhase) * (0.9 / 4.0)) + 0.1));
	float blockstr = clamp(lmcoord.r - sunstr, 0.0, 1.0);
	if (entity.x == 101) {
		color /= glcolor;
		float vis = clamp(dot(color.rgb, vec3(1.0 / 3.0)) - 0.25, 0.0, 1.0);
		color += vec4(vec3(vis * FX_WT_B), pow(vis, 2.1 - FX_WT_B));
		color *= glcolor * vec4(vec3(1.0), FX_WT_A);
	}
	if (entity.x == 102) {
		float vis = clamp(dot(color.rgb, vec3(1.0 / 3.0)) - 0.25, 0.0, 1.0);
		color += vec4(vec3(vis * FX_PT_B), pow(vis, 2.1 - FX_PT_B));
		color *= glcolor * vec4(vec3(1.0), FX_PT_A);
	}
	lmcolor = vec4(mix(vec3(SH_FL_R, SH_FL_G, SH_FL_B), suncolor, sunstr) + (moonstr * mooncolor) + (blockstr * blockcolor) + (screenBrightness * worldcolor), 1.0);
	color.rgb *= mix((mix(clamp(lmcoord.g, 0.0, 1.0) * vec3(SH_FL_R, SH_FL_G, SH_FL_B), suncolor, sunstr) / (1.0 + (3.0 * darknessFactor))) + (mix(clamp(lmcoord.g, 0.0, 1.0) * vec3(SH_FL_R, SH_FL_G, SH_FL_B), mooncolor, moonstr)) + (blockstr * blockcolor / (1.0 + (4.0 * darknessFactor))) + (clamp(screenBrightness * worldcolor, 0.0, 1.0) * (1.0 - darknessFactor)), vec3(1.0 - (darknessFactor * 0.9)), nightVision);
	if (color.a < 0.1) {
		discard;
	}
	color.rgb = pow(color.rgb, vec3(1.0 / GAMMA_CORRECTION));
}
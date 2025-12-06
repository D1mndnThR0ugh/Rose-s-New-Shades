#version 330 compatibility
#include "/shader.h"

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D colortex3;
uniform sampler2D colortex4;
uniform sampler2D colortex5;
uniform mat4 gbufferProjectionInverse;
uniform float far;
uniform int isEyeInWater;
uniform float blindness;
uniform float nightVision;
uniform vec3 fogColor;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

float getdist() {
	float depth = texture(depthtex0, texcoord).r;
	if(depth == 1.0){
		return -1.0;
	}
	vec4 p = gbufferProjectionInverse * vec4((vec3(texcoord.xy, depth) * 2.0) - 1.0, 1.0);
	float j = length(p.xyz / p.w);
	return j;
}

void bigfog(vec3 fogcolor, vec4 fogopts) {
	float dist = getdist();
  if(min(fogcolor.r, min(fogcolor.g, fogcolor.b)) == -1) {
    fogcolor = fogColor;
  }
	if(dist == -1.0) {
		color.rgb = mix(pow(fogcolor, vec3(1.0 / GAMMA_CORRECTION)), color.rgb, fogopts.w);
		return;
	}
	float fogdist = pow(max(dist - fogopts.x, 0) / fogopts.y, fogopts.z);
	fogdist *= 1.0 + (FG_OW_LIG * texture(colortex2, texcoord).r);
	color.rgb = pow(color.rgb, vec3(GAMMA_CORRECTION));
	color.rgb = mix(color.rgb, fogcolor, clamp(fogdist, 0.0, 1.0));
	color.rgb = pow(color.rgb, vec3(1.0 / GAMMA_CORRECTION));
}

void subfog() {
	if(isEyeInWater < 2) {
		if(isEyeInWater == 1) {
			vec3 tmp = color.rgb;
			bigfog(vec3(FG_WT_R, FG_WT_G, FG_WT_B), vec4((FG_WT_RAD_B) + (FG_WT_RAD_C * 16.0) + (FG_WT_RAD_P * far), (FG_WT_DEP_B) + (FG_WT_DEP_C * 16.0) + (FG_WT_DEP_P * far), FG_WT_EXP * FG_WT_EXO, FG_WT_SKY));
		}
	}	else {
		if(isEyeInWater == 2) {
			bigfog(vec3(FG_LV_R, FG_LV_G, FG_LV_B), vec4((FG_LV_RAD_B) + (FG_LV_RAD_C * 16.0) + (FG_LV_RAD_P * far), (FG_LV_DEP_B) + (FG_LV_DEP_C * 16.0) + (FG_LV_DEP_P * far), FG_LV_EXP * FG_LV_EXO, FG_LV_SKY));
		} else {
			bigfog(vec3(FG_SN_R, FG_SN_G, FG_SN_B), vec4((FG_SN_RAD_B) + (FG_SN_RAD_C * 16.0) + (FG_SN_RAD_P * far), (FG_SN_DEP_B) + (FG_SN_DEP_C * 16.0) + (FG_SN_DEP_P * far), FG_SN_EXP * FG_SN_EXO, FG_SN_SKY));
		}
	}
}

void eyeballs() {
	color.rgb = pow(color.rgb, vec3(GAMMA_CORRECTION));
	vec3 tmp = color.rgb;
	bigfog(vec3(0.0), vec4(0, 5, 2.0, 0));
	color.rgb = mix(tmp, color.rgb, blindness);
	color.rgb = pow(color.rgb, vec3(1.0 / GAMMA_CORRECTION));
}
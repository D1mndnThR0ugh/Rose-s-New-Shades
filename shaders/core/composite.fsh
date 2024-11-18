#version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform sampler2D colortex1;
uniform mat4 gbufferProjectionInverse;
uniform float far;
uniform int isEyeInWater;
uniform float blindness;
uniform float nightVision;

in vec2 texcoord;

const vec3 watercolor = vec3(0.2, 0.4, 0.7);
const vec3 lavacolor = vec3(1.0, 0.1, 0.0);
const vec3 snowcolor = vec3(1.0);

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
	if(dist == -1.0) {
		color.rgb = fogcolor;
		return;
	}
	float fogdist = fogopts.z * pow(dist / (far / fogopts.w), fogopts.x) - fogopts.y;
	fogdist *= 1.0 - (texture(colortex1, texcoord).r / 5.0);
	color.rgb = mix(color.rgb, fogcolor, clamp(fogdist, 0.0, 1.0));
}

void subfog() {
	if(isEyeInWater < 2) {
		if(isEyeInWater == 1) {
			vec3 tmp = color.rgb;
			bigfog(watercolor, vec4(0.4, 0.4, 1.7, 2.4));
			color.rgb = mix(color.rgb, tmp, nightVision);
		}
	}	else {
		if(isEyeInWater == 2) {
			bigfog(lavacolor, vec4(0.1, 0.0, 2.5, 0.1));
		} else {
			bigfog(snowcolor, vec4(0.1, 0.0, 2.5, 0.1));
		}
	}
}

void eyeballs() {
	color.rgb = mix(color.rgb, pow(color.rgb, vec3(0.6, 0.4, 0.6)), nightVision);
	vec3 tmp = color.rgb;
	bigfog(vec3(0.0), vec4(0.1, 0.0, 2.5, 0.1));
	color.rgb = mix(tmp, color.rgb, blindness);
}
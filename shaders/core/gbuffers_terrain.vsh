#version 330 compatibility
#include "/core/scripts.glsl"

in vec2 mc_Entity;

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec3 vertcoord;
out vec3 normal;
out vec2 entity;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	lmcoord = (lmcoord * 33.0 / 32.0) - (1.0 / 16.0);
	glcolor = gl_Color;
	vertcoord = worldpos(gl_Vertex.xyz);
	normal = gl_NormalMatrix * gl_Normal;
	normal = mat3(gbufferModelViewInverse) * normal;
	entity = mc_Entity;
}
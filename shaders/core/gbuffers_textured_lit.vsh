#version 330 compatibility
#include "/core/scripts.glsl"

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec3 vertcoord;
out vec3 normal;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	lmcoord = (lmcoord * 33.05 / 32.0) - (1.05 / 32.0);
	glcolor = gl_Color;
	vertcoord = worldpos(gl_Vertex.xyz);
	normal = gl_NormalMatrix * gl_Normal;
	normal = mat3(gbufferModelViewInverse) * normal;
}

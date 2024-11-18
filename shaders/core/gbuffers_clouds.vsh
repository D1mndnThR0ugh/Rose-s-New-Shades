#version 330 compatibility
#include "/core/scripts.glsl"

out vec2 texcoord;
out vec4 glcolor;
out vec3 vertcoord;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
	vertcoord = worldpos(gl_Vertex.xyz);
}
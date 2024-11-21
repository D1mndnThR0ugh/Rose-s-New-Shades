#version 330 compatibility

uniform sampler2D gtexture;
uniform float cloudHeight;
uniform float rainStrength;
uniform float thunderStrength;
uniform int worldTime;
uniform int moonPhase;

in vec2 texcoord;
in vec3 vertcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void clouds() {
	color = texture(gtexture, texcoord);
	float time = clamp(2.0 * sin((worldTime / 24000.0) * 6.28) + 1.0, 0.0, 1.0);
	float moon = (abs(4.0 - moonPhase) / 5.0) + 0.2;
	float weather = (4.0 - (rainStrength + thunderStrength)) / 4.0;
	color.rgb *= ((time / 2.0) + 0.5) * weather;
	color.rgb = mix(color.rgb * moon, color.rgb, time);
	color.a = 1.1 - pow((vertcoord.y - cloudHeight) / 4.0, 0.5);
	if (color.a <= 0.0) {
		discard;
	}
}

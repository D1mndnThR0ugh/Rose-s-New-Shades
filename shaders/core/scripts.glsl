uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

vec3 worldpos(vec3 modelPos) {
	vec3 viewPos = (gl_ModelViewMatrix * vec4(modelPos, 1.0)).xyz;
	vec3 eyePlayerPos = mat3(gbufferModelViewInverse) * viewPos;
	vec3 eyeCameraPosition = cameraPosition + gbufferModelViewInverse[3].xyz;
	return eyePlayerPos + eyeCameraPosition;
}
#include "/core/composite.fsh"

const vec4 fog = vec4(5.0, 0.0, 1.0, 1.0);

void main() {
  color = texture(colortex0, texcoord);
  bigfog(vec3(0.0), fog);
  subfog();
  eyeballs();
}
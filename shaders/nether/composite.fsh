#include "/core/composite.fsh"
#include "/shader.h"

const vec4 fog = vec4(0.3, 0.5, 1.7, 2.4);
const vec3 fogcolor = vec3(0.25, 0.1, 0.05);

void main() {
  color = texture(colortex0, texcoord);
  bigfog(fogcolor, fog);
  subfog();
  eyeballs();
}
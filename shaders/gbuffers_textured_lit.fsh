#include "/core/gbuffers_textured_lit.fsh"

const vec3 suncolor = vec3(1.0);
const vec3 mooncolor = vec3(0.2, 0.3, 0.4);
const vec3 blockcolor = vec3(1.0, 0.6, 0.3);
const vec3 worldcolor = vec3(0.1);

void main() {
  dothelighting(suncolor, mooncolor, blockcolor, worldcolor);
}
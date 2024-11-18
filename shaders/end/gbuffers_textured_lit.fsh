#include "/core/gbuffers_textured_lit.fsh"

const vec3 suncolor = vec3(0.0);
const vec3 mooncolor = vec3(0.0);
const vec3 blockcolor = vec3(1.0, 0.1, 0.9);
const vec3 worldcolor = vec3(0.5);

void main() {
  dothelighting(suncolor, mooncolor, blockcolor, worldcolor);
  color.rgb *= clamp((vertcoord.y / 20.0) - 1.0, 0.0, 1.0);
}
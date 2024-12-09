#include "/core/gbuffers_textured_lit.fsh"
#include "/shader.h"

const vec3 blockcolor = vec3(NT_BL_R, NT_BL_G, NT_BL_B);
const vec3 worldcolor = vec3(NT_WL_R, NT_WL_G, NT_WL_B);

void main() {
  dothelighting(vec3(0.0), vec3(0.0), blockcolor, worldcolor, 0.0);
}

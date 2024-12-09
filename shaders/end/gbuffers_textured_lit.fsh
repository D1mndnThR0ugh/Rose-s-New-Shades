#include "/core/gbuffers_textured_lit.fsh"
#include "/shader.h"

const vec3 blockcolor = vec3(ND_BL_R, ND_BL_G, ND_BL_B);
const vec3 worldcolor = vec3(ND_WL_R, ND_WL_G, ND_WL_B);

void main() {
  dothelighting(vec3(0.0), vec3(0.0), blockcolor, worldcolor, 0.0);
  #if END_VOID == 1
    color.rgb *= clamp((vertcoord.y - ND_VD_HG) / ND_VD_DP, 0.0, 1.0) * ND_VD_DN;
  #elif END_VOID == 2
    color.rgb *= clamp((vertcoord.y - ND_VD_HG) / ND_VD_DP, (lmcoord.r - (1.0 / 32.0)) / 2.0, 1.0) * ND_VD_DN;
  #elif END_VOID == 3
    float dist = clamp((length(vertcoord) - 500.0) / 250.0, 0.0, 1.0);
    color.rgb *= clamp((vertcoord.y - ND_VD_HG) / ND_VD_DP, 1.0 - dist, 1.0) * ND_VD_DN;
  #endif
}

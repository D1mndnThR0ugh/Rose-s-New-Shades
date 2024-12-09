#include "/core/gbuffers_textured_lit.fsh"
#include "/shader.h"

vec3 suncolor = vec3(OW_SL_R, OW_SL_G, OW_SL_B);
vec3 mooncolor = vec3(OW_ML_R, OW_ML_G, OW_ML_B);
vec3 blockcolor = vec3(OW_BL_R, OW_BL_G, OW_BL_B);
vec3 worldcolor = vec3(OW_WL_R, OW_WL_G, OW_WL_B);

void main() {
  dothelighting(suncolor, mooncolor, blockcolor, worldcolor, OW_SH);
}

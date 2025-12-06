#include "/core/composite.fsh"

void main() {
  color = texture(colortex0, texcoord);
  bigfog(vec3(FG_ND_R, FG_ND_G, FG_ND_B), vec4((FG_ND_RAD_B) + (FG_ND_RAD_C * 16.0) + (FG_ND_RAD_P * far), (FG_ND_DEP_B) + (FG_ND_DEP_C * 16.0) + (FG_ND_DEP_P * far), FG_ND_EXP * FG_ND_EXO, FG_ND_SKY));
  subfog();
  eyeballs();
}
#include "/core/composite.fsh"

void main() {
  color = texture(colortex0, texcoord);
  bigfog(vec3(FG_NT_R, FG_NT_G, FG_NT_B), vec4((FG_NT_RAD_B) + (FG_NT_RAD_C * 16.0) + (FG_NT_RAD_P * far), (FG_NT_DEP_B) + (FG_NT_DEP_C * 16.0) + (FG_NT_DEP_P * far), FG_NT_EXP * FG_NT_EXO, FG_NT_SKY));
  subfog();
  eyeballs();
}
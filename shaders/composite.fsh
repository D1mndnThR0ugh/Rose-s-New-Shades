#include "/core/composite.fsh"

void main() {
  color = texture(colortex0, texcoord);
  bigfog(vec3(FG_OW_R, FG_OW_G, FG_OW_B), vec4((FG_OW_RAD_B) + (FG_OW_RAD_C * 16.0) + (FG_OW_RAD_P * far), (FG_OW_DEP_B) + (FG_OW_DEP_C * 16.0) + (FG_OW_DEP_P * far), FG_OW_EXP * FG_OW_EXO, FG_OW_SKY));
  subfog();
  eyeballs();
  #if SPAWN_HIGHLIGHT == 1
    if (floor(texture(colortex1, texcoord).r * 15.0) == 0.0) {
      color.rgb *= vec3(2.0, 0.0, 0.0);
    }
  #endif
}
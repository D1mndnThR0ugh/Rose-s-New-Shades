#include "/core/composite.fsh"

void main() {
  color = texture(colortex0, texcoord);
  subfog();
  eyeballs();
  #if SPAWN_HIGHLIGHT == 1
    if (floor(texture(colortex1, texcoord).r * 15.0) == 0.0) {
      color.rgb *= vec3(2.0, 0.0, 0.0);
    }
  #endif
}

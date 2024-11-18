#include "/core/composite.fsh"

void main() {
  color = texture(colortex0, texcoord);
  subfog();
  eyeballs();
}
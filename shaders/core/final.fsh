#version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D colortex3;
uniform sampler2D colortex4;
uniform sampler2D colortex5;
uniform sampler2D colortex6;
uniform sampler2D colortex7;
uniform sampler2D colortex8;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
  if(0.25 < texcoord.x && texcoord.x < 0.75 && 0.25 < texcoord.y && texcoord.y < 0.75) {
    color = texture(colortex0, texcoord * vec2(2.0) - vec2(0.5));
  } else {
    if(texcoord.x < (0.5)) {
      if(texcoord.y < (0.5)) {
        color = texture(colortex1, texcoord * vec2(2.0));
      } else {
        color = texture(colortex2, texcoord * vec2(2.0) - vec2(0.0, 1.0));
      }
    } else {
      if(texcoord.y < (0.5)) {
        color = texture(colortex3, texcoord * vec2(2.0) - vec2(1.0, 0.0));
      } else {
        color = texture(colortex4, texcoord * vec2(2.0) - vec2(1.0));
      }
    }
  }
}
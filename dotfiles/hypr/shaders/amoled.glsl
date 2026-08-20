#version 300 es
precision highp float;
in vec2 v_texcoord;
layout(location = 0) out vec4 fragColor;

uniform sampler2D tex;
const float BRIGHTNESS  = 1.0;   // 1.0 = off. Multiplicative exposure.
const float BLACK_POINT = 0.025; // 0.0 = off. Levels-style black point -- pulls near-black
const float CONTRAST    = 1.0;  // 1.0 = off. Punch around mid-grey. 1.05-1.15 is a good AMOLED range.
const float SATURATION  = 1.2;   // 1.0 = off. 1.15-1.3 gives a vibrant, "vivid mode" look.
const vec3 LUMA = vec3(0.2126, 0.7152, 0.0722);
float ditherNoise(vec2 fragCoord) {
    return fract(52.9829189 * fract(dot(fragCoord, vec2(0.06711056, 0.00583715))));
}

void main() {
    vec4 color = texture(tex, v_texcoord);
    vec3 c = clamp(color.rgb, 0.0, 1.0);
    c *= BRIGHTNESS;
    c = max(c - BLACK_POINT, 0.0) / max(1.0 - BLACK_POINT, 0.0001);
    c = (c - 0.5) * CONTRAST + 0.5;
    c = clamp(c, 0.0, 1.0); // clamp BEFORE computing luma below -- otherwise an
    float luma = dot(c, LUMA);
    c = mix(vec3(luma), c, SATURATION);
    c += (ditherNoise(gl_FragCoord.xy) - 0.5) / 255.0;
    c = clamp(c, 0.0, 1.0);

    fragColor = vec4(c, color.a);
}


#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float w;
    float h;
    float offsetX;
    float offsetY;
};
layout(binding = 1) uniform sampler2D source;

float sdf(vec2 p, vec2 center, vec2 halfSize, float r) {
    vec2 q = abs(p - center) - halfSize + vec2(r);
    return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

void main() {
    vec4 c = texture(source, qt_TexCoord0);
    float totalW = w + offsetX * 2.0;
    float totalH = h + offsetY * 2.0;
    float px = qt_TexCoord0.x * totalW - offsetX;
    float py = qt_TexCoord0.y * totalH - offsetY;
    float r = 8.0;

    vec2 p = vec2(px, py);
    vec2 outerCenter = vec2(w * 0.5, h * 0.5);
    vec2 outerHalf = vec2(w * 0.5, h * 0.5);

    float dOuter = sdf(p, outerCenter, outerHalf, r);

    float dHighlight = sdf(p, vec2(w*0.5, h*0.5 + 1.0), outerHalf, r);
    if (dOuter <= 0.0 && dHighlight > 0.0)
        c.rgb = mix(c.rgb, vec3(1.0, 1.0, 1.0), 0.1);

    float dShadow = sdf(p, vec2(w*0.5, h*0.5 - 2.0), vec2((w-2.0)*0.5, (h-2.0)*0.5), r);
    if (dOuter <= 0.0 && dShadow > 0.0)
        c.rgb = mix(c.rgb, vec3(0.0, 0.0, 0.0), 0.25);

    fragColor = c * qt_Opacity;
}

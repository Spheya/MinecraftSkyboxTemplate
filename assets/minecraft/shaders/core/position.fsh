#version 150

#moj_import <fog.glsl>

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in float isSky;

out vec4 fragColor;

void main() {
    fragColor = linear_fog(ColorModulator, vertexDistance, FogStart, FogEnd, FogColor);
    if(isSky > 0.5) fragColor = vec4(0.0, 0.0, 0.0, 1.0);
}

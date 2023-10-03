#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 FogColor;
uniform vec4 ColorModulator;
uniform vec2 ScreenSize;
uniform float GameTime;

in vec2 texCoord0;
in mat4 projInv;
flat in float isMoon;

in vec4 pos1;
in vec4 pos2;

out vec4 fragColor;

const vec3 daySkyColor = vec3(124.0, 169.0, 255.0) / 255.0;
const vec3 nightSkyColor = vec3(0.0);

float vanillaSkyFog(vec3 view) {
    float f = max(view.y, 0.0);
    f = 1.0 - (f * f);
    return smoothstep(0.0, 1.0, f * f * f * f * f * f * f * f);
}

void main() {
    if(isMoon < 0.5) {
        // Not the moon, vanilla rendering
        vec4 color = texture(Sampler0, texCoord0);
        if (color.a == 0.0) {
            discard;
        }
        fragColor = color * ColorModulator;
        return;
    }

    // Rendering the moon, which we use as the entire skybox
    uint moonPhase = uint(floor(texCoord0.x * 4.0)) + uint(floor(texCoord0.y * 2.0)) * 4u;

    vec4 screenPos = gl_FragCoord;
    screenPos.xy = screenPos.xy / ScreenSize * 2.0 - 1.0;
    screenPos.zw = vec2(1.0);
    vec3 view = normalize((projInv * screenPos).xyz);

    vec3 p1 = pos1.xyz / pos1.w;
    vec3 p2 = pos2.xyz / pos2.w;
    vec3 moonDirection = normalize(p1 + p2);

    /********************
    Put your custom skybox code below here (and remove the example)

    moonphase - contains the phase of the moon (0-8, 0=full moon, 4=new moon)
    view - 
    *********************/

    // Example: vanilla minecraft skybox
    vec3 skyColor = mix(nightSkyColor, daySkyColor, 1.0  / (1.0 + exp(5.0 * moonDirection.y)));
    fragColor = mix(vec4(skyColor, 1.0), FogColor, vanillaSkyFog(view));
}

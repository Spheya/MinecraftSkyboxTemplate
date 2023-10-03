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
    vec3 view = normalize((projInv * vec4(gl_FragCoord.xy / ScreenSize * 2.0 - 1.0, 1.0, 1.0)).xyz);
    vec3 moonDirection = normalize(pos1.xyz / pos1.w + pos2.xyz / pos2.w);

    /************************************************************************
    
    Put your custom skybox code below here (and remove the example)

    moonPhase - contains the phase of the moon (0-8, 0=full moon, 4=new moon)
    view - worldspace viewing vector
    moonDirection - worldspace direction towards the moon

    *************************************************************************/

    // Example: vanilla minecraft skybox
    vec3 skyColor = mix(vec3(0.0), vec3(124.0, 169.0, 255.0) / 255.0, 1.0  / (1.0 + exp(5.0 * moonDirection.y)));
    fragColor = mix(vec4(skyColor, 1.0), FogColor, vanillaSkyFog(view));
}

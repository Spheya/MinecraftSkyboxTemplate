#version 150

in vec3 Position;
in vec2 UV0;

uniform sampler2D Sampler0;

uniform mat4 ModelViewMat;
uniform mat3 IViewRotMat;
uniform mat4 ProjMat;

out vec2 texCoord0;

out mat4 projInv;
flat out float isMoon;

out vec4 pos1;
out vec4 pos2;
out vec4 pos3;
out vec4 pos4;

const vec2[] corners = vec2[](
    vec2(-1, 1), vec2(-1, -1), vec2(1, -1), vec2(1, 1)
);

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    texCoord0 = UV0;
    projInv = mat4(IViewRotMat) *  inverse(ProjMat);

    pos1 = pos2 = vec4(0.0);
    vec3 pos = IViewRotMat * Position;

    isMoon = 0.0;
    if(texelFetch(Sampler0, ivec2(0,0), 0) == vec4(1.0, 0.0, 1.0, 1.0)) {
        isMoon = 1.0;
        gl_Position = vec4(corners[gl_VertexID], 0.0, 1.0);

        if(gl_VertexID == 0) pos1 = vec4(pos, 1.0);
        if(gl_VertexID == 2) pos2 = vec4(pos, 1.0);
    }
}

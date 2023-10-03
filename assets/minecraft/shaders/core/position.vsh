#version 150

#moj_import <fog.glsl>

in vec3 Position;

uniform mat4 ProjMat;
uniform mat4 ModelViewMat;
uniform int FogShape;

out float vertexDistance;
out float isSky;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    
    isSky = 0.0;
    if(abs(Position.y - 16.0) < 0.01 && (length(Position.xz) < 0.01 || abs(length(Position.xz) - 512.0) < 0.01)) {
        // Everything you put in the sky is additive, so we just render a big black quad to get rid of the clearcolor
        isSky = 1.0;
        gl_Position = vec4(vec2[](vec2(-1, 1), vec2(-1, -1), vec2(1, -1), vec2(1, 1))[gl_VertexID % 4], 0.0, 1.0);
    }

    vertexDistance = fog_distance(ModelViewMat, Position, FogShape);
}

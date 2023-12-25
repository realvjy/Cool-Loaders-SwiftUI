//
//  Shaders.metal
//  Cool Loaders
//
//  Created by vijay verma on 24/12/23.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

float Hash21(vector_float2 p) {
    p = fract(p*vector_float2(123.34, 456.21));
    p += dot(p, p+45.32);
    return fract(p.x*p.y);
}


float Star(vector_float2 uv, float size) {
    float d = length(uv);

    float m = (d < size) ? 0.6 : 0.0;
    return m;
}

float2x2 Rot(float a) {
    float s = sin(a);
    float c = cos(a);
    return float2x2(c, -s, s, c);
}

vector_float3 StarLayer(vector_float2 uv, float scale, float fade){
    vector_float3 col =  vector_float3(0.0);
    
    vector_float2 gv = fract(uv) - 0.5;
    vector_float2 id = floor(uv);
    
    for (int y =-1; y<=1; y++){
        for (int x=-1; x<=1; x++){
            vector_float2 offs = vector_float2(x, y);
            float n = Hash21(id + offs);
            float size = fract(n * 345.32) * 0.04; // Adjust the star size here as needed
                        float intensity = fade * 7.0; // Increase the intensity (brightness) by adjusting the value here
                        float star = Star(gv - offs - vector_float2(n, fract(n * 34.0)) + 1.0, size) * intensity * size;
                        col += star;
        }
    }
    // debug
    //if (gv.x > 0.48 || gv.y > 0.48 ) col.r = 1.0;
    return  col * scale;
}

// based on https://www.shadertoy.com/view/tlyGW3

[[ stitchable ]] half4 starField(
    float2 position,
    half4 color,
    float4 bounds,
    float secs
 ) {
     
     float t = secs * 0.04;
   
     float NUM_LAYER = 8;
     vector_float2 uv = (position * 2.0 - bounds.zw) / bounds.w;
  
     uv *= Rot(t);
     vector_float3 col = vector_float3(0.0);
     for (float i = 0.0; i < 1.0; i += 1.0 / NUM_LAYER) {
         float depth = fract(i + t);
         float scale = mix(40, 0.007, depth);
         // Adjust the fade logic for a zooming effect using an exponential function
         float fade = pow(depth, 1.0); // You can experiment with the power value for the desired effect
         col += StarLayer(uv * scale + i * 823.0, scale, fade);
     }
     uv *= Rot(t * -1.5);
     for (float i = 0.0; i < 1.0; i += 1.0 / NUM_LAYER) {
         float depth = fract(i + t);
         float scale = mix(20, 0.01, depth);
         // Adjust the fade logic for a zooming effect using an exponential function
         float fade = pow(depth, 2.0); // You can experiment with the power value for the desired effect
         col += StarLayer(uv * scale + i * 823.0, scale, fade);
     }
     
     


     return half4(half3(col), 1.0);
 }





[[ stitchable ]] half4 aqua(
    float2 position,
    half4 color
) {
    // R, G, B, A
    return half4(60.0/255.0, 238.0/255.0, 227.0/255.0, 1.0);
}


[[ stitchable ]] half4 circleLoader(
    float2 position,
    half4 color,
    float4 bounds,
    float secs
) {
    float cols = 6;
    float PI2 = 6.2831853071795864769252867665590;
    float timeScale = 0.04;

    vector_float2 uv = position/bounds.zw;

    float circle_rows = (cols * bounds.w) / bounds.z;
    float scaledTime = secs * timeScale;

    float circle = -cos((uv.x - scaledTime) * PI2 * cols) * cos((uv.y + scaledTime) * PI2 * circle_rows);
    float stepCircle = step(circle, -sin(secs + uv.x - uv.y));

    // Blue Colors
    vector_float4 background = vector_float4(0.2, 0.6, 0.6, 1.0);
    vector_float4 circles = vector_float4(0, 0.8, 0.8, 1.0);

    return half4(mix(background, circles, stepCircle));
}

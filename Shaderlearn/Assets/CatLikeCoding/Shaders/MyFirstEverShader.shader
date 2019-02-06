// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/My First Shader" {
    Properties {
        _Tint ("Tint", Color) = (1, 1, 1, 1)
    }
    	SubShader { //different subshaders for different platforms
            pass {
                CGPROGRAM //all our cg/hlsl shader is between these to keywords
                    #pragma vertex MyVertexProgram //special compiler directives to tell use these vert and frag prgrams
                    #pragma fragment MyFragmentProgram

                    #include "UnityCG.cginc" //including some stuff 

                    float4 _Tint;

                    float4 MyVertexProgram (float4 position : POSITION, out float3 localPosition : TEXCOORD0) : SV_POSITION { //system value position, basically to indicate that we are returning position value
                                                              //Unity's shader compiler takes code and transforms it into a different program, 
                                                              //depending on the target platform. Direct3D for Windows, OpenGL for Macs, OpenGL ES for mobiles

                                                              //this dude returns a float4
                        
                        
                        localPosition = position.xyz;
                        return UnityObjectToClipPos (position); //to correctly project our points on display, equivalent of mul(UNITY_MATRIX_MVP,*) 
                        //return position;
                    }
                    float4 MyFragmentProgram (float4 position : SV_POSITION, float3 localPosition : TEXCOORD0 ) : SV_TARGET { //: TEXCOORD0 for how to interpret data
                        return float4 (localPosition, 1);                  //opaque shaders dont care about alpha value
                    }


                ENDCG

            }
	}
}
//till texturing

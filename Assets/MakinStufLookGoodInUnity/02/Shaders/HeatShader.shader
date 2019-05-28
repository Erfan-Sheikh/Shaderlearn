﻿Shader "MakingStuffLookGood/ImageEffects/HeatShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _DispTex ("Disp", 2D) = "white" {}
        _Magntude ("Magnitude", Range(0, 0.1)) = 1
    }
    SubShader
    {
        cull off Zwrite off Ztest Always


        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _DispTex;
            float4 _DispTex_ST;
            float _Magntude;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 disp = tex2D(_DispTex, i.uv + _Time.x).xy;
                disp = ((disp * 2) - 1) * _Magntude;
                fixed4 col = tex2D(_MainTex, i.uv + disp);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}

Shader "MakingStuffLookGood/04_GreyscaleMulCol"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("ColorTint", color) = (1, 1, 1, 1)
    }
    SubShader
    {

        LOD 100

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata //info getting from each vert from mesh
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0; //TEXCOORD0 is an identifier
            };

            struct v2f //what info we are passing into frag
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;

            v2f vert (appdata v) //takes app data returns v2f
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); //transforms point relative to the object to points on the screen
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target //takes v2d returns color float4
            {
                float4 Mycolor = tex2D(_MainTex, i.uv);
                float lum = Mycolor.r * 0.3 + Mycolor.g * 0.59 + Mycolor.b * 0.11;
                float4 gsg = float4 (lum, lum, lum, Mycolor.a);
                return gsg * _Color;
            }
            ENDCG
        }
    }
}

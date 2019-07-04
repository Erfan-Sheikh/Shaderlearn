Shader "MakingStuffLookGood/01/01_ReversedUv"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
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

            v2f vert (appdata v) //takes app data returns v2f
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); //transforms point relative to the object to points on the screen
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target //takes v2d returns color float4
            {
                float4 color = float4 (i.uv.r ,i.uv.g, 1, 1);
                return color;
            }
            ENDCG
        }
    }
}

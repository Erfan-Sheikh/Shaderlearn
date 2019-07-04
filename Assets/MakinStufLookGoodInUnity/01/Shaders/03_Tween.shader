Shader "MakingStuffLookGood/01/03_Tween"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SecondTex ("Texture", 2D) = "white" {}
        _Tween ("Tween", Range (0, 1)) = 0
    }
    SubShader
    {
        Tags { 

            "Queue" = "Transparent" //so that our sprite renders after the opaque geos in the scene
        } 
        LOD 100

        Pass
        {
            Blend SrcAlpha OneMinussrcAlpha //SrcColor*SrcAlpha + DstColor*OneMinusSrcAlpha (Think In Transparent Pic)
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
            sampler2D _SecondTex;
            float4 _SecondTex_ST;
            float _Tween;

            v2f vert (appdata v) //takes app data returns v2f
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); //transforms point relative to the object to points on the screen
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target //takes v2d returns color float4
            {
                float4 color = tex2D(_MainTex, i.uv);
                float4 SecondCol = tex2D(_SecondTex, i.uv);

                return (color * _Tween) + (SecondCol * (1 - _Tween));
            }
            ENDCG
        }
    }
}

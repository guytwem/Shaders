Shader "MyShader/Shader1"
{
    Properties
    {
       [NoScaleOffset]
       _MainTex("Texture", 2D) = "white" {}
       _Health("Health", Range(0,1)) = 1
       _Chunks("Chunks", int) = 1
    }
    SubShader
    {
        //Tags { "RenderType"="Opaque" }
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
        

        Pass
        {
            ZWrite off
            //src * X + dst * Y
           //src *  SrcAlpha + dst * (1 - SrcAlpha)
            Blend SrcAlpha OneMinusSrcAlpha 



            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
          
           

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
               
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _Health;
            int _Chunks;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv; //TRANSFORM_TEX(v.uv, _MainTex);


           
                return o;
            }

            float InverseLerp(float a, float b, float v) 
            {
                return (v - a) / (b - a);
            }

            fixed4 frag(v2f i) : SV_Target
            {

                float healthBarMask = _Health > i.uv.x;
                // sample the texture
                float3 healthBarColor = tex2D(_MainTex, float2(_Health, i.uv.y));
                //flashing
                float flash = (cos(_Time.y * 4) * 0.4f) + 1;
                //return float4(flash.xxx, 1);
                float flashMask = _Health < 0.3;
                healthBarColor = lerp(healthBarColor, healthBarColor * flash, flashMask);
                
                return float4(healthBarColor * healthBarMask, 1);
                

                
            }
            ENDCG
        }
    }
}
//set up colors
                //float tHealthColor = saturate (InverseLerp(0.2, 0.8 , _Health));
                //float3 healthBarColor = lerp(float3(10, 0, 0), float3(0, 10, 0), tHealthColor);
                //float3 bgColor = float3(0, 0, 0);

                //set up maks
                //floor(i.uv.x * _Chunks)/_Chunks;

                //gets rid of black background
                //clip(healthBarMask - 0.0001);


                //float3 outColor = lerp(bgColor, healthBarColor, healthBarMask);

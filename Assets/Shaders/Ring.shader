Shader "Unlit/Ring"
{
    Properties
    {
        _Color  ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _MinimumRenderDistance ("Minimum Render Distance", Float) = 10
        _MinimumFadeDistance ("Minimum Fade Distance", Float) = 20
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Pass
        {
            CGPROGRAM
          #pragma surface surf Standard fullforwardshadows

          #pragma target 3.0

          sampler2D _MainTex;

          struct Input {    
            float2 uv_MainTex;
            float3 worldPos;
          };

          half _Glossiness;
          half _Metallic;
          fixed4 _Color;
          float _MinimumRenderDistance;
          float _MinimumFadeDistance;

          void surf (Input IN, inout SurfaceOutputStandard o) {
                float distance  = length(_WorldSpaceCameraPos - IN.worldPos);
                //fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
                fixed3 color = fixed3(0,0,0);
                o.Albedo = color;
                o.Metallic = _Metallic;
                o.Smoothness = _Glossiness;
                o.Alpha = c.a;
          
          }
          ENDCG

          
        }
        Fallback "Diffuse"
    }
}

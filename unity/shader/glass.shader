Shader "Custom/Glass" {
	Properties {
		_MainColor("MainColor", Color) = (1, 1, 1, 1)
		_Transparent("Transparent", Range(0, 1)) = 0.5
	}

	SubShader {
		Pass
		{
			Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
			Blend SrcAlpha DstAlpha

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float4 _MainColor;
			float _Transparent;

			struct Out
			{
				float4 pos : SV_POSITION;
				float3 normal : TEXCOORD0;
			};

			Out vert(appdata_base v)
			{
				Out o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.normal = mul(v.normal, (float3x3)_World2Object);
				return o;
			}

			float4 frag(Out i) : Color
			{
				 fixed3 worldNormal = normalize(i.normal);  
                
				fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                
				fixed3 diffuse = dot(worldNormal, worldLightDir);

				float4 color = _MainColor;

				color.rgb = color.rgb * diffuse;

				color.a = _Transparent;

				return color;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}

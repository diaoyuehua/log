Shader "Custom/Outlighting" {
	Properties {
		_MainColor("MainColor", Color) = (1, 1, 1, 1)
		_LightColor("LightColor", Color) = (1, 1, 1, 1)
		_LightPower("LightPower", Float) = 5
		_LightIntensity("LightIntensity", Float) = 2
	}

	SubShader {
		Pass
		{
			Tags { "RenderType" = "Opaque" }
			Cull Back

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float4 _MainColor;
			float4 _LightColor;
			float _LightPower;
			float _LightIntensity;

			struct Out
			{
				float4 pos : SV_POSITION;
				float3 normal : TEXCOORD0;
				float3 worldpos : TEXCOORD1;
			};

			Out vert(appdata_base v)
			{
				Out o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.normal = mul((float3x3)_Object2World, v.normal);
				o.worldpos = mul(_Object2World, v.vertex).xyz;

				return o;
			}

			float4 frag(Out i) : Color
			{
				
				float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldpos);
				float3 normal = normalize(i.normal);
				float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);

				float diffuse = max(0.0, dot(normal, lightDir));

				float rim = 1.0 - max(0.0, dot(normal, viewDir));
				float3 emissive = _LightColor.rgb * pow(rim, _LightPower) * _LightIntensity;

				float3 color = diffuse * _MainColor + emissive;

				return float4(color, 1.0);
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}

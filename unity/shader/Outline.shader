Shader "Custom/Outline" {
	Properties {
		_MainColor("MainColor", Color) = (1,1,1,1)
		_OutlineColor("OutlineColor", Color) = (1,0,0,0)
		_OutlineWidth("OutlineWidth", Float) = 0.1
	}
	SubShader {
		Pass
		{
			Cull Front
			Offset 1,1

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			fixed4 _OutlineColor;
			float _OutlineWidth;

			struct Out
			{
				float4 pos : SV_POSITION;
			};

			Out vert(appdata_full v)
			{
				Out o;
				
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				float3 vnormal = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);

				float2 offset = TransformViewToProjection(vnormal.xy);

				o.pos.xy += offset * _OutlineWidth;

				return o;
			}


			fixed4 frag(Out o) : SV_Target
			{
				return _OutlineColor;
			}

			ENDCG
		}
		
		Pass
		{
			Tags{"LightMode" = "ForwardBase"}
			Cull Back

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			fixed4 _MainColor;

			struct Out
			{
				float4 pos : SV_POSITION;
				float3 nor : TEXCOORD0;
			};

			Out vert(appdata_base v)
			{
				Out o;
				
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				o.nor = mul(v.normal, (float3x3)_World2Object);

				return o;
			}

			fixed4 frag(Out o) : SV_Target
			{                
                fixed3 worldNormal = normalize(o.nor);  
                
				fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                
                fixed3 diffuse = dot(worldNormal, worldLightDir);
                
                fixed4 color = _MainColor;

                color.rgb = color.rgb * diffuse;

                return fixed4(fixed4(color)); 
			}

			ENDCG
		}
		
	}

	FallBack "Diffuse"
}


Shader "Custom/SkyboxRender"
{
	Properties
	{
//	[KeywordEnum (None , Simple , High Quality)] _SunDisk ("Sun", Int) = 2
//	_SunSize ("Sun Size" , Range(0,1)) = 0.04
//	_SunSizeConvergence ("Sun Size Convergence", Range(1,10)) = 5
//
//	_AtmosphereThickness ("Atmosphere Thickness", Range(0,5)) = 1.0
//	_SkyInt("Sky Tint",Color) = (.5,.5,.5,1)
//	_GroundColor("Ground",Color) = (.369, .349, .341, 1)
//
//	_Exposure("Exposure" , Range(0,8)) = 1.3
		_MainTex ("Texture", 2D) = "white" {}

[Enum(Equal,3,NotEqual,6)] _StencilTest ("Stencil Test",Int) = 6

	}
	SubShader
	{
		Tags { "Queue" = "Background" "RenderType" = "Background" "PreviewType" = "Skybox" }
		Cull off ZWrite off

		Stencil{
			Ref 1
			Comp [_StencilTest]
		}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include  "Lighting.cginc"

//			#Pragma multi_compile_SUNDISK_NONE_SUNDISK_SIMPLE_SUNDISK_HIGH_QUALITY

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
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
}

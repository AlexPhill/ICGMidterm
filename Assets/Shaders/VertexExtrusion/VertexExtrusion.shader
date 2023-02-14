Shader "Alexander/VertexExtrusion"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Main Texture", 2D) = "white"{}
		_Extrusion("Extrusion Amount", Range(0.5,10)) = 1
	}
		SubShader
		{
			Tags {"RenderType" = "Opaque"}
			LOD 200

			CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		sampler2D _MainTex;
		half _Extrusion;

		struct Input {
			float2 uv_MainTex;
		};

		void vert(inout appdata_full v) 
		{
			v.vertex.xyz += v.normal + _Extrusion;
			//v.texcoord.xyz += v.normal + _Extrusion;
		}

		void surf(Input IN, inout SurfaceOutput o) 
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
			ENDCG
		}
		FallBack "Diffuse"
}
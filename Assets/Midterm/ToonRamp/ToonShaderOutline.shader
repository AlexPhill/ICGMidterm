Shader "Alexander/ToonShaderOutline"
{
    Properties
    {
        //Setting up values to be modified in inspector
        _MainTex("Diffuse Texture", 2D) = "white" {}
        _RampTex("Ramp Texture", 2D) = "white"{}
        _RimColor("Rim Color", Color) = (0,0,0.0,0.0)
        _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
    }

        SubShader{

        CGPROGRAM
        #pragma surface surf ToonRamp //telling unity this shader is toonramp

        //collecting values to be edited
        sampler2D _MainTex;
        float4 _RimColor;
        float _RimPower;
        sampler2D _RampTex;

        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
        float diff = dot(s.Normal, lightDir);
        //taking extremes of light reflection so it doesn't transition smoothly
        float h = diff * 0.5 + 0.5;
        float2 rh = h;
        float3 ramp = tex2D(_RampTex, rh).rgb;

        float4 t;
        t.rgb = s.Albedo * _LightColor0.rgb * (ramp); //takes into account the lighting from the scene
        t.a = s.Alpha;
        return t;
        }

    struct Input {
        float2 uv_MainTex;
        float2 uv_RampTex;
        float3 viewDir;
    };

    void surf(Input IN, inout SurfaceOutput o)
    {
        half4 c = tex2D(_MainTex, IN.uv_MainTex); //makes it easier for program to compile in case of change in texture
        half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal)); //finds the edges of the model from the normals and view direction
        o.Albedo = c.rgb - _RimColor.rgb + pow(rim, _RimPower); //mixes albedo with the main texture and rim lighting.
        o.Emission = _RimColor.rgb * pow(rim, _RimPower); //emits rim colour from object
    }
        ENDCG
    }
    FallBack "Diffuse" //in case the shader doesn't compile correctly
}

uniform vec3 u_viewVec;
uniform vec4 u_rampStart;
uniform vec4 u_rampEnd;
uniform vec3 u_rimData;

layout(location = 0) in vec3 in_pos;
layout(location = 1) in vec3 in_normal;
layout(location = 2) in vec4 in_color;
layout(location = 3) in vec2 in_tex0;

out vec4 v_color;
out vec2 v_tex0;
out float v_fog;

void
main(void)
{
	vec4 Vertex = u_world * vec4(in_pos, 1.0);
	gl_Position = u_proj * u_view * Vertex;
	vec3 Normal = mat3(u_world) * in_normal;

	v_tex0 = in_tex0;

	v_color = in_color;
	v_color.rgb += u_ambLight.rgb*surfAmbient;
	v_color.rgb += DoDynamicLight(Vertex.xyz, Normal)*surfDiffuse;

	// rim light
	float f = u_rimData.x - u_rimData.y*dot(Normal, u_viewVec);
	vec4 rimlight = clamp(mix(u_rampEnd, u_rampStart, f)*u_rimData.z, 0.0, 1.0);
	v_color.rgb += rimlight.rgb;

	v_color = clamp(v_color, 0.0, 1.0);
	v_color *= u_matColor;

	v_fog = DoFog(gl_Position.w);
}

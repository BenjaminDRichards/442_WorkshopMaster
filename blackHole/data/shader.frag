

// https://www.shadertoy.com/view/lsf3RH

#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

float snoise(vec3 uv, float res)
{
	const vec3 s = vec3(1e0, 1e2, 1e4);
	
	uv *= res;
	
	vec3 uv0 = floor(mod(uv, res))*s;
	vec3 uv1 = floor(mod(uv+vec3(5.0), res))*s;
	
	vec3 f = fract(uv); f = f*f*(2.5-3.8*f); //(5.0-3.0*f);
    
	vec4 v = vec4(uv0.x+uv0.y+uv0.z, uv1.x+uv0.y+uv0.z,
		      	  uv0.x+uv1.y+uv0.z, uv1.x+uv1.y+uv0.z);
    
	vec4 r = fract(sin(v*1e-7)*1e7);
	float r0 = mix(mix(r.x, r.y, f.x), mix(r.z, r.w, f.x), f.y);
	
	r = fract(sin((v + uv1.z - uv0.z)*1e-10)*1e5);
	float r1 = mix(mix(r.x, r.y, f.x), mix(r.z, r.w, f.x), f.y);
	
	return mix(r0, r1, f.z)*3.-0.1*(sin(sin(-time)*1.0)+1.5*0.5);
}

void main(void)
{
	vec2 p = sin(-.7)*.7 + gl_FragCoord.xy / resolution.xy;
	p.x *= resolution.x/resolution.y;
	
	float color = 4.3 - (2.8/length(8.8*p));
	
	vec3 coord = vec3(atan(p.x,p.y)/6.2832+8.5, length(p)/.2, .8);
    
    /*
    if(length < 1){
     vec3 coord = vec3(atan(p.x,p.y)/6.2832+1.5, length(p)/.6, .1);
     }else{
     vec3 coord = vec3(atan(p.x, p.y)/6.2832+length(p), length(p)/.6, .1);
	*/
    
	for(int i = 0; i <= 10; i++)
	{
		float power = pow(5.0, float(i));
		color += (4.5 / power) * snoise(coord - vec3(0.,-time*.3, -time*.11), power*11.);
	}
	gl_FragColor = vec4( 1.0-color*.5, 1.0-pow(max(color,0.0),0.8)*0.4, 1.0-pow(max(color,0.),1.9)*0.15 , 5.0-color);
}
#define PROCESSING_TEXTURE_SHADER

uniform sampler2D tex;
uniform float time;
uniform float speed;

varying vec4 vertTexCoord;

void main(){
	
	vec2 uv = vec2(clamp(vertTexCoord.x + sin(sin(time)*speed*vertTexCoord.x * (1.0-vertTexCoord.x)*sin(vertTexCoord.y*1.0))/2.0, 0.0, 1.0), vertTexCoord.y);
	
	gl_FragColor = texture2D(tex,uv);

}
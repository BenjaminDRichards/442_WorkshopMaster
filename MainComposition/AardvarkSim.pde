class AardvarkSim {

  AE_AnimationEngineManager animation_manager;
  ArrayList breads;
  int breadsCount = 13;

  void setup() {
    
    this.animation_manager = new AE_AnimationEngineManager("aardvark.png", 200, 200);
   
    this.breads = new ArrayList();
    for (int i = 0; i < breadsCount; i++) {
      this.breads.add(new AI("bread.png", (int) random(0, width), (int) random(height), (int) random(3, 6)));
    } 
  }
  
  void bakeBread(){
    this.breads.add(new AI("bread.png", (int) random(0, width), (int) random(height), (int) random(3, 6)));
  }
  
  void eatBread(int targetBread){
    if(targetBread != -1){
      this.breads.remove( targetBread);
    }
    
//    if(this.breads.size() > 0){
//      this.breads.remove( (int)floor( random(0, this.breads.size() )));
//    }
  }
  
  int getNearestBread(PVector point){
    float smallestDist = 0.0;
    int smallestIndex = -1;
    
    for(int i = 0; i < this.breads.size(); i++){
      AI bread = (AI)this.breads.get(i);
      PVector breadPos = new PVector(bread.xPos, bread.yPos);
      float distance = dist(breadPos.x, breadPos.y, point.x, point.y);
      if(i == 0){
        smallestDist = distance;
      } else {
        if( distance < smallestDist ){
          smallestDist = distance;
          smallestIndex = i;
        }
      }
    }
    
    return smallestIndex;
  }
  
  void update() {
    
  }
  
  void draw() {
    for (int i = 0; i < this.breads.size(); i++) {
       AI bread = (AI) this.breads.get(i); 
       
       bread.animate((int) this.animation_manager.pos.x, (int) this.animation_manager.pos.y);
       if (random(0, 1) < 0.003) {
         bread.cState = (bread.cState == 1 ? 0 : 1);
       }
    }
   
    this.animation_manager.animate(); 
  }
}

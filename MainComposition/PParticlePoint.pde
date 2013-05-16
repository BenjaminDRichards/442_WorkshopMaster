class PParticlePoint
{
  PVector mPos;
  PVector mVel;
  PVector mAccel;
  
  float mMaxVel;
  float mMaxAccel;
  float mFriction;
  
  PParticlePoint(PVector iPos) 
  {
    mPos = iPos;
    mVel = new PVector();
    mAccel = new PVector();
    
    mMaxVel = 5;
    mMaxAccel = 2;
    mFriction = 0.8;
    
    rectMode(CENTER);
    fill(222);
  }
  
  void setLimits(float iMaxVel, float iMaxAccel, float iFriction)
  {
     mMaxVel = iMaxVel;
     mMaxAccel = iMaxAccel;
     mFriction = iFriction;
  }
  
  void applyForce(PVector iForce)
  {
     iForce.limit(mMaxAccel);
     mAccel.add(iForce);
  }
 
  void update()
  {
     mVel.add(mAccel);
     mVel.limit(mMaxVel);
     mAccel.mult(0);
     
     mPos.add(mVel);
     mVel.mult(mFriction);
  }
  
  void draw() {
     noStroke();
     
     rect(mPos.x, mPos.y+2, 2, 4);
     rect(mPos.x-4, mPos.y, 2, 3);
     rect(mPos.x+4, mPos.y, 2, 3);
     stroke(0);
     line(mPos.x-2, mPos.y-2, mPos.x-1, mPos.y-5);
     line(mPos.x+2, mPos.y-2, mPos.x+1, mPos.y-5);
  }
}

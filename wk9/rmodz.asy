import animation2;
import graph;

real x(real t) {return cos(2pi*t);}
real y(real t) {return sin(2pi*t);}
real xf(real t) {return 1+2pi*t;}
real yf(real t) {return 0;}


animation a;
picture pic; pic.size(500);
int frames = 30;

//draw(pic,(1,0)--(1+2pi,0));
//a.add(pic);
//pic.erase();

for(int i = 0; i < frames + 1;++i){
  pair interp(real t){
  pair out;
  pair c = (cos(2pi*i/frames),sin(2pi*i/frames));
  real s = t-i/frames;
  if(s<0) {
    out = (cos(2pi*t),sin(2pi*t));
  } else {
    out = c + 2pi*s*(-c.y,c.x);
  }
  return out;
  }
  real interpx(real t){return interp(t).x;}
  real interpy(real t){return interp(t).y;}
  draw(pic,graph(interpx,interpy,0,1,n=1000,join=Spline),black+2bp);
  pic = rotate(-90)*pic;
  a.add(pic);
  pic.erase();
}

a.movie(firstDelay=400,lastDelay=400);
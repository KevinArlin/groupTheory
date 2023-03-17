import palette;
import graph3;
import animation2;
size(200);
int patchesx = 32;
animation a;
int frames = 10;
currentprojection=
  perspective(camera=(0.964111994193771,-5.6481242005136,10.1665870847247),
              up=(0.000164872572658646,0.040301140756016,0.0244223639528133),
              target=(-1.47368137007404,0.0158638695249307,0.836480645082002),
              zoom=0.225801269021897,
              angle=55.8409705563155,
              autoadjust=false);

real f(triple xyz){ return length(xyz);}

surface s = surface(new triple(pair xy){ return (xy.x,xy.y,0);},(-pi,-1.5*pi),(pi,1.5*pi),patchesx,patchesx,Spline);

triple partCyl(pair xy, real t){
  real u = xy.x;
  real y = xy.y;
  if(t == 0) return (xy.x,y,0);
  real radius = 1/tan(pi/4 * t);
  pair xz = (radius*sin(u/radius),-radius*cos(u/radius)+radius);
  return (xz.x,y,xz.y);
}

surface cyl(real t){
  surface a = surface(new triple(pair xy){return partCyl(xy,t);},(-pi,-1.5*pi),(pi,1.5*pi),patchesx,patchesx,Spline);
  a.colors(palette(s.map(f),Rainbow()));
  return a;
}

triple partTor(pair xy, real t){
  if (t == 0) return partCyl(xy,1);
  real u = xy.x;
  real v = xy.y;
  real radius = 1.5/tan(pi/4*t);
  real theta = v/radius;
  real x = radius*cos(theta)-radius+sin(u)*cos(theta);
  real y = radius*sin(theta)+sin(u)*sin(theta);
  real z = -cos(u)+1;
  return (x,y,z);
}

surface tor(real t){
  surface a = surface(new triple(pair xy){return partTor(xy,t);},(-pi,-1.5*pi),(pi,1.5*pi),patchesx,patchesx,Spline);
  a.colors(palette(s.map(f),Rainbow()));
  return a;
}

for(int i = 0; i < frames; ++i){
  surface c = cyl(1/frames*i);
  draw(c); draw(c.uequals(0)); draw(c.vequals(0));
  a.add();
  erase();
}

for(int i = 0; i < frames+1; ++i){
  surface t = tor(1/frames*i);
  draw(t);
  draw(t.uequals(0)); draw(t.vequals(0));
  a.add();
  erase();
}

int[] delays = array(a.pictures.length,50);
delays[0]=1000; delays[frames] = 500; delays[delays.length-1]=2000;
a.movie(delays=delays);








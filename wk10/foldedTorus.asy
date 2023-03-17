import palette;
import graph3;
size(200);
int patchesx = 32;
int frames = 10;
currentprojection=
  perspective(camera=(0.964111994193771,-5.6481242005136,10.1665870847247),
              up=(0.000164872572658646,0.040301140756016,0.0244223639528133),
              target=(-1.47368137007404,0.0158638695249307,0.836480645082002),
              zoom=0.225801269021897,
              angle=55.8409705563155,
              autoadjust=false);

surface s = surface(new triple(pair xy){ return (xy.x,xy.y,0);},(-pi,-1.5*pi),(pi,1.5*pi),patchesx,patchesx,Spline);

triple partTor(pair xy, real t){
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
  a.colors(palette(s.map(length),Rainbow()));
  return a;
}

path3 c = (1,0,0)..(0,1,0)..(-1,0,0)..(0,-1,0)..cycle;
surface t = tor(1);
draw(t); draw(t.uequals(0)); draw(t.vequals(1));





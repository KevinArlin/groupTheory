import graph3;
import palette;

currentprojection=orthographic(4,0,2);
int patches = 8;

triple torus(pair t) {
  return ((1+1/2*cos(t.y))*cos(t.x),(1+1/2*cos(t.y))*sin(t.x),1/2*sin(t.y)+2);
}

size(200);
real m(triple t){
  triple inPlane = dir((xpart(t),ypart(t),0));
  triple cmp = t-inPlane;
  return dot(cmp,inPlane)/length(cmp) + dot(t,X)/length(t);
}
surface t=surface(torus,(0,0),(2pi,2pi),patches,patches,Spline);
t.colors(palette(t.map(m),Rainbow()));

write(m((-1/2,0,0)));
write(m((-3/2,0,0)));
//draw(p--p+n,cyan,BeginArrow3);
draw(t.uequals(0));
draw(t.vequals(0));
draw(t);
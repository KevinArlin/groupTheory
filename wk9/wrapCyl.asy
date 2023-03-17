import three;
import graph3;
import animation2;

currentprojection=orthographic(4,1,2);

real R=pi/2;
animation a;
int frames = 20;
picture pic;
pic.size(200);


triple cyl(pair t) {
  return (t.x,sin(t.y),-1*cos(t.y)+1);
}

triple flat(pair t) {
 return (t.x,t.y,0); 
}


pen p=rgb(0.2,0.5,0.7);
surface wrapped=surface(cyl,(-2,-pi),(2,pi),8,8,Spline);
surface unwrapped=surface(flat,(-2,-pi),(2,pi),8,8,Spline);

for(int i = 0;i< frames + 1;++i){
  triple interpolate(pair t){return i/frames*cyl(t)+(frames-i)/frames * flat(t);}
  surface s = surface(interpolate,(-2,-pi),(2,pi),8,8,Spline);
  draw(pic,s,mediumcyan);
  a.add(pic);
  pic.erase();
}

a.movie(firstDelay=500,lastDelay=500);

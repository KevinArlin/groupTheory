import solids;
size(300);
currentprojection=
  orthographic(camera=(0.172257697298581,-0.156868089234663,3.78841092845248),
               up=(-0.00839853734200705,-0.000398491894968318,0.000365378008672506),
               target=(4.44089209850063e-16,0,0),
               zoom=0.576183636853657);
animation a;
octahedron o = octahedron(lPen=black+fontsize(24pt));
int frames = 20;
triple[] vs = o.S.vertices;
transform3 g = rotate(1/frames*90,vs[2],vs[5]);
transform3 gm1 = inverse(g);
transform3 t = rotate(1/frames*90,vs[0],vs[3]);
transform3 tm1 = inverse(t);
int j = 0;

for(int i = 0; i < frames;++i){
  draw(unitsphere,invisible);
  draw(o);
  a.add(); erase();
  o.S = g * o;
}

for(int i = 0; i < frames;++i){
  draw(unitsphere,invisible);
  draw(o);
  a.add(); erase();
  o.S = t * o;
}

for(int i = 0; i < frames;++i){
  draw(unitsphere,invisible);
  draw(o);
  a.add(); erase();
  o.S = gm1 * o;
}

for(int i = 0; i < frames;++i){
  draw(unitsphere,invisible);
  draw(o);
  a.add(); erase();
  o.S = g * o;
}

for(int i = 0; i < frames;++i){
  draw(unitsphere,invisible);
  draw(o);
  a.add(); erase();
  o.S = tm1 * o;
}

for(int i = 0; i < frames;++i){
  draw(unitsphere,invisible);
  draw(o);
  a.add(); erase();
  o.S = gm1 * o;
}
a.movie(delays=a.makeDelays());

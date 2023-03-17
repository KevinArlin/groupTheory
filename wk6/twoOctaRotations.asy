import solids;
currentprojection=orthographic(camera=(0.527377237368167,-0.760013744077611,9.16456393013455),
               up=(-0.00135644566436738,0.0268113278627014,0.00230151007735166),
               target=(0,0,0),
               zoom=1);

animation a;
octahedron o1 = octahedron();
octahedron o2 = octahedron();

o2.S = shift((3,0,0))*o2;



int frames = 19;
for(int i = 0; i < frames + 1; ++i){
  draw(scale3(2)*unitsphere,invisible);
  draw(shift((3,0,0))*scale3(2)*unitsphere,invisible);
  transform3 t1=rotate(i/frames*90,o1.S.vertices[5]);
  transform3 t2=rotate(-i/frames*90,o2.S.vertices[2],o2.S.vertices[5]);
  draw(t1*o1); draw(t2*o2);
  a.add(); erase();
}
for(int i = 0; i < frames + 1; ++i){
  draw(scale3(2)*unitsphere,invisible);
  draw(shift((3,0,0))*scale3(2)*unitsphere,invisible);
  transform3 t1=rotate(90-i/frames*90,o1.S.vertices[5]);
  transform3 t2=rotate(-90+i/frames*90,o2.S.vertices[2],o2.S.vertices[5]);
  draw(t1*o1); draw(t2*o2);
  a.add(); erase();
}

int[] delaysOutbound = array(a.pictures.length # 2,50);
int[] delaysInbound = array(a.pictures.length # 2,20);
int[] delays = delaysOutbound;
delays.append(delaysInbound);
delays[0]=450;
delays[frames]=250;

a.movie(delays=delays);

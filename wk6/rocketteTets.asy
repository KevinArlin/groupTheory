import solids;
size(800,300);
currentprojection=
  orthographic(camera=(7.17278974459052,-9.73073468212654,-8.55597991800164),
               up=(0.0200668067123782,-0.023222744141415,0.0432340130259028),
               target=(0,1.77635683940025e-15,0),
               zoom=0.834832972205947);
tetrahedron[] t;
for(int i = 0;i<4;++i){ t.push(tetrahedron(lPen=black+fontsize(16)));}
t[0].S.labels = new string[] {"$1$","$2$","$4$","$3$"};
t[1].S.labels = new string[] {"$2$","$4$","$1$","$3$"};
t[3].S.labels = new string[] {"$4$","$1$","$2$","$3$"};
t[2].S.labels = new string[] {"$3$","$2$","$1$","$4$"};

typedef triple x(triple);
typedef path3 y(path3);
x move(real t){
  return new triple(triple v) {return shift(t*X)*v;};
}
y moveit(real t){
  return new path3(path3 p) { return shift(t*X)*p;};
}
for(int i =0;i<4;++i){
  t[i].S.vertices = map(move(3*(i-1)),t[i].S.vertices);
  t[i].S.edges = map(moveit(3*(i-1)),t[i].S.edges);
  t[i].S.faces = map(moveit(3*(i-1)),t[i].S.faces);
  draw(t[i]);
}

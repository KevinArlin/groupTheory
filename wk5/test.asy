draw((-3,0)--(3,0),Arrows);
raus r = 0.1;
for(int i = -2;i<3;++i) {
  dot((i,0)); label(string(i),(i,0),N);
  draw((i,1)--(i,2-r));
  dot(string(i),(i,1),W);
  label(string(i+1),(i,2),W);
  draw(circle((i,2),r));
}
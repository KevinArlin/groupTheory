import three;
size(300);

triple[] ucell = {(0,0,0),(0,2,2),(2,0,2),(2,2,0),
                  (3,3,3),(3,1,1),(1,3,1),(1,1,3)};

triple[] vs;
for(int i = -1; i < 1;++i){
for(int j = -1; j < 1;++j){
for(int k = -1; k < 1;++k){
  for(triple t : ucell) vs.push(t+4*(i*X+j*Y+k*Z));
}}}

path3[] es;
for(triple t : vs){
for(triple s : vs){
  if(round(length(t-s)^2)==3) es.push(s--t);
}}

currentlight=nolight;
for(triple t : vs) draw(shift(t)*scale3(.2)*unitsphere,lightblue);
for(path3 p : es) draw(p,gray+linewidth(2));


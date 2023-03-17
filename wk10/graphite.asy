import three;
size(300);
currentlight=nolight;
currentprojection=orthographic(Z);

pair[] hx = {dir(30),dir(90),dir(150),dir(210),dir(270),dir(330)};
path3 hex;
for(pair p : hx) hex = hex--XYplane(p);
hex = hex--cycle;
real fact = .335/.142;

path3[] hexes;
for(int i = -2; i < 1;++i){
for(int j = -2; j <0; ++j){
for(int k = -2; k < 1; ++k){
  write(k % 2);
  real offsetj = (j % 2 == 0) ? 0 : sqrt(3)/2;
  real offsetk = (k % 2 == 0) ? 0 : 1;
  path3 pth = shift((sqrt(3)*i+offsetj,3/2*j+offsetk,fact * k))*hex;
  draw(pth,linewidth(2)+gray);
  for(int m = 0; m < 6; ++m)
    draw(shift(point(pth,m))*scale3(0.2)*unitsphere,lightblue);
}}}


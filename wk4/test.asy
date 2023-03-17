size(200);

pair[] gs; pair[] hs; pair[] ngs; pair[] nhs;
int[] glabs = {2,4,8,10,14,16};
int[] hlabs = {3,6,9,12,15,18};
for(int i =0;i<6;++i) {
  gs.push((0,-1*i));
  hs.push((2,-1*i));
}
for(pair xy : gs) ngs.push(shift((4,0))*xy);
for(pair xy : hs) nhs.push(shift((4,0))*xy);
for(int i = 0; i < gs.length;++i){
label(string(glabs[i]),gs[i]);
label(string(hlabs[i]),hs[i]);
label(string(glabs[i]),ngs[i]);
label(string(hlabs[i]),nhs[i]);
}
path short(pair a,pair b){
  pair shortener=0.2*dir(b-a);
  return a+shortener--b-shortener;
}

draw(short(gs[0],hs[0]),blue,Arrow(2mm),BeginBar);
draw(short(gs[1],hs[2]),blue,Arrow(2mm),BeginBar);
draw(short(gs[2],hs[1]),blue,Arrow(2mm),BeginBar);
draw(short(gs[3],hs[4]),blue,Arrow(2mm),BeginBar);
draw(short(gs[4],hs[3]),blue,Arrow(2mm),BeginBar);
draw(short(gs[5],hs[5]),blue,Arrow(2mm),BeginBar);

draw(short(ngs[0],nhs[3]),red,Arrow(2mm),BeginBar);
draw(short(ngs[1],nhs[5]),red,Arrow(2mm),BeginBar);
draw(short(ngs[2],nhs[1]),red,Arrow(2mm),BeginBar);
draw(short(ngs[3],nhs[4]),red,Arrow(2mm),BeginBar);
draw(short(ngs[4],nhs[0]),red,Arrow(2mm),BeginBar);
draw(short(ngs[5],nhs[2]),red,Arrow(2mm),BeginBar);


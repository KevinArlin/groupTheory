size(500);
real shrinkage = 0.45;

pair[] getChildren(pair xy, pair dirx, real scaleFact){
  pair[] children = {xy+rotate(-90)*(scaleFact*dirx),xy+scaleFact*dirx,xy+rotate(90)*(scaleFact*dirx)};
  return children;
}

void drawDescendants(pair xy, pair dirx, real scaleFact, int generations){
pair[] children = getChildren(xy,dirx,scaleFact);
  for(pair child : children) {
    draw(xy--child);
    if(generations>0) drawDescendants(child,dir(child-xy),scaleFact*shrinkage,generations-1); 
  }
}

void drawF2(pair center=(0,0),int depth,real shrinkage=shrinkage){
  pair[] children = {center+E,center+N,center+W,center+S};
  for(pair child : children){
    draw(center--child);
    if(depth > 0) drawDescendants(child,dir(child-center),shrinkage,depth-1);
  }
}

drawF2(depth=8);

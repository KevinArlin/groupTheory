import solids;
import math;
size(200);
pen[] fPens = array(12,red);
dodecahedron d = dodecahedron(fPens=fPens);
icosahedron i = icosahedron();

//find rotation sending frm to to about an axis through axisPoint
transform3 rotateTo(triple frm, triple to, triple axisPoint){
  triple fromProj = planeproject(axisPoint)*frm;
  triple toProj = planeproject(axisPoint)*to;
  int sign = orient(frm,to,axisPoint,O) > 0 ? 1 : -1;
  real degs = sign*aCos(dot(fromProj,toProj)/(length(fromProj)*length(toProj)));
  return rotate(degs,axisPoint);
}


//Center of a face of dodec to be inscribed
triple cent = 1/3*(i.S.vertices[11]+i.S.vertices[0]+i.S.vertices[5]); 
real scaledown = length(cent)/length(d.S.vertices[4]);
d.S = scale3(scaledown)*d.S;

//center of a second face to rotate into place
triple cent2 = 1/3*(i.S.vertices[10]+i.S.vertices[5]+i.S.vertices[11]);
transform3 t = rotateTo(d.S.vertices[13],cent2,d.S.vertices[4]);
d.S = t*d.S;

draw(i);
draw(d);

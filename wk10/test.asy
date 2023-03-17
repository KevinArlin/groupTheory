import math;
pair v = (0,0);
pair w = (1,0);
pair fv = (1,2);
pair fw = (1+sqrt(2)/2,2+sqrt(2)/2);

draw(v--fv,dotted);
draw(w--fw,dotted);

dot("$v$",v,W);
dot("$w$",w);
dot("$f(v)$",fv,W);
dot("$f(w)$",fw,E);
//dot((-4,0),invisible);

path perpBis(pair A, pair B){
pair avz = (A+B)/2;
pair dirz = rotate(90)*(A-B);
return avz-1.5*dirz--avz+dirz;
}
path pv=perpBis(v,fv);
path pw=perpBis(w,fw);
draw(pv,pink);
draw(pw,pink);

path vw = v--w;
path fvfw = fv--fw;

draw("$d$",vw,NW,blue);
draw("$d$",fvfw,blue);

pair o = intersectionpoint(pv,pw);
dot("$z$",o,NE);
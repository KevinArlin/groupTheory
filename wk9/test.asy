pair e = (0,0);
pair a = (1,0);
pair b = (0,1);
label("$e$",e); 
label("$a$",a); label("$b$",b);
label("$a^{-1}$",-a); label("$b^{-1}$",-b);
label("$a^2$",1.75*a); label("$a^{-2}$",-1.75*a);
label("$ab^{-1}$",a-0.75*b); label("$ab$",a+0.75*b);
label("$ba$",b+0.75*a); label("$ba^{-1}$",b-0.75*a);
label("$b^2$",1.75*b);label("$b^{-2}$",-1.75*b);
label("$a^{-1}b$",-a+0.75*b); label("$a^{-1}b^{-1}$",-a-0.75*b);
label("$b^{-1}a$",-b+0.75*a); label("$b^{-1}a^{-1}$",-b-0.75*a);

path shortEdge(pair p,pair q){
  pair shortener = 0.2*dir(q-p);
  return p+shortener--q-shortener;
}

draw(shortEdge(e,a),red,Arrow(2mm));
draw(shortEdge(e,b),blue,Arrow(2mm));
draw(shortEdge(-a,e),red,Arrow(2mm));
draw(shortEdge(-b,e),blue,Arrow(2mm));

draw(shortEdge(a,1.75*a),red,Arrow(2mm));
draw(shortEdge(a,a+0.75*b),blue,Arrow(2mm));
draw(shortEdge(a-0.75*b,a),blue,Arrow(2mm));

draw(shortEdge(b,1.75*b),blue,Arrow(2mm));
draw(shortEdge(b,b+0.75*a),red,Arrow(2mm));
draw(shortEdge(b-0.75*a,b),red,Arrow(2mm));

draw(shortEdge(-a,-1.75*a),red,BeginArrow(2mm));
draw(shortEdge(-a,-a+0.75*b),blue,Arrow(2mm));
draw(shortEdge(-a-0.75*b,-a),blue,Arrow(2mm));
/*
draw(shortishEdge(a,1.75*a),red,Arrow(2mm));
draw(shortishEdge(a,a+0.75*b),blue,Arrow(2mm));
draw(shortishEdge(a-0.75*b,a),blue,Arrow(2mm));
*/
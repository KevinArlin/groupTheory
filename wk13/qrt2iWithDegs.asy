import three;

size(200);
usepackage("amsfonts");

triple q = (0,0,0);
triple qi = (1,0,1);
triple qrt2 = rotate(120,Z)*qi;
triple qrt2i = rotate(120,Z)*qrt2;
triple k = (0,0,2);

path3 shortPath(triple a, triple b){
  return a+.1(b-a)--b+.1*(a-b);
}

label("$\mathbb Q$",q);
label("$\mathbb Q[i]$",qi);
label("$\mathbb Q[\sqrt 2]$",qrt2);
label("$\mathbb Q[i\sqrt 2]$",qrt2i);
label("$\mathbb Q[\sqrt 2,i]$",k);

path3[] edges = {shortPath(q,qi),
	      	shortPath(q,qrt2),
		shortPath(q,qrt2i),
		shortPath(k,qi),
		shortPath(k,qrt2),
		shortPath(k,qrt2i),
		shortPath(q,k)};

for(path3 edge : edges){
  draw(edge);
  label(edge == shortPath(q,k) ? "$4$" : "$2$",edge);
}
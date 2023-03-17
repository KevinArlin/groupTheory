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

draw(shortPath(q,qi));
draw(shortPath(q,qrt2));
draw(shortPath(q,qrt2i));
draw(shortPath(k,qi));
draw(shortPath(k,qrt2));
draw(shortPath(k,qrt2i));
draw(shortPath(q,k));



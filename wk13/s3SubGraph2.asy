import three;
size(200);
usepackage("amsfonts");
triple Q = (0,0,0);
triple k1 = (1,0,1);
triple k2 = rotate(120,Z)*k1;
triple k3 = rotate(-120,Z)*k1;
triple el = (0,0,1);
triple K = (0,0,2);

path3 shortEdge(triple a,triple b){
  triple shortener = .15*(b-a);
  return a+shortener--b-shortener;
}

path3[] edges = {shortEdge(Q,k1),shortEdge(Q,k2),shortEdge(Q,k3),shortEdge(Q,el),shortEdge(K,k1),shortEdge(K,k2),shortEdge(K,k3),shortEdge(K,el)};
path3 qk = Q+.15*((.3,0,1)-Q)..(.3,0,1)..K-.15*(K-(.3,0,1));

draw(qk);
for(int i = 0; i < edges.length; ++i) 
  draw(edges[i]);

for(int i = 0; i < 3; ++i )
  label("$3$",edges[i]);
label("$2$",edges[3]);
label("$6$",qk);

label("$\mathbb Q$",Q);
label("$\mathbb Q[\sqrt[3] 2]$",k1);
label("$\mathbb Q[\omega\sqrt[3] 2]$",k2);
label("$\mathbb Q[\omega^2\sqrt[3] 2]$",k3);
label("$\mathbb Q[\omega]$",el);
label("$K$",K);
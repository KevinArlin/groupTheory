import three;
size(200);
triple r = (0,0,-1);
triple b = (0,sqrt(3)/2,1/2);
triple g = rotate(120,Z)*b;
triple y = rotate(120,Z)*g;

path3 p = b..(0,sqrt(3)/2,-1/2)..r;

draw(unitsphere,purple+opacity(.5));
draw(p); draw(rotate(120,Z)*p); draw(rotate(240,Z)*p);

dot(r, red); dot(b,blue); dot(g,green); dot(y,yellow);
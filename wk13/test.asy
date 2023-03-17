size(200);
path points =(0,0)--(cos(2pi/5),0)--(cos(2pi/5),sin(2pi/5))--cycle;
dot(points); draw(points);
label("$e^{2\pi i/5}$",point(points,2));
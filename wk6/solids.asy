import three;
import animation2;
size(200);
currentprojection = orthographic((.8,1,1.2));

struct solid{

  triple[] vertices;
  path3[] faces;
  path3[] edges;
  triple[] points;
  path3[] diags;
  path3[] interFaces;
  string[] labels;

  pen[] vertexPens;
  pen[] edgePens;
  pen[] facePens;
  pen[] interFacePens;
  pen[] diagPens;
  pen[] pointPens;
  pen labelPen;
  

  void operator init(triple[] vertices, path3[] edges, path3[] faces,
                      triple[] points=new triple[],
		      path3[] diags=new path3[],
		      path3[] interFaces= new path3[],
		      string[] labels = new string[],
		      pen[] vPens = new pen[],
                      pen[] ePens = new pen[],
                      pen[] fPens = new pen[],
                      pen[] iFPens = new pen[],
                      pen[] dPens = new pen[],
                      pen[] pPens = new pen[], pen lPen = invisible) {
    this.vertices = vertices; this.faces = faces; this.edges = edges;
    this.points=points; this.diags=diags; this.interFaces= interFaces;
    if(labels.length == 0){
      for(int i = 0; i < this.vertices.length; ++i){
      this.labels.push("$"+string(i+1)+"$");
      }} else {this.labels = labels;}
    
    this.vertexPens = vPens.length == 0 ?  array(this.vertices.length,black+4bp) : vPens;
    this.edgePens = ePens.length == 0 ?  array(this.edges.length,black) : ePens;
    this.facePens = fPens.length == 0 ?  array(this.faces.length,blue+opacity(0.3)) : fPens;
    this.interFacePens = iFPens.length == 0 ?  array(this.interFaces.length,red+opacity(0.5)) : iFPens;
    this.diagPens = dPens.length == 0 ?  array(this.diags.length,white+1.5bp): dPens;
    this.pointPens = pPens.length == 0 ?  array(this.points.length,yellow+2bp) : pPens;
    this.labelPen = lPen;
  }
}


void draw(picture p = currentpicture,solid S){
   for(int i =0;i<S.faces.length;++i){
      draw(p,surface(S.faces[i]),S.facePens[i]);
    }
    for(int i = 0; i< S.edges.length;++i){
      draw(p,S.edges[i],S.edgePens[i]);
    }
    for(int i = 0; i < S.vertices.length;++i){
      triple v = S.vertices[i];
      dot(p,v,S.vertexPens[i]);
      label(p,S.labels[i],v,E,S.labelPen);      
    }
   for(int i =0;i<S.interFaces.length;++i){
      draw(p,surface(S.interFaces[i]),S.interFacePens[i]);
    }
   for(int i = 0; i < S.diags.length; ++i){
      draw(p,S.diags[i],S.diagPens[i]);
    }
   for(int i = 0; i < S.points.length; ++i){
      draw(p,S.points[i],S.pointPens[i]);
    }
}

//Allows transform3s to act as expected on solids
solid operator *(transform3 t, solid S) {
  triple doitpoint(triple v) {
        return t*v;
      }
      path3 doitpath(path3 p) {
        return t*p;
      }

  triple[] verticestemp = map(doitpoint,S.vertices);
  path3[] edgestemp = map(doitpath,S.edges);
  path3[] facestemp = map(doitpath, S.faces);
  triple[] pointstemp = map(doitpoint,S.points);
  path3[] diagstemp = map(doitpath,S.diags);
  path3[] interFacestemp = map(doitpath, S.interFaces);

  return solid(verticestemp,edgestemp,facestemp,pointstemp,diagstemp,interFacestemp, S.labels,
               S.vertexPens, S.edgePens, S.facePens, S.interFacePens, S.diagPens, S.pointPens, S.labelPen);
}

//Gives  a movie of solid S rotating slowly through angle degrees about axis axisPts[0]--axisPts[1],
//then quickly rotating back to start.

void animateRotation(solid S, real angle,triple[] axisPts,
                          int frames=20) {
  animation a;
  picture pic;
  pic.size(200);
  real step = angle/(frames-1);
  triple v = axisPts[0];
  triple w = axisPts.length > 1 ? axisPts[1] : O;
  real radius = 0;
  for(triple p : S.vertices){ radius = length(p) > radius ? length(p) : radius;}
  
  //inbound rotation
  for(int i = 0; i < frames; ++i){
    draw(pic,scale3(radius)*unitsphere,invisible);
    transform3 t = rotate(i*step,v,w);
    draw(pic,t*S);
    a.add(pic);
    pic.erase();
  }
  
  //outbound rotation
  for(int i = 0; i < frames; ++i){
    draw(pic,scale3(radius)*unitsphere,invisible);
    transform3 t = rotate((frames-i)*step,v,w);
    draw(pic,t*S);
    a.add(pic);
    pic.erase();
  }
  
  int[] delaysOutbound = array(a.pictures.length # 2,50);
  int[] delaysInbound = array(a.pictures.length # 2,20);
  int[] delays = delaysOutbound;
  delays.append(delaysInbound);
  delays[0]=450;
  delays[frames]=250;

  a.movie(delays=delays);
}

//Cube, sidelength 1, centered at origin and edges parallel to axes
struct cube {
  solid S;
  triple[] vertices;
  path3[] edges;
  path3[] faces;

  vertices.push((1,1,1));
  vertices.push((-1,1,1));
  vertices.push((-1,-1,1));
  vertices.push((1,-1,1));
  vertices.push((1,1,-1));
  vertices.push((-1,1,-1));
  vertices.push((-1,-1,-1));
  vertices.push((1,-1,-1));

  for(int i = 0; i < 2;++i){
  for(int j = 0; j < 2;++j){
    int x = (-1)^i;
    int y = (-1)^j;
    edges.push((x,y,-1)--(x,y,1));
    edges.push((x,-1,y)--(x,1,y));
    edges.push((-1,x,y)--(1,x,y));
  }}

  path3 xyFace = shift((-1,-1,-1))*(scale3(2)*unitsquare3);
  transform3 t = rotate(90,Y);
  transform3 s = rotate(90,X);

  faces.push(xyFace);
  faces.push(t*xyFace);
  faces.push(t*(t*xyFace));
  faces.push(t*(t*(t*xyFace)));
  faces.push(s*xyFace);
  faces.push(s*(s*(s*xyFace)));
  void operator init(triple[] points=new triple[],
		      path3[] diags=new path3[],
		      path3[] interFaces= new path3[],
		      string[] labels = new string[],
		      pen[] vPens = new pen[],
                      pen[] ePens = new pen[],
                      pen[] fPens = new pen[],
                      pen[] iFPens = new pen[],
                      pen[] dPens = new pen[],
                      pen[] pPens = new pen[], pen lPen = invisible) {
    S.operator init(vertices, edges,faces,points,diags, interFaces, labels,
                    vPens, ePens, fPens, iFPens, dPens, pPens, lPen); 
  }
}

//Gives a tetrahedron embedded in the cube containing (1,1,1)
struct tetrahedron {
  solid S;
   
   void operator init(triple[] vertices = new triple[],
		      triple[] points=new triple[],
		      path3[] diags=new path3[],
		      path3[] interFaces= new path3[],
		      string[] labels = new string[],
		      pen[] vPens = new pen[],
                      pen[] ePens = new pen[],
                      pen[] fPens = new pen[],
                      pen[] iFPens = new pen[],
                      pen[] dPens = new pen[],
                      pen[] pPens = new pen[], pen lPen = invisible) {
    path3[] edges; path3[] faces;      
    if (vertices.length == 0){
      vertices.push((1,-1,-1));
      vertices.push((-1,1,-1));
      vertices.push((-1,-1,1));
      vertices.push((1,1,1));
    }
    
    faces.push(vertices[0]--vertices[1]--vertices[2]--cycle);
    faces.push(vertices[0]--vertices[1]--vertices[3]--cycle);
    faces.push(vertices[0]--vertices[2]--vertices[3]--cycle);
    faces.push( vertices[1]--vertices[2]--vertices[3]--cycle);

    for(int i = 0; i<vertices.length-1; ++i){
    for(int j = i+1; j < vertices.length; ++j) {
      edges.push(vertices[i]--vertices[j]);
    }}
    S.operator init(vertices,edges,faces,points,diags, interFaces, labels,
                    vPens, ePens, fPens, iFPens, dPens, pPens, lPen); 
    }
}

struct dodecahedron {
  solid S;
  static real phi = (1+5^.5)/2;
  private triple vertices[];
  private path3 edges[];
  private path3 faces[];

  for(int i = 0; i < 8; ++i)
    vertices.push(( (-1)^( floor(i/4) ), (-1)^( ( floor(i/2) ) % 2), (-1)^(i%2) ));
  for(int i = 0; i < 4; ++i)
    vertices.push(( 0, (-1)^( floor(i/2) ) / phi, (-1)^(i%2) * phi ));
  for(int i = 0; i < 4; ++i)
    vertices.push(( (-1)^(i%2) * phi, 0, (-1)^( floor(i/2) ) / phi ));
  for(int i = 0; i < 4; ++i)
    vertices.push(( (-1)^( floor(i/2) ) / phi, (-1)^(i%2) * phi, 0 ));

  path3 makeFace(int[] x) {
	path3 p;
	for(int i = 0; i < x.length; ++i)
 	  p = p--vertices[x[i]];
	p = p--cycle;
	return p;
  }
  int faceIndices[][] = {{7,11,3,17,19},{6,10,2,17,19},{14,12,2,17,3},{8,10,2,12,0},
                   {14,12,0,16,1},{6,10,8,4,13},{4,8,0,16,18},{9,1,14,3,11},
		   {13,4,18,5,15},{18,5,9,1,16},{5,9,11,7,15}};
  for(int i = 0; i < faceIndices.length; ++i)
	faces.push(makeFace(faceIndices[i]));
	
  int edgeIndices[][] = {{0,12},{0,16},{0,8},{1,16},{1,9},{1,14},
                         {2,17},{2,10},{2,12},{3,17},{3,11},{3,14},
			 {4,13},{4,8},{4,18},{5,15},{5,18},{5,9},
			 {6,10},{6,19},{6,13},{7,11},{7,19},{7,15},
			 {8,10},{9,11},{12,14},{13,15},{16,18},{17,19}};
			 
  path3 makeEdge(int[] x){
    return vertices[x[0]]--vertices[x[1]];
  }
  for(int i = 0; i < edgeIndices.length; ++i )
    edges.push(makeEdge(edgeIndices[i]));

  void operator init(triple[] points=new triple[],
		      path3[] diags=new path3[],
		      path3[] interFaces= new path3[],
		      string[] labels = new string[],
		      pen[] vPens = new pen[],
                      pen[] ePens = new pen[],
                      pen[] fPens = new pen[],
                      pen[] iFPens = new pen[],
                      pen[] dPens = new pen[],
                      pen[] pPens = new pen[], pen lPen = invisible) {
    S.operator init(vertices, edges,faces,points,diags, interFaces, labels,
                    vPens, ePens, fPens, iFPens, dPens, pPens, lPen); 
  }
}

/*
struct icosahedron {
  solid S;
  
  static real phi = (1+5^.5)/2;
  private triple vertices[];
  private path3 edges[];
  private path3 faces[];

  for(int i = 0; i < 8; ++i)
    vertices.push(( (-1)^( floor(i/4) ), (-1)^( ( floor(i/2) ) % 2), (-1)^(i%2) ));
  for(int i = 0; i < 4; ++i)
    vertices.push(( 0, (-1)^( floor(i/2) ) / phi, (-1)^(i%2) * phi ));
  for(int i = 0; i < 4; ++i)
    vertices.push(( (-1)^(i%2) * phi, 0, (-1)^( floor(i/2) ) / phi ));
  for(int i = 0; i < 4; ++i)
    vertices.push(( (-1)^( floor(i/2) ) / phi, (-1)^(i%2) * phi, 0 ));

  path3 makeFace(int[] x) {
	path3 p;
	for(int i = 0; i < x.length; ++i)
 	  p = p--vertices[x[i]];
	p = p--cycle;
	return p;
  }
  int faceIndices[][] = {{7,11,3,17,19},{6,10,2,17,19},{14,12,2,17,3},{8,10,2,12,0},
                   {14,12,0,16,1},{6,10,8,4,13},{4,8,0,16,18},{9,1,14,3,11},
		   {13,4,18,5,15},{18,5,9,1,16},{5,9,11,7,15}};
  for(int i = 0; i < faceIndices.length; ++i)
	faces.push(makeFace(faceIndices[i]));
	
  int edgeIndices[][] = {{0,12},{0,16},{0,8},{1,16},{1,9},{1,14},
                         {2,17},{2,10},{2,12},{3,17},{3,11},{3,14},
			 {4,13},{4,8},{4,18},{5,15},{5,18},{5,9},
			 {6,10},{6,19},{6,13},{7,11},{7,19},{7,15},
			 {8,10},{9,11},{12,14},{13,15},{16,18},{17,19}};
			 
  path3 makeEdge(int[] x){
    return vertices[x[0]]--vertices[x[1]];
  }
  for(int i = 0; i < edgeIndices.length; ++i )
    edges.push(makeEdge(edgeIndices[i]));
 

  void operator init(triple[] points=new triple[],
		      path3[] diags=new path3[],
		      path3[] interFaces= new path3[],
		      string[] labels = new string[],
		      pen[] vPens = new pen[],
                      pen[] ePens = new pen[],
                      pen[] fPens = new pen[],
                      pen[] iFPens = new pen[],
                      pen[] dPens = new pen[],
                      pen[] pPens = new pen[], pen lPen = invisible) {
    S.operator init(vertices, edges,faces,points,diags, interFaces, labels,
                    vPens, ePens, fPens, iFPens, dPens, pPens, lPen); 
  }
}
*/

struct octahedron {
  solid S;
  private triple[] vertices;
  private path3 edges[];
  private path3 faces[];

  path3 makeFace(int[] x) {
	path3 p;
	for(int i = 0; i < x.length; ++i)
 	  p = p--vertices[x[i]];
	p = p--cycle;
	return p;
  }

  for (int i=-1;i<2;i = i + 2)
  {vertices.push((i,0,0));vertices.push((0,i,0));vertices.push((0,0,i));}
  
  int faceIndices[][] = {{0,1,2},{0,1,5},{0,4,2},{0,4,5},{1,2,3},{1,3,5},
                         {2,3,4},{3,4,5}};
  for(int i = 0; i < faceIndices.length; ++i)
	faces.push(makeFace(faceIndices[i]));
	
  int edgeIndices[][] = {{0,1},{0,2},{0,4},{0,5},{1,2},{1,3},{1,5},{2,3},{2,4},
                         {3,4},{3,5},{4,5}};
			 
  path3 makeEdge(int[] x){
    return vertices[x[0]]--vertices[x[1]];
  }
  for(int i = 0; i < edgeIndices.length; ++i )
    edges.push(makeEdge(edgeIndices[i]));

  void operator init(triple[] points=new triple[],
		      path3[] diags=new path3[],
		      path3[] interFaces= new path3[],
		      string[] labels = new string[],
		      pen[] vPens = new pen[],
                      pen[] ePens = new pen[],
                      pen[] fPens = new pen[],
                      pen[] iFPens = new pen[],
                      pen[] dPens = new pen[],
                      pen[] pPens = new pen[], pen lPen = invisible) {
    S.operator init(vertices, edges,faces,points,diags, interFaces, labels,
                    vPens, ePens, fPens, iFPens, dPens, pPens, lPen); 
  }
}

solid operator cast(octahedron o) {return o.S;}
solid operator cast(cube c) {return c.S;}
solid operator cast(tetrahedron t) {return t.S;}
solid operator cast(dodecahedron d) {return d.S;}


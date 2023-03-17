import solids;
size(300);
currentprojection=orthographic((1.64809472303088,2.13434311988349,2.50295210802451));
pen[] fPens={rgb("CEE7E6"),rgb("BFC0C0"),rgb("648767"),rgb("7DC95E"),rgb("30343F"),rgb("FAFAFF"),rgb("E4D9FF"),rgb("273469")};
octahedron o = octahedron(fPens=fPens);

currentlight=nolight;
animateRotation(o,120,new triple[] {(1,1,1),(0,0,0)});
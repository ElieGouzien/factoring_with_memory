use <lattice.scad>;

// Check if a vertex is adjacent to the central layer (that sets the size of processor).
// n as n_code in article (starts at 1).
function central_layer(x, y, z, n) = ((x+z == n-2) || (x+z == n-1)) ? true : false;

// Elementary tetrahedron as described in Equation (18) of arXiv:1311.0879.
// x, y, z : coordinates of vector x in arXiv:1311.0879
// s : +- 1
// permut : integer between 0 and 5 (included) that describe the permutation (a, b, c) :
//          0 : (a, b, c) = (i, j, k) ; σ=+1
//          1 : (a, b, c) = (i, k, j) ; σ=-1
//          2 : (a, b, c) = (j, i, k) ; σ=-1
//          3 : (a, b, c) = (j, k, i) ; σ=+1
//          4 : (a, b, c) = (k, i, j) ; σ=+1
//          5 : (a, b, c) = (k, j, i) ; σ=-1
// n : we keep only tetrahedron included in the code structure indexed by n.
//     n is as in Equation (19) of arXiv:1311.0879 (starts at 1).
//     use -1 for no filter
 module tetraedre (x, y, z, s, permut, n) {
     // if (permut==0) {xa=1; ya=0; za=0; xb=0; yb=1; zb=0; xc=0; yc=0; zc=1;}
     // if (permut==1) {xa=1; ya=0; za=0; xb=0; yb=0; zb=1; xc=0; yc=1; zc=0;}
     // if (permut==2) {xa=0; ya=1; za=0; xb=1; yb=0; zb=0; xc=0; yc=0; zc=1;}
     // if (permut==3) {xa=0; ya=1; za=0; xb=0; yb=0; zb=1; xc=1; yc=0; zc=0;}
     // if (permut==4) {xa=0; ya=0; za=1; xb=1; yb=0; zb=0; xc=0; yc=1; zc=0;}
     // if (permut==5) {xa=0; ya=0; za=1; xb=0; yb=1; zb=0; xc=1; yc=0; zc=0;}
     xa = permut==0 || permut==1 ? 1 : 0;
     ya = permut==2 || permut==3 ? 1 : 0;
     za = permut==4 || permut==5 ? 1 : 0;
     xb = permut==2 || permut==4 ? 1 : 0;
     yb = permut==0 || permut==5 ? 1 : 0;
     zb = permut==1 || permut==3 ? 1 : 0;
     xc = permut==3 || permut==5 ? 1 : 0;
     yc = permut==1 || permut==4 ? 1 : 0;
     zc = permut==0 || permut==2 ? 1 : 0;
     sigma = permut==0 || permut==3 || permut==4 ? +1 : -1;

     // Coordinates of vertices of the tetrahedron.
     x1=x; y1=y; z1=z;                                               // x
     x2=x+xa; y2=y+ya; z2=z+za;                                      // x + a
     x3=x+(xa+s*xb+xc)/2; y3=y+(ya+s*yb+yc)/2; z3=z+(za+s*zb+zc)/2;  // x + (a+sb+c)/2
     x4=x+(xa+s*xb-xc)/2; y4=y+(ya+s*yb-yc)/2; z4=z+(za+s*zb-zc)/2;  // x + (a+sb-c)/2

    // Faces with the right-handed orientation (as required by OpenSCAD)
    points = [[x1,y1,z1], [x2,y2,z2], [x3,y3,z3], [x4,y4,z4]];
    faces = (sigma*s) == 1 ?
        [[0,2,1], [0,1,3], [0,3,2], [1,2,3]] :
        [[0,1,2], [0,3,1], [0,2,3], [1,3,2]];

     // Check conditions and draw if needed
     if (n == -1 || (
         filtre(x1, y1, z1, n)
         && filtre(x2, y2, z2, n)
         && filtre(x3, y3, z3, n)
         && filtre(x4, y4, z4, n)
     )) {
         // echo(x, y, z, s, permut, n);
         if (central_layer(x1, y1, z1, n)
             && central_layer(x2, y2, z2, n)
             && central_layer(x3, y3, z3, n)
             && central_layer(x4, y4, z4, n))
            {
             echo("One central tetraedron");  // For counting
             color("red")
             polyhedron(points=points, faces=faces);
            }
         else {
             polyhedron(points=points, faces=faces);
            }
        }
    }


n = 3;
grille(n);

for (x = [-1:n-1]) {
        for (y = [-1:n-1]) {
            for (z = [-1:n-1]) {
                for (s=[-1:2:1]) {
                    for (permut = [0:5]) {
                        tetraedre(x, y, z, s, permut, n);
                    }
                }
            }
        }
    }

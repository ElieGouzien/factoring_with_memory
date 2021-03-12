use <lattice.scad>;
use <3d_tetrahedres.scad>;

// 1st layer : 7 qubits
color("Orange") tetraedre(0, 0, 1, -1, 0, 2);
color("Orange") tetraedre(0, 0, 1, -1, 1, 2);
color("Orange") tetraedre(0, 1, 0, -1, 0, 2);
color("Orange") tetraedre(0, 0, 1, -1, 3, 2);
color("Orange") tetraedre(0, 1, 0, -1, 5, 2);
color("Orange") tetraedre(0, 0, 1, -1, 2, 2);
color("Orange") tetraedre(-1, 1, 1, -1, 0, 2);

// 2nd layer : 4 qubits
color("Cyan") tetraedre(0, 0, 0, 1, 3, 2);
color("Cyan") tetraedre(0, 0, 0, 1, 5, 2);
color("Cyan") tetraedre(0, 0, 0, 1, 2, 2);
color("Cyan") tetraedre(0, 0, 0, 1, 4, 2);

// 3ed layer : 2 qubits
color("Magenta") tetraedre(0, 0, 0, -1, 5, 2);
color("Magenta") tetraedre(0, 0, 0, -1, 4, 2);

//4th layer : 1 qubit
color("Chartreuse") tetraedre(-1, 0, 0, 1, 1, 2);

// 5th layer : 1 qubit
color("black") tetraedre(-1, 0, 0, -1, 0, 2);

grille(2);

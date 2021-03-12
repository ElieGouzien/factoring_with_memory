use <lattice.scad>;
use <3d_tetrahedres.scad>;

// Layer 1 : 7 qubits
color("Orange") tetraedre(0, 0, 1, -1, 0, 2);
color("Orange") tetraedre(0, 0, 1, -1, 1, 2);
color("Orange") tetraedre(0, 1, 0, -1, 0, 2);
color("Orange") tetraedre(0, 0, 1, -1, 3, 2);
color("Orange") tetraedre(0, 1, 0, -1, 5, 2);
color("Orange") tetraedre(0, 0, 1, -1, 2, 2);
color("Orange") tetraedre(-1, 1, 1, -1, 0, 2);

// Layer 2 : 4 qubits
color("Cyan") tetraedre(0, 0, 0, 1, 3, 2);
color("Cyan") tetraedre(0, 0, 0, 1, 5, 2);
color("Cyan") tetraedre(0, 0, 0, 1, 2, 2);
color("Cyan") tetraedre(0, 0, 0, 1, 4, 2);

// Layer 3 : 2 qubits
color("Magenta") tetraedre(0, 0, 0, -1, 5, 2);
color("Magenta") tetraedre(0, 0, 0, -1, 4, 2);

// Layer 4 : 1 qubit
color("Chartreuse") tetraedre(-1, 0, 0, 1, 1, 2);

// Layer 5 : 1 qubit
color("black") tetraedre(-1, 0, 0, -1, 0, 2);

grille(2);

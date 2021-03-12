use <lattice.scad>;
use <3d_tetrahedres.scad>;

// Layer 1 : 1 qubit
color("black") tetraedre(-1, 0, 0, -1, 0, 3);

// Layer 2 : 10 qubit
color("Chartreuse") tetraedre(0, 0, 1, -1, 0, 3);
color("Chartreuse") tetraedre(0, 0, 1, -1, 1, 3);
color("Chartreuse") tetraedre(0, 1, 0, -1, 0, 3);
color("Chartreuse") tetraedre(0, 0, 0, 1, 2, 3);
color("Chartreuse") tetraedre(0, 0, 0, 1, 4, 3);
color("Chartreuse") tetraedre(0, 0, 0, 1, 3, 3);
color("Chartreuse") tetraedre(0, 0, 0, 1, 5, 3);
color("Chartreuse") tetraedre(0, 0, 0, -1, 5, 3);
color("Chartreuse") tetraedre(0, 0, 0, -1, 4, 3);
color("Chartreuse") tetraedre(-1, 0, 0, 1, 1, 3);

// Layer 3 : 31 qubits
color("Magenta") tetraedre(1, 0, 1, 1, 2, 3);
color("Magenta") tetraedre(1, 0, 1, 1, 4, 3);
color("Magenta") tetraedre(1, 1, 0, 1, 2, 3);
color("Magenta") tetraedre(1, 1, 0, 1, 4, 3);
color("Magenta") tetraedre(1, 0, 1, 1, 3, 3);
color("Magenta") tetraedre(1, 0, 1, 1, 5, 3);
color("Magenta") tetraedre(1, 1, 0, 1, 3, 3);
color("Magenta") tetraedre(1, 1, 0, 1, 5, 3);
color("Magenta") tetraedre(0, 1, 1, -1, 0, 3);
color("Magenta") tetraedre(0, 1, 1, -1, 1, 3);
color("Magenta") tetraedre(1, 0, 1, -1, 3, 3);
color("Magenta") tetraedre(1, 0, 1, -1, 5, 3);
color("Magenta") tetraedre(1, 1, 0, -1, 5, 3);
color("Magenta") tetraedre(1, 0, 1, -1, 2, 3);
color("Magenta") tetraedre(1, 0, 1, -1, 4, 3);
color("Magenta") tetraedre(1, 1, 0, -1, 4, 3);
color("Magenta") tetraedre(0, 0, 1, 1, 3, 3);
color("Magenta") tetraedre(0, 0, 1, 1, 0, 3);
color("Magenta") tetraedre(0, 0, 1, 1, 1, 3);
color("Magenta") tetraedre(0, 1, 0, 1, 1, 3);
color("Magenta") tetraedre(0, 0, 1, 1, 2, 3);
color("Magenta") tetraedre(0, 1, 0, 1, 4, 3);
color("Magenta") tetraedre(1, 0, 2, -1, 0, 3);
color("Magenta") tetraedre(1, 0, 2, -1, 1, 3);
color("Magenta") tetraedre(1, 1, 1, -1, 0, 3);
color("Magenta") tetraedre(1, 1, 1, -1, 1, 3);
color("Magenta") tetraedre(1, 2, 0, -1, 0, 3);
color("Magenta") tetraedre(-1, 1, 1, -1, 0, 3);
color("Magenta") tetraedre(0, 0, 1, -1, 3, 3);
color("Magenta") tetraedre(0, 1, 0, -1, 5, 3);
color("Magenta") tetraedre(0, 0, 1, -1, 2, 3);

// Layer 4 : 19 qubits
color("Cyan") tetraedre(0, 1, 1, 1, 0, 3);
color("Cyan") tetraedre(0, 1, 1, 1, 1, 3);
color("Cyan") tetraedre(0, 1, 1, 1, 2, 3);
color("Cyan") tetraedre(0, 1, 1, 1, 4, 3);
color("Cyan") tetraedre(0, 1, 1, 1, 3, 3);
color("Cyan") tetraedre(0, 1, 1, 1, 5, 3);
color("Cyan") tetraedre(1, 0, 2, -1, 3, 3);
color("Cyan") tetraedre(1, 1, 1, -1, 3, 3);
color("Cyan") tetraedre(1, 1, 1, -1, 5, 3);
color("Cyan") tetraedre(1, 2, 0, -1, 5, 3);
color("Cyan") tetraedre(1, 0, 2, -1, 2, 3);
color("Cyan") tetraedre(1, 1, 1, -1, 2, 3);
color("Cyan") tetraedre(1, 1, 1, -1, 4, 3);
color("Cyan") tetraedre(0, 1, 2, -1, 0, 3);
color("Cyan") tetraedre(0, 1, 2, -1, 1, 3);
color("Cyan") tetraedre(0, 2, 1, -1, 0, 3);
color("Cyan") tetraedre(0, 1, 1, -1, 5, 3);
color("Cyan") tetraedre(0, 1, 1, -1, 4, 3);
color("Cyan") tetraedre(-1, 1, 1, 1, 1, 3);

// Layer 5 : 4 qubits
color("Orange") tetraedre(-1, 2, 2, -1, 0, 3);
color("Orange") tetraedre(0, 1, 2, -1, 3, 3);
color("Orange") tetraedre(0, 2, 1, -1, 5, 3);
color("Orange") tetraedre(0, 1, 2, -1, 2, 3);

grille(3);

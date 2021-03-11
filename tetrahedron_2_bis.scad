use <lattice.scad>;
use <3d_tetrahedres.scad>;

// 1st layer : 2 qubit
color("black") tetraedre(-1, 0, 0, -1, 0, 2);
color("black") tetraedre(-1, 0, 0, 1, 1, 2);

// 2nd layer : 11 qubit
color("Chartreuse") tetraedre(0, 0, 0, -1, 5, 2);
color("Chartreuse") tetraedre(0, 0, 0, -1, 4, 2);
color("Chartreuse") tetraedre(0, 0, 0, 1, 5, 2);
color("Chartreuse") tetraedre(0, 0, 0, 1, 4, 2);
color("Chartreuse") tetraedre(0, 0, 0, 1, 3, 2);
color("Chartreuse") tetraedre(0, 0, 0, 1, 2, 2);
color("Chartreuse") tetraedre(0, 1, 0, -1, 0, 2);
color("Chartreuse") tetraedre(0, 0, 1, -1, 3, 2);
color("Chartreuse") tetraedre(0, 1, 0, -1, 5, 2);
color("Chartreuse") tetraedre(0, 0, 1, -1, 2, 2);
color("Chartreuse") tetraedre(-1, 1, 1, -1, 0, 2);

// 3rd layer : 2 qubits
color("Magenta") tetraedre(0, 0, 1, -1, 0, 2);
color("Magenta") tetraedre(0, 0, 1, -1, 1, 2);


grille(2);

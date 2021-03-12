use <lattice.scad>;
use <3d_tetrahedres.scad>;

// layer 1 : 2 qubit
color("black") tetraedre(-1, 0, 0, -1, 0, 3);
color("black") tetraedre(-1, 0, 0, 1, 1, 3);

// layer 2 : 14 qubit
color("Chartreuse") tetraedre(0, 1, 0, -1, 0, 3);
color("Chartreuse") tetraedre(0, 0, 0, 1, 2, 3);
color("Chartreuse") tetraedre(0, 0, 0, 1, 4, 3);
color("Chartreuse") tetraedre(0, 0, 0, 1, 3, 3);
color("Chartreuse") tetraedre(0, 0, 0, 1, 5, 3);
color("Chartreuse") tetraedre(0, 0, 0, -1, 5, 3);
color("Chartreuse") tetraedre(0, 0, 0, -1, 4, 3);
color("Chartreuse") tetraedre(-1, 1, 1, -1, 0, 3);
color("Chartreuse") tetraedre(0, 0, 1, -1, 3, 3);
color("Chartreuse") tetraedre(0, 1, 0, -1, 5, 3);
color("Chartreuse") tetraedre(0, 0, 1, -1, 2, 3);
color("Chartreuse") tetraedre(0, 1, 0, 1, 1, 3);
color("Chartreuse") tetraedre(0, 1, 0, 1, 4, 3);
color("Chartreuse") tetraedre(-1, 1, 1, 1, 1, 3);

// layer 3 : 33 qubits
    // first set : 10 qubits
    color("Magenta") tetraedre(0, 0, 1, -1, 1, 3);
    color("Magenta") tetraedre(1, 1, 0, 1, 2, 3);
    color("Magenta") tetraedre(1, 1, 0, 1, 3, 3);
    color("Magenta") tetraedre(0, 1, 1, -1, 1, 3);
    color("Magenta") tetraedre(1, 1, 0, -1, 4, 3);
    color("Magenta") tetraedre(0, 0, 1, 1, 3, 3);
    color("Magenta") tetraedre(0, 0, 1, 1, 2, 3);
    color("Magenta") tetraedre(0, 1, 1, 1, 2, 3);
    color("Magenta") tetraedre(0, 1, 1, 1, 3, 3);
    color("Magenta") tetraedre(0, 1, 1, -1, 4, 3);

    // second set : 10 qubits
    color("Magenta") tetraedre(1, 1, 0, 1, 4, 3);
    color("Magenta") tetraedre(1, 0, 1, -1, 3, 3);
    color("Magenta") tetraedre(1, 0, 1, -1, 2, 3);
    color("Magenta") tetraedre(0, 0, 1, 1, 1, 3);
    color("Magenta") tetraedre(0, 1, 1, 1, 1, 3);
    color("Magenta") tetraedre(0, 1, 1, 1, 4, 3);
    color("Magenta") tetraedre(1, 1, 1, -1, 3, 3);
    color("Magenta") tetraedre(1, 1, 1, -1, 2, 3);
    color("Magenta") tetraedre(0, 1, 2, -1, 3, 3);
    color("Magenta") tetraedre(0, 1, 2, -1, 2, 3);

    // third set : 13 qubits
    color("Magenta") tetraedre(0, 0, 1, -1, 0, 3);
    color("Magenta") tetraedre(1, 1, 0, 1, 5, 3);
    color("Magenta") tetraedre(0, 1, 1, -1, 0, 3);
    color("Magenta") tetraedre(1, 1, 0, -1, 5, 3);
    color("Magenta") tetraedre(0, 0, 1, 1, 0, 3);
    color("Magenta") tetraedre(1, 2, 0, -1, 0, 3);
    color("Magenta") tetraedre(0, 1, 1, 1, 0, 3);
    color("Magenta") tetraedre(0, 1, 1, 1, 5, 3);
    color("Magenta") tetraedre(1, 2, 0, -1, 5, 3);
    color("Magenta") tetraedre(0, 2, 1, -1, 0, 3);
    color("Magenta") tetraedre(0, 1, 1, -1, 5, 3);
    color("Magenta") tetraedre(-1, 2, 2, -1, 0, 3);
    color("Magenta") tetraedre(0, 2, 1, -1, 5, 3);


// layer 4 : 14 qubits
color("Cyan") tetraedre(1, 0, 1, 1, 2, 3);
color("Cyan") tetraedre(1, 0, 1, 1, 4, 3);
color("Cyan") tetraedre(1, 0, 1, 1, 3, 3);
color("Cyan") tetraedre(1, 0, 1, 1, 5, 3);
color("Cyan") tetraedre(1, 0, 1, -1, 5, 3);
color("Cyan") tetraedre(1, 0, 1, -1, 4, 3);
color("Cyan") tetraedre(1, 1, 1, -1, 0, 3);
color("Cyan") tetraedre(1, 1, 1, -1, 1, 3);
color("Cyan") tetraedre(1, 0, 2, -1, 3, 3);
color("Cyan") tetraedre(1, 1, 1, -1, 5, 3);
color("Cyan") tetraedre(1, 0, 2, -1, 2, 3);
color("Cyan") tetraedre(1, 1, 1, -1, 4, 3);
color("Cyan") tetraedre(0, 1, 2, -1, 0, 3);
color("Cyan") tetraedre(0, 1, 2, -1, 1, 3);

//// layer 5 : 2 qubits
color("Orange") tetraedre(1, 0, 2, -1, 0, 3);
color("Orange") tetraedre(1, 0, 2, -1, 1, 3);

grille(3);

use <lattice.scad>;
use <3d_tetrahedres.scad>;

// Layer 1 : 19 qubits
color("Chocolate") tetraedre(1, 0, 2, -1, 0, 3);
color("Chocolate") tetraedre(1, 0, 2, -1, 1, 3);
color("Chocolate") tetraedre(1, 1, 1, -1, 0, 3);
color("Chocolate") tetraedre(1, 1, 1, -1, 1, 3);
color("Chocolate") tetraedre(1, 2, 0, -1, 0, 3);
color("Chocolate") tetraedre(-1, 2, 2, -1, 0, 3);
color("Chocolate") tetraedre(1, 0, 2, -1, 3, 3);
color("Chocolate") tetraedre(1, 1, 1, -1, 3, 3);
color("Chocolate") tetraedre(1, 1, 1, -1, 5, 3);
color("Chocolate") tetraedre(1, 2, 0, -1, 5, 3);
color("Chocolate") tetraedre(1, 0, 2, -1, 2, 3);
color("Chocolate") tetraedre(1, 1, 1, -1, 2, 3);
color("Chocolate") tetraedre(1, 1, 1, -1, 4, 3);
color("Chocolate") tetraedre(0, 1, 2, -1, 0, 3);
color("Chocolate") tetraedre(0, 1, 2, -1, 1, 3);
color("Chocolate") tetraedre(0, 2, 1, -1, 0, 3);
color("Chocolate") tetraedre(0, 1, 2, -1, 3, 3);
color("Chocolate") tetraedre(0, 2, 1, -1, 5, 3);
color("Chocolate") tetraedre(0, 1, 2, -1, 2, 3);

// Layer 2 : 14 qubits
color("SpringGreen") tetraedre(1, 0, 1, 1, 3, 3);
color("SpringGreen") tetraedre(1, 0, 1, 1, 5, 3);
color("SpringGreen") tetraedre(1, 1, 0, 1, 3, 3);
color("SpringGreen") tetraedre(1, 1, 0, 1, 5, 3);
color("SpringGreen") tetraedre(0, 1, 1, 1, 0, 3);
color("SpringGreen") tetraedre(0, 1, 1, 1, 1, 3);
color("SpringGreen") tetraedre(0, 1, 1, 1, 2, 3);
color("SpringGreen") tetraedre(0, 1, 1, 1, 4, 3);
color("SpringGreen") tetraedre(0, 1, 1, 1, 3, 3);
color("SpringGreen") tetraedre(0, 1, 1, 1, 5, 3);
color("SpringGreen") tetraedre(1, 0, 1, 1, 2, 3);
color("SpringGreen") tetraedre(1, 0, 1, 1, 4, 3);
color("SpringGreen") tetraedre(1, 1, 0, 1, 2, 3);
color("SpringGreen") tetraedre(1, 1, 0, 1, 4, 3);

// Layer 3 : 10 qubits
color("HotPink") tetraedre(0, 1, 1, -1, 5, 3);
color("HotPink") tetraedre(0, 1, 1, -1, 0, 3);
color("HotPink") tetraedre(0, 1, 1, -1, 1, 3);
color("HotPink") tetraedre(1, 0, 1, -1, 3, 3);
color("HotPink") tetraedre(1, 0, 1, -1, 5, 3);
color("HotPink") tetraedre(1, 1, 0, -1, 5, 3);
color("HotPink") tetraedre(1, 0, 1, -1, 2, 3);
color("HotPink") tetraedre(1, 0, 1, -1, 4, 3);
color("HotPink") tetraedre(1, 1, 0, -1, 4, 3);
color("HotPink") tetraedre(0, 1, 1, -1, 4, 3);

// Layer 4 : 7 qubits
color("Navy") tetraedre(0, 0, 1, 1, 3, 3);
color("Navy") tetraedre(-1, 1, 1, 1, 1, 3);
color("Navy") tetraedre(0, 0, 1, 1, 0, 3);
color("Navy") tetraedre(0, 0, 1, 1, 1, 3);
color("Navy") tetraedre(0, 1, 0, 1, 1, 3);
color("Navy") tetraedre(0, 0, 1, 1, 2, 3);
color("Navy") tetraedre(0, 1, 0, 1, 4, 3);


// ------------------------------------------------------
// From here we can see the n-1 structure

// Layer 5 : 7 qubits
color("Orange") tetraedre(-1, 1, 1, -1, 0, 3);
color("Orange") tetraedre(0, 0, 1, -1, 0, 3);
color("Orange") tetraedre(0, 0, 1, -1, 1, 3);
color("Orange") tetraedre(0, 1, 0, -1, 0, 3);
// To see and edge neighboring 3 layers,
// remove the two following tetrahedrons
color("Orange") tetraedre(0, 0, 1, -1, 3, 3);
color("Orange") tetraedre(0, 1, 0, -1, 5, 3);
color("Orange") tetraedre(0, 0, 1, -1, 2, 3);

// Layer 6 : 4 qubits
color("cyan") tetraedre(0, 0, 0, 1, 2, 3);
color("cyan") tetraedre(0, 0, 0, 1, 4, 3);
color("cyan") tetraedre(0, 0, 0, 1, 3, 3);
color("cyan") tetraedre(0, 0, 0, 1, 5, 3);

// Layer 7 : 2 qubits
color("magenta") tetraedre(0, 0, 0, -1, 5, 3);
color("magenta") tetraedre(0, 0, 0, -1, 4, 3);

// Layer 8 : 1 qubit
color("Chartreuse") tetraedre(-1, 0, 0, 1, 1, 3);

// Layer 9 : 1 qubit
color("black") tetraedre(-1, 0, 0, -1, 0, 3);


grille(3);

// Centered cubic grid, as presented in Equation (18) from arXiv:1311.0879


//  Uncut centered cubic grid.
module maille(nb) {
    // Diameter of small balls
    rad = 0.1;
    for (x = [0:nb]) {
        for (y = [0:nb]) {
            for (z = [0:nb]) {
                type = abs((x + y + z) % 2);  // Correspond to color
                x2 = x+0.5; y2 = y+0.5; z2 = z+0.5;
                if (type == 0) {
                        color("red") translate([x, y, z]) sphere(rad);
                        color("blue") translate([x2, y2, z2]) sphere(rad);
                        }
                if (type == 1) {
                    color("green") translate([x, y, z]) sphere(rad);
                    color("yellow") translate([x2, y2, z2]) sphere(rad);
                    }
                }
            }
        }
    }



// Check Equation (19) of arXiv:1311.0879 (n stars at 1).
function filtre(x, y, z, n) = ((x+y+z <= 0 + 2*(n-1))
                               && (x-y-z <= 1/2)
                               && (-x+y-z <= 1)
                               && (-x-y+z <= 3/2)) ? true : false;


// Grid as presented in Equations (18) and (19) of arXiv:1311.0879.
// n : number n in Equation (19): index in the code family, starts at 1.
module grille(n) {
    // Diameter of small balls
    rad = 0.1;
    for (x = [-1:n-1]) {
        for (y = [-1:n-1]) {
            for (z = [-1:n-1]) {
                type = abs((x + y + z) % 2);  // Correspond to color
                if (filtre(x, y, z, n)) {
                    if (type == 0) {
                        color("red") translate([x, y, z]) sphere(rad);
                        }
                    if (type == 1) {
                        color("green") translate([x, y, z]) sphere(rad);
                        }
                    }
                x2 = x+0.5; y2 = y+0.5; z2 = z+0.5;
                if (filtre(x2, y2, z2, n)) {
                    if (type == 0) {
                        color("blue") translate([x2, y2, z2]) sphere(rad);
                        }
                    if (type == 1) {
                        color("yellow") translate([x2, y2, z2]) sphere(rad);
                        }
                    }
                }
            }
        }
    }

//maille(2);
grille(2);

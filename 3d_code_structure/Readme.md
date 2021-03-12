Code for computations in [arXiv:2103.06159](https://arxiv.org/abs/2103.06159)
=============================================================================


Visualization of the structure used by 3D gauge color codes
-----------------------------------------------------------

The file should help to visualize the tetrahedron on which the simplicial 3D gauge color codes are built.
They show how the tetrahedron is sliced in order to process it with a 2D processor.

All the `*.scad` files are opened and compiled with [OpenSCAD](https://www.openscad.org/).

Manifest:
  * `lattice.scad` : define the colored lattice
  * `3d_tetrahedres.scad` : define elementary tetrahedron and the structure for arbitrary size.
    The central slice, as presented in the article, is colored in red.
  * `tetrahedron_2.scad` : n=2 tetrahedron is sliced in parallel to one large face.
    This is not the slicing presented in the article.
    It corresponds to `debitage=1` in the resource evaluation code.
  * `tetrahedron_2_bis.scad` : n=2 tetrahedron is sliced orthogonally to two large faces, as presented in the article (each slice is between two consecutive plans with $x+z$ constant integer).
    It corresponds to `debitage=2` in the resource evaluation code.
  * `tetrahedron_2_ter.scad` : n=2 tetrahedron is sliced orthogonally to two large faces, in another way than in the article (each slice is between two consecutive plans with $y+z$ constant integer).
  * `tetrahedron_3.scad` : n=3 tetrahedron is sliced in parallel to one large face.
    This is not the slicing presented in the article.
    It corresponds to `debitage=1` in the resource evaluation code.
  * `tetrahedron_3_bis.scad` : n=3 tetrahedron is sliced orthogonally to two large faces, as presented in the article (each slice is between two consecutive plans with $x+z$ constant integer).
    It corresponds to `debitage=2` in the resource evaluation code.
  * `tetrahedron_3_ter.scad` : n=3 tetrahedron is sliced orthogonally to two large faces, in another way than in the article (each slice is between two consecutive plans with $y+z$ constant integer).

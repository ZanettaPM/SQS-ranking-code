
This code has been created by Zanetta Pierre-Marie, Abhishek Khumar Thakur and  Manga Venkateswara Rao

pierre.marie.zanetta@gmail.com
abhishekkt@email.arizona.edu
Manga, Venkateswara Rao - (manga) <manga@arizona.edu>

#####
This code combine functions from the atat software and the supercell software using a small python script to change the structure from cartesian to fractionnal coordinates specific to sqs.out files (see atat manual). 
The objective is to calculate the sqs ranking (using atat corrdump function) of SQS structures generated with Supercell software

https://www.brown.edu/Departments/Engineering/Labs/avdw/atat/

https://orex.github.io/supercell/

The structure of the code is based on :https://github.com/orex/supercell/tree/master/data/examples/PbSnTe-SQS 
#####

Requirement: 

- atat code, add this code to your path : export PATH=$PATH:/home/yourdirectory/atat/src
- The supercell software. The easiest way is to extract the linux tar.gz file in the current directory (with the other files)
- In your python env. please install pymatgen and glob using pip. i.e., pip install pymatgen

https://pymatgen.org/usage.html
https://docs.python.org/3/library/glob.html

######

Four files should be in the folder:

- zanetta.bash ### no edits needed

- X.cif  ## unit cell with partial occupancies on specific sites. Just use Vesta to create it. See supercell software requirements 

- lat.in ## Please, do not paste another file, modify only the text inside to keep the encoding system intact. I advise to write all the atomic positions. Do not rely on the wickoff symmetry.

- convert.py ### no edits needed

- this Readme file

The lat.in file structure should be the same as in the atat corrdump code i.e., :

First, the coordinate system a,b,c is specified, either as
[a] [b] [c] [alpha] [beta] [gamma]
or as:
[ax] [ay] [az]
[bx] [by] [bz]
[cx] [cy] [cz]
Then the lattice vectors u,v,w are listed, expressed in the coordinate system just defined:
[ua] [ub] [uc]
[va] [vb] [vc]
[wa] [wb] [wc]
Finally, atom positions and types are given, expressed in the same coordinate system
as the lattice vectors:
[atom1a] [atom1b] [atom1c] [atomtype11],[atomtype12] ### please do not add the occupancies here. It is not necessary
[atom2a] [atom2b] [atom2c] [atomtype21],[atomtype22]
etc.

##### 

Running the code:

1) Run the zanetta.bash file (linux env.):
bash zanetta.bash ### please take care, if your directory contain space it can cause bugs
2) enter the name of your cif file 
3) give the size of the supercell you want. You can give several of them (ex: 2x2x1 1x1x2 3x2x1)

4) give the cutoff distance that you want to use for the correlation function
Tip* a correlation function will be calculated for each nearest neighbor (availble in the cluster.out file). The number of output will depend of the cutoff distance and in other words of the 1,2,3,4,...nth nearest neighbors. 
You don't need to put several cutoff distances, just give the largest that you want. 

Enjoy ! 
If you find any bugs please report it to Pierre-marie Zanetta

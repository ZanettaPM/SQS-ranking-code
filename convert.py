import numpy as np
from pymatgen.core import Lattice, Structure, Molecule
import glob
import sys


targetPattern = r"*.cif"
cell=Structure.from_file(glob.glob(targetPattern)[0])

indexx=float(sys.argv[1]) # read the supercell size
indexy=float(sys.argv[2])
indexz=float(sys.argv[3])

u=np.shape(cell.cart_coords)
positions=np.empty((u[0],u[1]))

positions[:,0]=cell.frac_coords[:,0]*cell.lattice.abc[0]/(cell.lattice.abc[0]/indexx)
positions[:,1]=cell.frac_coords[:,1]*cell.lattice.abc[1]/(cell.lattice.abc[1]/indexy)
positions[:,2]=cell.frac_coords[:,2]*cell.lattice.abc[2]/(cell.lattice.abc[2]/indexz)

#positions=np.around(positions,3)

matrix=np.zeros((3,3))
matrix[0,0]=cell.lattice.abc[0]/indexx
matrix[1,1]=cell.lattice.abc[1]/indexy
matrix[2,2]=cell.lattice.abc[2]/indexz

matrix2=np.zeros((3,3))
matrix2[0,0]=indexx
matrix2[1,1]=indexy
matrix2[2,2]=indexz

atoms=np.array(cell.species)

u=np.shape(positions)
new=np.empty((u[0]+6,u[1]+1),dtype=object)

new[0:3][:,:3]=matrix# construct the sqs.our file
new[3:6][:,:3]=matrix2
new[6:,0]=positions[:,0]
new[6:,1]=positions[:,1]
new[6:,2]=positions[:,2]
new[6:,3]=atoms[:]


np.savetxt('sqs.out',new,'%1.5f %f %f %s')



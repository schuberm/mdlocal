using PyPlot
require("bin2tex.jl")

velfile="vel_1_1.bin"
posfile="pos_1_1.bin"
numTstep=8192
#numTstep=1000
numAtoms=4096

streampos=0
#reference positions and velocities
(vel0,streampos)=readLammps(velfile,numAtoms,streampos)
streampos=0
(pos0,streampos)=readLammps(posfile,numAtoms,streampos)
x=linspace(0,1,numTstep-1)
lexp=Array(Float64,numTstep-1,3)

for i=1:numTstep-1
	temppos=streampos
	(velt,streampos)=readLammps(velfile,numAtoms,temppos)
	(post,streampos)=readLammps(posfile,numAtoms,temppos)
	#show(size(sqrt(sum((vel0-velt).^2+(pos0-post).^2,1))))
	lexp[i,:]=sqrt(sum((vel0-velt).^2+(pos0-post).^2,1))

end

p=plot(lexp[:,1])
writedlm("lexp1.txt",lexp[:,1])
show(p)

pause
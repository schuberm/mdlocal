#corr stuff

#using PyPlot
require("bin2tex.jl")
require("velij.jl")

velfile="vel_1_1.bin"
numTstep=8192
#numTstep=1000
numAtoms=4096
(vel,streampos)=readLammps(filename,numAtoms,0)
#show(vel[1,:]*vel[2,:]')
#corr=Array(Float64,numTstep,1)
veli=Array(Float64,numTstep,3)
velj=Array(Float64,numTstep,3)
#veli=Float64[]
#velj=Float64[]
init=vel[1,:]
x=linspace(0,1,numTstep)

for na=1:10
streampos=0
for i=1:numTstep
	(vel,streampos)=readLammps(velfile,numAtoms,streampos)
	#tmp=init*vel[2,:]'
	# push!(veli,vel[1,1])
	# push!(velj,vel[2,1])
	veli[i,:]=vel[1,:]
	velj[i,:]=vel[na,:]
	#push!(corr,tmp[1])
end

tmp=veli[:,1].*velj[:,1]+veli[:,2].*velj[:,2]+veli[:,3].*velj[:,3]
#corr=corr+xcorr(tmp,tmp)
if na==1
	corr=xcorr(veli[:,1],velj[:,1])
else
	corr=xcorr(corr[numTstep:2*numTstep-1],velj[:,1])
end
end
#corr=xcorr(reshape(veli,numTstep*3),reshape(velj,numTstep*3))
#corr=xcorr(veli[:,1],velj[:,1])
#show(size(corr))
#p=semilogx(x,corr[numTstep:2*numTstep-1])
#xscale('log')
#show(p)

#p=semilogy(real(fft(veli[:,1])).^2+imag(fft(veli[:,1])).^2)
p=semilogy(real(fft(corr)).^2+imag(fft(corr)).^2)
show(p)

pause


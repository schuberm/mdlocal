
function readLammps(filename,numAtoms,streampos)
	fid = open(filename,"r")
	vel=Array(Float64,numAtoms,3)
	seek(fid,streampos)
		#Skip this many bytes in the header portion of each timestep
		readbytes(fid,8)
		readbytes(fid,8)
		readbytes(fid,4)
		readbytes(fid,4)
		readbytes(fid,4)
		readbytes(fid,4)
		readbytes(fid,4)
		readbytes(fid,4)
		readbytes(fid,4)
		readbytes(fid,8)
		readbytes(fid,8)
		readbytes(fid,8)
		readbytes(fid,8)
		readbytes(fid,8)
		readbytes(fid,8)
		#Care about these numbers
		size_one=read(fid,Int32)
		nchunk=read(fid,Int32)
		atomindex=convert(Int32,0)
		for i=1:nchunk
				n=read(fid,Int32)
				for j=1:convert(Int32,n/size_one)
					for k=1:size_one
						vel[atomindex+j,k]=read(fid,Float64)
					end
				end
				atomindex=atomindex+convert(Int32,n/size_one)
		end
	streampos=position(fid)
	close(fid)

	return vel,streampos

end
help([[
HDF5 1.14.6
Built with Intel oneAPI 2023.2.4
MPI disabled.
]])

whatis("Name: HDF5")
whatis("Version: 1.14.6")
whatis("Compiler: Intel oneAPI 2023.2.4")
whatis("MPI support: disabled")

local root="/opt/local/apps/hdf5/1.14.6-ifort/no-mpi"

depends_on("compiler/oneapi/2023.2.4")

prepend_path("PATH", pathJoin(root,"bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("CPATH", pathJoin(root, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))
prepend_path("CMAKE_PREFIX_PATH", root)

setenv("HDF5_ROOT", root)
setenv("HDF5PATH", root)

family("hdf5")
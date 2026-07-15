help([[
NetCDF4 Fortran 4.6.3
Built with Intel oneAPI 2023.2.4
]])

whatis("Name: NetCDF4 Fortran")
whatis("Version: 4.6.3")
whatis("Compiler: Intel oneAPI 2023.2.4")

local root="/opt/local/apps/netcdf4-fortran/4.6.3-ifort"

depends_on("compiler/oneapi/2023.2.4")
depends_on("netcdf4-c/4.10.1-ifort-hdf5")

prepend_path("PATH", pathJoin(root,"bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("CPATH", pathJoin(root, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))
prepend_path("CMAKE_PREFIX_PATH", root)

setenv("NETCDFF4PATH", root)
setenv("NETCDFFPATH", root)
setenv("NETCDFF4", root)
setenv("NETCDFF", root)

family("netcdf4_fortran")
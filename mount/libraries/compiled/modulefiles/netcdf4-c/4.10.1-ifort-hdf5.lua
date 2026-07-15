help([[
NetCDF4 4.10.1
Built with Intel oneAPI 2023.2.4
with HDF5 support.
]])

whatis("Name: NetCDF4")
whatis("Version: 4.10.1")
whatis("Compiler: Intel oneAPI 2023.2.4")
whatis("HDF support: HDF5")

local root="/opt/local/apps/netcdf4-c/4.10.1-ifort/with-hdf5"

depends_on("compiler/oneapi/2023.2.4")
depends_on("hdf5/1.14.6-ifort-no-mpi")

prepend_path("PATH", pathJoin(root,"bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("CPATH", pathJoin(root, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))
prepend_path("CMAKE_PREFIX_PATH", root)

setenv("NETCDF4_ROOT", root)
setenv("NETCDF4PATH", root)
setenv("NETCDFPATH", root)
setenv("NETCDF4", root)
setenv("NETCDF", root)
setenv("HDF5_PLUGIN_PATH", "/opt/local/apps/netcdf4-c/4.10.1-ifort/with-hdf5/hdf5/lib/plugin")

family("netcdf4_c")
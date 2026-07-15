help([[
HDF4 4.3.1
Built with Intel oneAPI 2023.2.4
NetCDF support disabled.
]])

whatis("Name: HDF4")
whatis("Version: 4.3.1")
whatis("Compiler: Intel oneAPI 2023.2.4")
whatis("NetCDF support: disabled")

local root="/opt/local/apps/hdf4/4.3.1-ifort/no-netcdf"

depends_on("compiler/oneapi/2023.2.4")

prepend_path("PATH", pathJoin(root,"bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("CPATH", pathJoin(root, "include"))

setenv("HDF4_ROOT", root)
setenv("HDF4PATH", root)
setenv("HDFPATH", root)

family("hdf4")
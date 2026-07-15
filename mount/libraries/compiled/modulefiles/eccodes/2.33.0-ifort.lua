help([[
ecCodes 2.33.0
Built with Intel oneAPI 2023.2.4
]])

whatis("Name: ecCodes")
whatis("Version: 2.33.0")
whatis("Compiler: Intel oneAPI 2023.2.4")

local root="/opt/local/apps/eccodes/2.33.0-ifort"

depends_on("compiler/oneapi/2023.2.4")
depends_on("netcdf4-c/4.10.1-ifort-hdf5")
depends_on("netcdf4-fortran/4.6.3-ifort")

prepend_path("PATH", pathJoin(root,"bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("CPATH", pathJoin(root, "include"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "lib/pkgconfig"))
prepend_path("CMAKE_PREFIX_PATH", root)

setenv("ECCODES_PATH", root)
setenv("ECCODES_ROOT", root)

family("eccodes")
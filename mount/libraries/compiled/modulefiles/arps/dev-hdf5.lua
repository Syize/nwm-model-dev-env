help([[
ARPS model Dev version
Built with Intel oneAPI 2023.2.4
With HDF4
]])

whatis("Name: ARPS model")
whatis("Version: Dev")
whatis("Compiler: Intel oneAPI 2023.2.4")
whatis("HDF Version: HDF5")

local root="/opt/local/apps/arps/dev-hdf5"

depends_on("compiler/oneapi/2023.2.4")
depends_on("mpi/oneapi/2021.18")
depends_on("netcdf4-fortran/4.6.3-ifort")

prepend_path("PATH", root)

family("arps")
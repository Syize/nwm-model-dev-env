help([[
ARPS model Dev version
Built with Intel oneAPI 2023.2.4
With HDF4
]])

whatis("Name: ARPS model")
whatis("Version: Dev")
whatis("Compiler: Intel oneAPI 2023.2.4")
whatis("HDF Version: HDF4 without NetCDF support")

local root="/opt/local/apps/arps/dev-hdf4"

depends_on("compiler/oneapi/2023.2.4")
depends_on("mpi/oneapi/2021.18")
depends_on("hdf4/4.3.1-ifort-no-netcdf")
depends_on("netcdf4-fortran/4.6.3-ifort")
depends_on("jasper/1.900.1-gnu")
depends_on("eccodes/2.33.0-ifort")

prepend_path("PATH", root)

family("arps")
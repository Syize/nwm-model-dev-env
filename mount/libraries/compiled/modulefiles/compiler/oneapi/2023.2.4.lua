help([[
Intel oneAPI Compiler 2023.2.4
]])

whatis("Intel oneAPI Compiler 2023.2.4")

local root="/opt/intel/oneapi"

prepend_path("PKG_CONFIG_PATH",
    pathJoin(root, "compiler/2023.2.4/lib/pkgconfig"))

prepend_path("MANPATH",
    pathJoin(root, "compiler/2023.2.4/documentation/en/man/common"))

prepend_path("CMAKE_PREFIX_PATH",
    pathJoin(root, "compiler/2023.2.4/linux/IntelDPCPP"))

prepend_path("PATH",
    pathJoin(root,"compiler/2023.2.4/linux/bin"))

prepend_path("PATH",
    pathJoin(root,"compiler/2023.2.4/linux/bin/intel64"))

prepend_path("LD_LIBRARY_PATH",
    pathJoin(root,"compiler/2023.2.4/linux/compiler/lib/intel64_lin"))

prepend_path("LD_LIBRARY_PATH",
    pathJoin(root,"compiler/2023.2.4/linux/lib/oclfpga/host/linux64/lib"))

prepend_path("LD_LIBRARY_PATH",
    pathJoin(root,"compiler/2023.2.4/linux/lib/x64"))

prepend_path("LD_LIBRARY_PATH",
    pathJoin(root,"compiler/2023.2.4/linux/lib"))

prepend_path("LIBRARY_PATH",
    pathJoin(root,"compiler/2023.2.4/linux/lib"))

prepend_path("LIBRARY_PATH",
    pathJoin(root,"compiler/2023.2.4/linux/compiler/lib/intel64_lin"))

setenv("I_MPI_F90", "ifort")

setenv("I_MPI_F77", "ifort")

setenv("FC", "ifort")

setenv("CC", "icx")

setenv("CXX", "icpx")

setenv("CPP", "icx -E")

setenv("CXXCPP", "icpx -E")

family("compiler")

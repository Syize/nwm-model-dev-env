help([[
Intel oneAPI MPI 2021.18
]])

whatis("Intel oneAPI MPI 2021.18")

local root="/opt/intel/oneapi/mpi"

depends_on("compiler/oneapi/2023.2.4")

prepend_path("PKG_CONFIG_PATH",
    pathJoin(root, "2021.18/lib/pkgconfig"))

prepend_path("I_MPI_ROOT",
    pathJoin(root, "2021.18"))

prepend_path("MANPATH",
    pathJoin(root, "2021.18/man"))

prepend_path("CPLUS_INCLUDE",
    pathJoin(root, "2021.18/include"))

prepend_path("CLASSPATH",
    pathJoin(root,"2021.18/share/java/mpi.jar"))

prepend_path("PATH",
    pathJoin(root,"2021.18/bin"))

prepend_path("FI_PROVIDER_PATH",
    pathJoin(root,"2021.18/opt/mpi/libfabric/lib/prov"))

prepend_path("FI_PROVIDER_PATH", "/usr/lib/x86_64-linux-gnu/libfabric")

prepend_path("LD_LIBRARY_PATH",
    pathJoin(root,"2021.18/lib"))

prepend_path("LD_LIBRARY_PATH",
    pathJoin(root,"2021.18/opt/mpi/libfabric/lib"))

prepend_path("LIBRARY_PATH",
    pathJoin(root,"2021.18/lib"))

family("mpi")

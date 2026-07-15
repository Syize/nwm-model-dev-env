help([[
Jasper 1.900.1
]])

whatis("Name: Jasper")
whatis("Version: 1.900.1")

local root="/opt/local/apps/jasper/1.900.1-gnu/"

prepend_path("PATH", pathJoin(root,"bin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("LIBRARY_PATH", pathJoin(root,"lib"))
prepend_path("CPATH", pathJoin(root, "include"))
prepend_path("CMAKE_PREFIX_PATH", root)

setenv("JASPER", root)
setenv("JASPERPATH", root)
setenv("JASPER_PATH", root)

family("jasper")
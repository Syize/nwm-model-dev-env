help([[
The x template library 0.8.2
]])

whatis("Name: The x template library (xtl)")
whatis("Version: 0.8.2")

local root="/opt/local/apps/xtl/0.8.2"

prepend_path("CPATH", pathJoin(root, "include"))
prepend_path("CPATH", pathJoin(root, "include/xtl"))
prepend_path("PKG_CONFIG_PATH", pathJoin(root, "share/pkgconfig"))
prepend_path("CMAKE_PREFIX_PATH", pathJoin(root, "share"))

family("xtl")
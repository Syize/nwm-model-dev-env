help([[
nlohmann_json 3.12.0
]])

whatis("Name: nlohmann_json")
whatis("Version: 3.12.0")

local root="/opt/local/apps/nlohmann_json/3.12.0"

prepend_path("CPATH", pathJoin(root, "include"))
prepend_path("CPATH", pathJoin(root, "include/nlohmann"))

family("nlohmann_json")
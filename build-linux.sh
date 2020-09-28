

git submodule update --init --recursive
export GTA_III_RE_DIR=/home/nick/re3/re3-pc-linux/re3
export GTA_III_RE_DIR=./
echo $GTA_III_RE_DIR
./libs.sh
./premake5Linux --with-librw gmake2
cd build
make config=debug_linux-amd64-librw_gl3_glfw-oal
make config=release_linux-amd64-librw_gl3_glfw-oal

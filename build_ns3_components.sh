E2SIM_PATCH="../ns3-mmwave-oran-patches/oran-e2sim/oran-e2sim-patch.patch"
ORAN_PATCH="../../../ns3-mmwave-oran-patches/oran-interface/oran-interface-patch.patch"

sudo apt-get update
sudo apt-get install -y build-essential git cmake libsctp-dev autoconf automake libtool bison

cd ..

git clone https://github.com/wineslab/ns-o-ran-e2-sim oran-e2sim
cd oran-e2sim
git apply --ignore-space-change --ignore-whitespace $E2SIM_PATCH
cd e2sim
mkdir build
./build_e2sim.sh "3"

cd ../..


git clone https://github.com/nsnam/ns-3-dev-git.git

WORKING_COMMIT="3e98de188d7b5d5a53b04efb28ee60bac4db4cc5"
PATCH_FILE="../ns3-mmwave-oran-patches/mmwave/mmwave-patch.patch"
TARGET_DIR="ns-3-dev-git"
cd $TARGET_DIR
git checkout $WORKING_COMMIT
git apply --ignore-space-change --ignore-whitespace $PATCH_FILE

cd "contrib"

git clone -b master https://github.com/o-ran-sc/sim-ns3-o-ran-e2 oran-interface
echo "cloned oran-interface"
cd "oran-interface"
git apply --ignore-space-change --ignore-whitespace $ORAN_PATCH
echo "applied patch"
cd ../..

./ns3 clean
./ns3 configure --enable-examples --enable-tests
./ns3 build

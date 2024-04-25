WORKING_COMMIT="3e98de188d7b5d5a53b04efb28ee60bac4db4cc5"
PATCH_FILE="../ns3-mmwave-oran-patches/mmwave/mmwave-patch.patch"
TARGET_DIR="../ns-3-dev-git"

cd $TARGET_DIR

git checkout $WORKING_COMMIT

git apply --whitespace=fix $PATCH_FILE

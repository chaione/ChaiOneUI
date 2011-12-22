set -e

echo "Updating submodules..."
git submodule update --init --recursive

echo "Building for iPhone Simulator 5.0..."
xcodebuild -workspace ChaiOneUI.xcworkspace -scheme ChaiOneUI -configuration Release -sdk iphonesimulator5.0 clean build

echo "Building for iPhone Device 5.0..."
xcodebuild -workspace ChaiOneUI.xcworkspace -scheme ChaiOneUI -configuration Release -sdk iphoneos5.0 clean build

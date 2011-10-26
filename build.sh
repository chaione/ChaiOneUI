set -e

git submodule update --init --recursive
xcodebuild -project ChaiOneUI.xcodeproj -target ChaiOneUI -configuration Debug -sdk iphonesimulator5.0 clean build


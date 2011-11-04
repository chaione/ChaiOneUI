set -e

git submodule update --init --recursive
xcodebuild -workspace ChaiOneUI.xcworkspace -scheme ChaiOneUI -configuration Debug -sdk iphonesimulator5.0 clean build


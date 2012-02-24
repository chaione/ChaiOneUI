Pod::Spec.new do |s|
  s.name     = 'ChaiOneUI'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'UI Utilities for apps built at ChaiONE'
  s.homepage = 'http://github.com/chaione/ChaiOneUI'
  s.author   = { 'Ben Scheirman' => 'ben@scheirman.com' }

  s.source   = { :git => 'http://github.com/chaione/ChaiOneUI.git' }

  s.platform = :ios
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'

  # A list of paths to remove after installing the Pod without the
  # `--no-clean' option. These can be examples, docs, and any other type
  # of files that are not needed to build the Pod.
  #
  # *NOTE*: Never remove license and README files.
  #
  # Also allows the use of the FileList class like `source_files does.
  #
  s.clean_path = "SampleApps"
  # s.clean_paths = "examples", "doc"

  # Specify a list of frameworks that the application needs to link
  # against for this Pod to work.
  #
  s.framework = 'UIKit'
  s.requires_arc = false

  # s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }

  # s.dependency 'JSONKit', '~> 1.4'
  s.dependency 'ChaiOneUtils', :git => "http://github.com/chaione/ChaiOneUtils.git"
end

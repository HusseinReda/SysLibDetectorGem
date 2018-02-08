
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sys_lib_detector/version"

Gem::Specification.new do |spec|
  spec.name          = "sys_lib_detector"
  spec.version       = SysLibDetector::VERSION
  spec.authors       = ["Hussein Abu Maash"]
  spec.email         = ["hussein.abumaash@gmail.com"]

  spec.summary       = "Listing and installing gems' system libraries"
  spec.description   = "SysLibDetector lists and installs all the gems' system libraries and native dependencies"
  spec.homepage      = "https://github.com/HusseinReda/SysLibDetectorGem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

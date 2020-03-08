
Pod::Spec.new do |s|
  s.name             = "HKKit"
  s.version          = "4.0.6"
  s.summary          = "Perosnal repo"
  s.description      = "Faster app development use for my personal use only in order to import and maintain my Global functions and extensions"

  s.homepage         = "https://github.com/hardikdevios/HKKit"
  s.license          = 'MIT'
  s.author           = { "Hardik" => "hardik@thetatechnolabs.com" }
  s.source           = { :git => "https://github.com/hardikdevios/HKKit.git", :tag => s.version.to_s }

  s.platform     = :ios, '10.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'Cartography'
  s.dependency 'AFDateHelper'

end

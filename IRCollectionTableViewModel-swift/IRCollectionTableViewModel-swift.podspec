Pod::Spec.new do |spec|
  spec.name         = "IRCollectionTableViewModel-swift"
  spec.version      = "1.0"
  spec.summary      = "A powerful and elegant CollectionView/TableView of iOS."
  spec.description  = "A powerful and elegant CollectionView/TableView of iOS."
  spec.homepage     = "https://github.com/irons163/IRCollectionTableViewModel-swift.git"
  spec.license      = "MIT"
  spec.author       = "irons163"
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/irons163/IRCollectionTableViewModel-swift.git", :tag => spec.version.to_s }
# spec.source       = { :path => '.' }
  spec.source_files  = "IRCollectionTableViewModel-swift/**/*.{h,m}"
end
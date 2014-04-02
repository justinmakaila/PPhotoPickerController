Pod::Spec.new do |s|
  s.name             = "PPhotoPickerController"
  s.version          = "0.1.0"
  s.summary          = "A short description of PPhotoPickerController."
  s.description      = <<-DESC
                       An optional longer description of PPhotoPickerController

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://EXAMPLE/NAME"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "justinmakaila" => "justinmakaila@gmail.com" }
  s.source           = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EXAMPLE'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Classes'
  s.resources = 'Assets/*.png', 'Classes/*.xib'
end

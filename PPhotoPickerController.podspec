Pod::Spec.new do |s|
  s.name             = "PPhotoPickerController"
  s.version          = "0.1.0"
  s.summary          = "A short description of PPhotoPickerController."
  s.description      = <<-DESC
                       Provides an interface similar to the photo picker of Messages
                       DESC
  s.homepage         = "http://github.com/justinmakaila"
  s.license          = 'MIT'
  s.author           = { "justinmakaila" => "justinmakaila@gmail.com" }
  s.source           = { :git => "http://github.com/justinmakaila/PPhotoPickerController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EXAMPLE'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Classes'
  s.resources = 'Classes/*.xib'
end

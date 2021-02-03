Pod::Spec.new do |s|
  s.name         = 'YYImage'
  s.summary      = 'Image framework for iOS to display/encode/decode animated WebP, APNG, GIF, and more.'
  s.version      = '1.0.5'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'ibireme' => 'ibireme@gmail.com' }
  s.social_media_url = 'http://blog.ibireme.com'
  s.homepage     = 'https://github.com/ibireme/YYImage'
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => 'https://github.com/CatchSocial/YYImage.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  #  s.default_subspec = 'Core'
  
  #  s.subspec 'Core' do |core|
  s.source_files = 'YYImage/*.{h,m}'
  s.public_header_files = 'YYImage/*.{h}'
  s.libraries = 'z'
  s.frameworks = 'UIKit', 'CoreFoundation', 'QuartzCore', 'ImageIO', 'Accelerate', 'CoreServices'
  s.dependency 'libwebp'    
  s.xcconfig = {   
    'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/libwebp/src'
  }
#  end

#  s.subspec 'WebP' do |webp|
#    webp.dependency 'libwebp'
#    webp.source_files = 'libwebp/src/*.{h}'
#    webp.public_hdader_files = 'libwebp/src/*.{c}'
#  end
#    
#  
#  s.subspec 'WebP' do |webp|
#    webp.dependency 'YYImage/Core'
#    webp.ios.vendored_frameworks = 'Vendor/WebP.framework', 'Vendor/WebPDecoder.framework', 'Vendor/WebPDemux.framework', 'Vendor/WebPMux.framework'
#  end

#  s.subspec 'libwebp' do |libwebp|
#    libwebp.dependency 'YYImage/Core'
#    libwebp.dependency 'libwebp'
#    libwebp.xcconfig = { 
#      'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/libwebp/src'
#    }
#  end
  
end

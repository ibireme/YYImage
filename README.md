YYImage
==============
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYImage/master/LICENSE)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;
[![Cocoapods](http://img.shields.io/cocoapods/v/YYImage.svg?style=flat)](http://cocoapods.org/?q= YYImage)&nbsp;
[![Cocoapods](http://img.shields.io/cocoapods/p/YYImage.svg?style=flat)](http://cocoapods.org/?q= YYImage)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)

Image framework for iOS to display/encode/decode animated WebP, APNG, GIF, and more.

![niconiconi~](https://raw.github.com/ibireme/YYImage/master/Demo/YYImageDemo/niconiconi@2x.gif
)

Features
==============
- Display/encode/decode animated image with these types:<br/>&nbsp;&nbsp;&nbsp;&nbsp;WebP, APNG, GIF.
- Display/encode/decode still image with these types:<br/>&nbsp;&nbsp;&nbsp;&nbsp;WebP, PNG, GIF, JPEG, JP2, TIFF, BMP, ICO, ICNS.
- Baseline/progressive/interlaced image decode with these types:<br/>&nbsp;&nbsp;&nbsp;&nbsp;PNG, GIF, JPEG, BMP.
- Display frame based image animation and sprite sheet animation.
- Fully compatible with UIImage and UIImageView class.
- Extendable protocol for custom image animation.
- Dynamic memory buffer for lower memory usage.

Usage
==============

###Display animated image
	
	// File: ani@2x.webp
	UIImage *image = [YYImage imageNamed:@"ani.webp"];
	UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
	[self.view addSubView:imageView];


###Display frame animation
	
	// Files: frame1.png, frame2.png, frame3.png
	NSArray *paths = @[@"/ani/frame1.png", @"/ani/frame2.png", @"/ani/frame3.png"];
	NSArray *times = @[@0.1, @0.2, @0.1];
	UIImage *image = [YYFrameImage alloc] initWithImagePaths:paths frameDurations:times repeats:YES];
	UIImageView *imageView = [YYAnimatedImageView alloc] initWithImage:image];
	[self.view addSubView:imageView];

###Display sprite sheet animation

	// 8 * 12 sprites in a single sheet image
	UIImage *spriteSheet = [UIImage imageNamed:@"sprite-sheet"];
	NSMutableArray *contentRects = [NSMutableArray new];
	NSMutableArray *durations = [NSMutableArray new];
	for (int j = 0; j < 12; j++) {
	   for (int i = 0; i < 8; i++) {
	       CGRect rect;
	       rect.size = CGSizeMake(img.size.width / 8, img.size.height / 12);
	       rect.origin.x = img.size.width / 8 * i;
	       rect.origin.y = img.size.height / 12 * j;
	       [contentRects addObject:[NSValue valueWithCGRect:rect]];
	       [durations addObject:@(1 / 60.0)];
	   }
	}
	YYSpriteSheetImage *sprite;
	sprite = [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:img
	                                                contentRects:contentRects
	                                              frameDurations:durations
	                                                   loopCount:0];
	YYAnimatedImageView *imageView = [YYAnimatedImageView new];
	imageView.size = CGSizeMake(img.size.width / 8, img.size.height / 12);
	imageView.image = sprite;
	[self.view addSubView:imageView];

###Animation control
	
	YYAnimatedImageView *imageView = ...;
	// pause:
	[imageView stopAnimating];
	// play:
	[imageView startAnimating];
	// set frame index:
	imageView.currentAnimatedImageIndex = 12;
	
###Image decoder
		
	// Decode single frame:
	NSData *data = [NSData dataWithContentOfFile:@"/tmp/image.webp"];
	YYImageDecoder *decoder = [YYImageDecoder decoderWithData:data scale:2.0];
	UIImage image = [decoder frameAtIndex:0 decodeForDisplay:YES].image;
	
	// Progressive:
	NSMutableData *data = [NSMutableData new];
	YYImageDecoder *decoder = [[YYImageDecoder alloc] initWithScale:2.0];
	while(newDataArrived) {
	   [data appendData:newData];
	   [decoder updateData:data final:NO];
	   if (decoder.frameCount > 0) {
	       UIImage image = [decoder frameAtIndex:0 decodeForDisplay:YES].image;
	       // progressive display...
	   }
	}
	[decoder updateData:data final:YES];
	UIImage image = [decoder frameAtIndex:0 decodeForDisplay:YES].image;
	// final display...

###Image encoder
	
	// Encode still image:
	YYImageEncoder *jpegEncoder = [[YYImageEncoder alloc] initWithType:YYImageTypeJPEG];
	jpegEncoder.quality = 0.9;
	[jpegEncoder addImage:image duration:0];
	NSData jpegData = [jpegEncoder encode];
	 
	// Encode animated image:
	YYImageEncoder *webpEncoder = [[YYImageEncoder alloc] initWithType:YYImageTypeWebP];
	webpEncoder.loopCount = 5;
	[webpEncoder addImage:image0 duration:0.1];
	[webpEncoder addImage:image1 duration:0.15];
	[webpEncoder addImage:image2 duration:0.2];
	NSData webpData = [webpEncoder encode];

Installation
==============

### Cocoapods

1. Update cocoapods to the latest version.
1. Add `pod "YYImage"` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import \<YYImage/YYImage.h\>


### Carthage

1. Add `github "ibireme/YYImage"` to your Cartfile.
2. Run `carthage update --platform ios` and add the framework to your project.
3. Import \<YYImage/YYImage.h\>
4. Notice: carthage framework doesn't include webp component, if you want to support webp, use cocoapods or install manually.

### Manually

1. Download all the files in the YYImage subdirectory.
2. Add the source files to your Xcode project.
3. Link with required frameworks:
	* UIKit.framework
	* CoreFoundation.framework
	* QuartzCore.framework
	* AssetsLibrary.framework
	* ImageIO.framework
	* Accelerate.framework
	* MobileCoreServices.framework
	* libz
4. Add `Vendor/WebP.framework`(static library) to your Xcode project if you want to support webp.
5. Import `YYImage.h`.


About
==============
This library supports iOS 6.0 and later.


License
==============
YYImage is provided under the MIT license. See LICENSE file for details.

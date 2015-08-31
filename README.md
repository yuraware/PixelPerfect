# PixelPerfect
[![Supported Plateforms](https://img.shields.io/badge/platform-ios-brightgreen.svg)](https://github.com/ykobets/PixelPerfect) 

Compare mockup design images with a user interface on iOS, get the diff of images using inversion or transparency of design mockups.

##Features
* show mockup image over a user interface
* change the mockup image transparency
* invert colors

![](https://github.com/ykobets/PixelPerfect/blob/master/example.gif)

##Usage

1. Copy mockup design images to project. 
2. Create dictionary with class name and corresponding mockup image name. 
3. Instantiate `PIXELPerfect` with this dictionary in application delegate class. 

In the status bar there appears buttons "show/hide" and "settings".
Now you can compare mockup image with actual user interface.

AppDelegate.m 

Objective-C
```
#ifdef DEBUG
    NSDictionary *classesImagesDictionary = @{ NSStringFromClass([ExampleViewController class]) : @"viewcontroller-mockup.png" };
    [[PIXELPerfect shared] setControllersClassesAndImages:classesImagesDictionary];
#endif
```

##Install

Install with [CocoaPods](http://cocoapods.org/). Add next lines to `Podfile`

```
platform :ios, '7.0'

pod 'PixelPerfect'
```

# PixelPerfect
Compare mockup design with a user interface on iOS

You can inspect an implemented user interface. Setup your mockup images with corresponding view controllers in AppDelegate. You can see the diff of images using inversion of design mockup.

[![Supported Plateforms](https://img.shields.io/badge/platform-ios-brightgreen.svg)](https://github.com/ykobets/PixelPerfect) 

##Features
* show mockup image to compare with a user interface
* change the mockup image transparency
* invert colors

![](https://github.com/ykobets/PixelPerfect/blob/master/example.gif)

##Usage

Create dictionary with class name and corresponding mockup image name. In the status bar appears buttons "show/hide" and "settings". Now you can compare mockup image with actual user interface.

```
#ifdef DEBUG
    NSDictionary *classesImagesDictionary = @{ NSStringFromClass([ExampleViewController class]) : @"add-point.png" };
    [[PIXELPerfect shared] setControllersClassesAndImages:classesImagesDictionary];
#endif
```

##Install

Install with [CocoaPods](http://cocoapods.org/). Add next lines to `Podfile`

```
platform :ios, '7.0'

pod 'PixelPerfect', git: 'https://github.com/ykobets/PixelPerfect'
```

# PixelPerfect
[![Supported Plateforms](https://img.shields.io/badge/platform-ios-brightgreen.svg)](https://github.com/ykobets/PixelPerfect) 

Compare mockup design images with a user interface on iOS, get the diff of images using inversion or transparency of design mockups.

##Features
* show a mockup image imposed with a user interface
* change a mockup image transparency
* invert colors of a mockup image to see design difference

![](https://github.com/ykobets/PixelPerfect/blob/master/example.gif)

##Usage

1. Copy mockup design images to project. 
2. Create dictionary with class name and corresponding mockup image name. 
3. Instantiate `PIXELPerfect` with this dictionary in application delegate class. 

In the status bar there appears buttons "show/hide" and "settings".
Now you can compare mockup image with actual user interface.

`AppDelegate.m`

`Objective-C`

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#ifdef DEBUG
    NSDictionary *classesImagesDictionary = @{ NSStringFromClass([ExampleViewController class]) : @"viewcontroller-mockup.png" };
    [[PIXELPerfect shared] setControllersClassesAndImages:classesImagesDictionary];
#endif    
    
    return YES;
}
```

`Swift`
```
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    let classesImagesDictionary = [NSStringFromClass(ViewController.self) : "viewcontroller-mockup.png"]
    PIXELPerfect.shared().setControllersClassesAndImages(classesImagesDictionary)
    
    return true
}
```

##Install

Install with [CocoaPods](http://cocoapods.org/). Add next lines to `Podfile`

```
platform :ios, '7.0'

pod 'PixelPerfect'
```

In case of using Swift project

```
platform :ios, '7.0'
use_frameworks!

pod 'PixelPerfect'
```

//
//  PPPerfectManager.m
//  PerfectPixel-Project
//
//  Created by Yuri on 4/30/15.
//  Copyright (c) 2015 Yuri Kobets. All rights reserved.
//

#import "PIXELPerfect.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "PIXELViewController.h"
#import "PIXELWindow.h"

static PIXELPerfect *_sharedInstance = nil;

static NSString * const kPIXELImageInvertedImageKey = @"kPIXELImageInvertedImageKey";
static NSString * const kPIXELImageAlphaKey = @"kPIXELImageAlphaKey";
static float const kPIXELDefaultImageAlpha = 0.5;

static IMP viewDidLoadImplementation = NULL;
static IMP viewWillDisappearImplementation = NULL;
static IMP viewDidAppearImplementation = NULL;
static IMP viewWillAppearImplementation = NULL;

@interface PIXELPerfect ()

- (void)swizzleUIViewControllerMethods;

@property (nonatomic,strong) NSDictionary * classesImagesDict;

@end

@implementation PIXELPerfect

+ (PIXELPerfect *)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [PIXELPerfect new];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self swizzleUIViewControllerMethods];
    }
    
    return self;
}

- (void)setImageInverted:(BOOL)imageInverted
{
    [[NSUserDefaults standardUserDefaults] setBool:imageInverted forKey:kPIXELImageInvertedImageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isImageInverted
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kPIXELImageInvertedImageKey];
}

- (void)setImageAlpha:(float)imageAlpha
{
    [[NSUserDefaults standardUserDefaults] setFloat:imageAlpha forKey:kPIXELImageAlphaKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (float)imageAlpha
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kPIXELImageAlphaKey] == nil) {
        return kPIXELDefaultImageAlpha;
    }
    
    return [[NSUserDefaults standardUserDefaults] floatForKey:kPIXELImageAlphaKey];
}

- (void)swizzleUIViewControllerMethods
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        SEL viewDidLoadSelector = @selector(viewDidLoad);
        SEL viewWillDisappearSelector = @selector(viewWillDisappear:);
        SEL viewDidAppearSelector = @selector(viewDidAppear:);
        SEL viewWillAppearSelector = @selector(viewWillAppear:);
        
        viewDidLoadImplementation = class_getMethodImplementation([UIViewController class], viewDidLoadSelector);
        viewWillDisappearImplementation = class_getMethodImplementation([UIViewController class], viewWillDisappearSelector);
        viewDidAppearImplementation = class_getMethodImplementation([UIViewController class], viewDidAppearSelector);
        viewWillAppearImplementation = class_getMethodImplementation([UIViewController class], viewWillAppearSelector);
        
        Method originalViewDidLoadMethod = class_getInstanceMethod([UIViewController class], viewDidLoadSelector);
        Method swizzledViewDidLoadMethod = class_getInstanceMethod([PIXELViewController class], viewDidLoadSelector);

        Method originalViewWillDisappearMethod = class_getInstanceMethod([UIViewController class], viewWillDisappearSelector);
        Method swizzledViewWillDisappearMethod = class_getInstanceMethod([PIXELViewController class], viewWillDisappearSelector);

        Method originalViewDidAppearMethod = class_getInstanceMethod([UIViewController class], viewDidAppearSelector);
        Method swizzledViewDidAppearMethod = class_getInstanceMethod([PIXELViewController class], viewDidAppearSelector);

        Method originalViewWillAppearMethod = class_getInstanceMethod([UIViewController class], viewWillAppearSelector);
        Method swizzledViewWillAppearMethod = class_getInstanceMethod([PIXELViewController class], viewWillAppearSelector);
        
        method_exchangeImplementations(originalViewDidLoadMethod, swizzledViewDidLoadMethod);
        method_exchangeImplementations(originalViewWillDisappearMethod, swizzledViewWillDisappearMethod);
        method_exchangeImplementations(originalViewDidAppearMethod, swizzledViewDidAppearMethod);
        method_exchangeImplementations(originalViewWillAppearMethod, swizzledViewWillAppearMethod);
    });
}

- (void)viewDidLoad
{
    viewDidLoadImplementation();
}

- (void)viewWillDisappear:(BOOL)animated
{
    viewWillDisappearImplementation();
}

- (void)viewDidAppear:(BOOL)animated
{
    viewDidAppearImplementation();
}

- (void)viewWillAppear:(BOOL)animated
{
    viewWillAppearImplementation();
}

- (void)setControllersClassesAndImages:(NSDictionary *)classesImagesDict
{
    _classesImagesDict = classesImagesDict;
}

- (UIImage *)imageForControllerClass:(Class)aClass
{
    NSString *keyClass = NSStringFromClass(aClass);
    NSString *imageName = self.classesImagesDict[keyClass];
    
    return [UIImage imageNamed:imageName];
}

- (UIWindow *)overlayWindow
{
    if (_overlayWindow == nil) {
        _overlayWindow = [[PIXELWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayWindow.windowLevel = UIWindowLevelStatusBar;
        _overlayWindow.hidden = NO;
        _overlayWindow.backgroundColor = [UIColor clearColor];

    }
    
    return _overlayWindow;
}

@end

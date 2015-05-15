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

static IMP viewDidLoadImplementation = NULL;
static IMP viewWillDisappearImplementation = NULL;

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

- (void)swizzleUIViewControllerMethods
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        SEL viewDidLoadSelector = @selector(viewDidLoad);
        SEL viewWillDisappearSelector = @selector(viewWillDisappear:);
        
        viewDidLoadImplementation = class_getMethodImplementation([UIViewController class], viewDidLoadSelector);
        viewWillDisappearImplementation = class_getMethodImplementation([UIViewController class], viewWillDisappearSelector);
        
        Method originalViewDidLoadMethod = class_getInstanceMethod([UIViewController class], viewDidLoadSelector);
        Method swizzledViewDidLoadMethod = class_getInstanceMethod([PIXELViewController class], viewDidLoadSelector);

        Method originalViewWillDisappearMethod = class_getInstanceMethod([UIViewController class], viewWillDisappearSelector);
        Method swizzledViewWillDisappearMethod = class_getInstanceMethod([PIXELViewController class], viewWillDisappearSelector);
     
        method_exchangeImplementations(originalViewDidLoadMethod, swizzledViewDidLoadMethod);
        method_exchangeImplementations(originalViewWillDisappearMethod, swizzledViewWillDisappearMethod);
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

//
//  AppDelegate.m
//  PixelPerfect
//
//  Created by Yuri on 5/14/15.
//  Copyright (c) 2015 Yuri Kobets. All rights reserved.
//

#import "AppDelegate.h"

#import "PIXELPerfect.h"
#import "ExampleViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#ifdef DEBUG
    NSDictionary *classesImagesDictionary = @{ NSStringFromClass([ExampleViewController class]) : @"add-point.png" };
    [[PIXELPerfect shared] setControllersClassesAndImages:classesImagesDictionary];
#endif
    
    return YES;
}

@end

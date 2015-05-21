//
//  PPPerfectViewController.m
//  PerfectPixel-Example
//
//  Created by Yuri on 4/30/15.
//  Copyright (c) 2015 Yuri Kobets. All rights reserved.
//

#import "PIXELViewController.h"
#import "PIXELPerfect.h"
#import "PIXELWindow.h"
#import "UIImage+ColorInverse.h"
#import <objc/runtime.h>
#import "PIXELSettingsViewController.h"

static NSInteger const kPIXELShowButtonTag = 1001;
static NSInteger const kPIXELSettingsButtonTag = 1002;
static NSInteger const kPIXELMockupImageViewTag = 1003;

@interface PIXELViewController ()
{
    UIImageView *_mockupImageView;
}

@end

@implementation PIXELViewController


- (void)viewDidLoad
{    
    Class class = object_getClass(self);
    
    SEL showMockupSelector = @selector(showOrHideMockupImageView);
    Method showMockupMethod = class_getInstanceMethod([PIXELViewController class], showMockupSelector);
    IMP showMockupImp = method_getImplementation(showMockupMethod);
    const char *showMockupMethodTypeEncoding = method_getTypeEncoding(showMockupMethod);
    class_addMethod(class, showMockupSelector, showMockupImp, showMockupMethodTypeEncoding);

    SEL showSettingsSelector = @selector(settingsPressed:);
    Method showSettingsMethod = class_getInstanceMethod([PIXELViewController class], showSettingsSelector);
    IMP showSettingsImp = method_getImplementation(showSettingsMethod);
    const char *showSettingsMethodTypeEncoding = method_getTypeEncoding(showSettingsMethod);
    class_addMethod(class, showSettingsSelector, showSettingsImp, showSettingsMethodTypeEncoding);
    
    UIImage *image = [[PIXELPerfect shared] imageForControllerClass:[self class]];
    
    if (image) {
        
        [PIXELPerfect shared].recentUsedClass = [self class];
        
        [PIXELPerfect shared].overlayWindow.hidden = NO;
        
        _mockupImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _mockupImageView.tag = kPIXELMockupImageViewTag;
        _mockupImageView.image = [PIXELPerfect shared].isImageInverted ? image.inverseColors : image;
        _mockupImageView.alpha = 0.5;
        _mockupImageView.hidden = YES;
        
        [[PIXELPerfect shared].overlayWindow makeKeyWindow];
        [[PIXELPerfect shared].overlayWindow addSubview:_mockupImageView];
        
        UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2. - 110.,
                                                                          0,
                                                                          100.0,
                                                                          20.)];
        showButton.tag = kPIXELShowButtonTag;
        showButton.backgroundColor = [UIColor lightGrayColor];
        showButton.layer.masksToBounds = YES;
        showButton.layer.cornerRadius = 5.;
        
        [showButton setTitle:@"Show" forState:UIControlStateNormal];
        [showButton addTarget:self action:@selector(showOrHideMockupImageView) forControlEvents:UIControlEventTouchUpInside];
        
        [[PIXELPerfect shared].overlayWindow addSubview:showButton];
        
        UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2. + 10.,
                                                                              0,
                                                                              100.0,
                                                                              20.)];
        settingsButton.tag = kPIXELSettingsButtonTag;
        settingsButton.backgroundColor = [UIColor lightGrayColor];
        settingsButton.layer.masksToBounds = YES;
        settingsButton.layer.cornerRadius = 5.;
        
        [settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
        [settingsButton addTarget:self action:@selector(settingsPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [[PIXELPerfect shared].overlayWindow addSubview:settingsButton];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self isKindOfClass:[PIXELPerfect shared].recentUsedClass]) {
        [PIXELPerfect shared].overlayWindow.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self isKindOfClass:[PIXELPerfect shared].recentUsedClass]) {
        [PIXELPerfect shared].overlayWindow.hidden = NO;
    }
    
    UIImage *image = [[PIXELPerfect shared] imageForControllerClass:[self class]];
    
    if (image) {
        UIImageView *mockupImageView = (UIImageView *)[[PIXELPerfect shared].overlayWindow viewWithTag:kPIXELMockupImageViewTag];
        mockupImageView.image  = [PIXELPerfect shared].isImageInverted ? image.inverseColors : image;
        
        mockupImageView.alpha = [PIXELPerfect shared].imageAlpha;
    }
}

#pragma mark -

- (void)showOrHideMockupImageView
{
    _mockupImageView.hidden = !_mockupImageView.isHidden;

    if (_mockupImageView.isHidden) {
        __block CGRect frame = _mockupImageView.frame;
        frame.origin.y = -CGRectGetHeight(_mockupImageView.bounds);
        _mockupImageView.frame = frame;
        
        [UIView animateWithDuration:0.8 animations:^{
            frame.origin.y = 0;
            _mockupImageView.frame = frame;
        }];
    }
    
    NSString *title = _mockupImageView.isHidden ? @"show" : @"hide";

    UIButton *showButton = (UIButton *)[[PIXELPerfect shared].overlayWindow viewWithTag:kPIXELShowButtonTag];
    [showButton setTitle:title forState:UIControlStateNormal];
}

- (void)settingsPressed:(id)sender
{
    PIXELSettingsViewController *settingsViewController = [[PIXELSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    [self presentViewController:navigationViewController animated:YES completion:nil];
}

@end

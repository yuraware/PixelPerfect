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

static NSInteger const kPIXELShowButtonTag = 1001;

@interface PIXELViewController ()
{
    UIImageView *_mockupImageView;
}

@end

@implementation PIXELViewController


- (void)viewDidLoad
{
    Class class = object_getClass(self);
    SEL selector = @selector(showOrHideMockupImageView);
    Method method = class_getInstanceMethod([PIXELViewController class], selector);
    IMP imp = method_getImplementation(method);
    const char *methodTypeEncoding = method_getTypeEncoding(method);

    BOOL methodAdded = class_addMethod(class, selector, imp, methodTypeEncoding);
    
    if (!methodAdded) {
        NSLog(@"can't add method %@", NSStringFromSelector(selector));
    }
    
    UIImage *image = [[PIXELPerfect shared] imageForControllerClass:[self class]];
    
    if (image) {
        
        [PIXELPerfect shared].recentUsedClass = [self class];
        
        [PIXELPerfect shared].overlayWindow.hidden = NO;
        
        _mockupImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _mockupImageView.image = image.inverseColors;
        _mockupImageView.alpha = 0.5;
        _mockupImageView.hidden = YES;
        
        [[PIXELPerfect shared].overlayWindow makeKeyWindow];
        [[PIXELPerfect shared].overlayWindow addSubview:_mockupImageView];
        
        UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2. - 50.,
                                                                          0,
                                                                          100.0,
                                                                          20.)];
        showButton.tag = kPIXELShowButtonTag;
        showButton.backgroundColor = [UIColor lightGrayColor];
        showButton.layer.masksToBounds = YES;
        showButton.layer.cornerRadius = 5.;
        
        [showButton setTitle:@"Show" forState:UIControlStateNormal];
        [showButton addTarget:self action:@selector(showOrHideMockupImageView) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:showButton];
        [[PIXELPerfect shared].overlayWindow addSubview:showButton];
        
       // _showButton = showButton;

    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self isKindOfClass:[PIXELPerfect shared].recentUsedClass]) {
        [PIXELPerfect shared].overlayWindow.hidden = YES;
        [[PIXELPerfect shared].overlayWindow removeSubviews];
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

@end

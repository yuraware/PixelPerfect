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

@interface PIXELViewController ()

@end

@implementation PIXELViewController

- (void)viewDidLoad
{
    UIImage *image = [[PIXELPerfect shared] imageForControllerClass:[self class]];
    
    if (image) {
        
        [PIXELPerfect shared].recentUsedClass = [self class];
        
        [PIXELPerfect shared].overlayWindow.hidden = NO;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = image.inverseColors;
        imageView.alpha = 0.5;
        
        [[PIXELPerfect shared].overlayWindow makeKeyWindow];
        [[PIXELPerfect shared].overlayWindow addSubview:imageView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self isKindOfClass:[PIXELPerfect shared].recentUsedClass]) {
        [PIXELPerfect shared].overlayWindow.hidden = YES;
        [[PIXELPerfect shared].overlayWindow removeSubviews];
    }
}

@end

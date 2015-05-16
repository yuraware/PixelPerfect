//
//  PerfectWindow.m
//  PixelPerfect
//
//  Created by Yuri on 5/2/15.
//  Copyright (c) 2015 Yuri Kobets. All rights reserved.
//

#import "PIXELWindow.h"

@implementation PIXELWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // accept only touches on status bar
    if (point.y < 20.) {
        return [super hitTest:point withEvent:event];
    }
    return nil;
}

- (void)removeSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end

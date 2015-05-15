//
//  UIImage+ColorInverse.m
//  PixelPerfect
//
//  Created by Yuri on 5/2/15.
//  Copyright (c) 2015 Yuri Kobets. All rights reserved.
//

#import "UIImage+ColorInverse.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (ColorInverse)

- (UIImage *)inverseColors
{
    CIImage *coreImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:coreImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithCIImage:result];
}

@end

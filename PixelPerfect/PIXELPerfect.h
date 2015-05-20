//
//  PPPerfectManager.h
//  PerfectPixel-Project
//
//  Created by Yuri on 4/30/15.
//  Copyright (c) 2015 Yuri Kobets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PIXELWindow;

@interface PIXELPerfect : NSObject

@property (nonatomic,strong) PIXELWindow *overlayWindow;

@property (nonatomic,strong) Class recentUsedClass;

@property (nonatomic,assign, getter=isImageInverted) BOOL imageInverted;
@property (nonatomic,assign) float imageAlpha;

+ (PIXELPerfect *)shared;

/**
    Sets dictionary with keys as `UIViewController class` string and values as corresponding mockup image name
    The dictionary with structure @{NSStringFromClass([UIViewController class]) : @"image.png" }
    @param classesImagesDict - dictionary with `keys` - NSString of class, `values` - image name
    
    key - NSString representation of UIViewController subclass
    value - image name. Note that image should be added to bundle
  */
- (void)setControllersClassesAndImages:(NSDictionary *)classesImagesDict;

/**
    Retrieves an image for specific UIViewController subclass
    
    @param aClass the subclass of UIViewController
 
    @return image of corresponding subclass of UIViewController
 */
- (UIImage *)imageForControllerClass:(Class)aClass;

@end

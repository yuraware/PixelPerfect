//
//  ExampleViewController.m
//  PixelPerfect-Example
//
//  Created by Yuri on 5/14/15.
//  Copyright (c) 2015 Yuri Kobets. All rights reserved.
//

#import "ExampleViewController.h"

@implementation ExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"New point";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:20/255.
                                                                           green:162./255.
                                                                            blue:218./255.
                                                                           alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                             target:nil
                                                                             action:nil];
    addItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                              target:nil
                                                                              action:nil];
    saveItem.tintColor = [UIColor whiteColor];

    self.navigationItem.leftBarButtonItem = addItem;
    self.navigationItem.rightBarButtonItem = saveItem;
    
     UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backgroundImageView setImage:[UIImage imageNamed:@"background.png"]];
    
    self.tableView.backgroundView = backgroundImageView;
}

@end

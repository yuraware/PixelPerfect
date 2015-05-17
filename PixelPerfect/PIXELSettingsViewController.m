//
//  PIXELSettingsViewController.m
//  PixelPerfect-Example
//
//  Created by Yuri on 5/17/15.
//  Copyright (c) 2015 Yuri Kobets. All rights reserved.
//

#import "PIXELSettingsViewController.h"

@interface PIXELSettingsViewController ()

@end

@implementation PIXELSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(backPressed)];
}

- (void)backPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if (indexPath.section == 0) { //invert cell
        
        cell.textLabel.text = @"Show inverted image";
        
        UISwitch *invertSwitch = [[UISwitch alloc] init];
        invertSwitch.center = cell.contentView.center;
        CGRect rect = invertSwitch.frame;
        rect.origin.x = CGRectGetWidth(self.view.frame) - CGRectGetWidth(rect) - 10.;
        invertSwitch.frame = rect;
        
        [cell.contentView addSubview:invertSwitch];
    
    } else if (indexPath.section == 1) { // alpha cell
        
        cell.textLabel.text = @"Alpha";
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(80., 10., CGRectGetWidth(self.view.bounds) - 90., 20.)];
        [cell.contentView addSubview:slider];
    }
    
    return cell;
}

@end

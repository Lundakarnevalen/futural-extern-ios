//
//  NavigationViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "NavigationViewController.h"
#import "LKColor.h"

@implementation NavigationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    [self customizeNavigationbar];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; } //set statusbar to white

- (void)customizeNavigationbar {
    
    NSDictionary *textAttributes = @{
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont fontWithName:@"Robot!Head" size:28]
                                     };
    
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBarTintColor:[LKColor colorWithIdentifier:LKColorRed]];
    [self.navigationBar setTitleTextAttributes:textAttributes];
    
}

@end

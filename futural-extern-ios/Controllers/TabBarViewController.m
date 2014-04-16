//
//  TabBarViewController.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import "TabBarViewController.h"
#import "LKColor.h"

#define TAB_INDEX_DEFAULT 2

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self customizeTabBar];
    
    [self setSelectedIndex:TAB_INDEX_DEFAULT]; //switch to map.
    
}

- (void)customizeTabBar {
    
    UIFont *font = [UIFont fontWithName:@"Futura-Bold" size:10];
    
    NSDictionary *selectedProperties = @{
                                         NSFontAttributeName : font,
                                         NSForegroundColorAttributeName : [UIColor whiteColor]
                                         }; //active tab
    NSDictionary *normalProperties = @{
                                       NSFontAttributeName : font,
                                       NSForegroundColorAttributeName : [LKColor colorWithIdentifier:LKColorLightRed]
                                       }; //standby tab
    
    [[UITabBarItem appearance] setTitleTextAttributes:selectedProperties forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:normalProperties forState:UIControlStateNormal];
    
    for(UITabBarItem *item in self.tabBar.items) {
        
        item.title = [item.title uppercaseString];
        
    }
    
}

@end
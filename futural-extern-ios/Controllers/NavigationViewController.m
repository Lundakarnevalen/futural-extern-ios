//
//  NavigationViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "NavigationViewController.h"
#import "LKColor.h"
#import "LKLayout.h"

@implementation NavigationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }    
    
    [self customizeNavigationbar];
    
}

//-(UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; } //set statusbar to white

- (void)customizeNavigationbar {
    
    NSDictionary *textAttributes = @{
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont fontWithName:@"Robot!Head" size:28]
                                     };
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        
        [self.navigationBar setTintColor:[LKColor colorWithIdentifier:LKColorRed]];
        
    }
    
    [self.navigationBar.topItem setTitle:[LKLayout defaultTitle]];
    [self.navigationBar setTranslucent:NO];
    if ([self respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationBar setBarTintColor:[LKColor colorWithIdentifier:LKColorRed]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    } else {
        [self.navigationBar setBackgroundColor:[LKColor colorWithIdentifier:LKColorRed]];
    }
    
    [self.navigationBar setTitleTextAttributes:textAttributes];
    
    //shadow beneath navbar.
    UIView *shadow = [[UIView alloc] init];
    shadow.frame = CGRectMake(0, self.navigationBar.frame.size.height, self.navigationBar.frame.size.width, 3);
    shadow.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    
    [self.navigationBar addSubview:shadow];
    
    //remove 1px default shadow.
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
}

@end

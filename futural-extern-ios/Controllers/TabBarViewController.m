//
//  TabBarViewController.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "TabBarViewController.h"
#import "LKColor.h"

#define TAB_INDEX_DEFAULT 2

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self customizeTabBar];
    
    [self setSelectedIndex:TAB_INDEX_DEFAULT]; //switch to map.
    
}

- (void)customizeTabBar {
    
    UIFont *font = [UIFont fontWithName:@"Futura-Bold" size:10];
    UIColor *colorActive = [UIColor whiteColor];
    UIColor *colorStandby = [LKColor colorWithIdentifier:LKColorLightRed];
    
    NSDictionary *selectedProperties = @{
                                         NSFontAttributeName : font,
                                         NSForegroundColorAttributeName : colorActive
                                         }; //active tab
    NSDictionary *normalProperties = @{
                                       NSFontAttributeName : font,
                                       NSForegroundColorAttributeName : colorStandby
                                       }; //standby tab
    
    [[UITabBarItem appearance] setTitleTextAttributes:selectedProperties forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:normalProperties forState:UIControlStateNormal];
    
    //remove 1px default shadow.
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBar setBarTintColor:[LKColor colorWithIdentifier:LKColorRed]];
    
    //inner shadow.
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, 3)];
    [shadow setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.15]];
    [self.tabBar addSubview:shadow];
    
    for(UITabBarItem *item in self.tabBar.items) { //set active and standby icons.
        
        item.title = [item.title uppercaseString];
        
        NSDictionary *imageNames = [self.class tabSprites];
        
        for(NSString *title in imageNames) {
            
            if([title isEqualToString:item.title]) {
                
                [item setFinishedSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-active", imageNames[title]]]
                   withFinishedUnselectedImage:[UIImage imageNamed:imageNames[title]]];
                
            }
            
        }
        
    }
    
}

#pragma mark - Class methods

+ (NSDictionary *)tabSprites {
    
    return @{
             @"NÖJEN" : @"entertainment",
             @"SCHEMA" : @"schedule",
             @"ÖVRIGT" : @"misc",
             @"KARTA" : @"map",
             @"MAT" : @"food"
             };
    
}

@end

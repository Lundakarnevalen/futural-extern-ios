//
//  TabBarViewController.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "TabBarViewController.h"
#import "LKColor.h"
#import "LKLayout.h"

#define TAB_INDEX_DEFAULT 2

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self customizeTabBar];
    
    [self setSelectedIndex:TAB_INDEX_DEFAULT]; //switch to map.
    
}

- (void)customizeTabBar {
    
    UIFont *font = [UIFont fontWithName:[LKLayout futuraFontName] size:9];
    UIColor *colorActive = [UIColor whiteColor];
    UIColor *colorStandby = [LKColor colorWithIdentifier:LKColorLightRed];
    
    NSDictionary *selectedProperties = @{
                                         UITextAttributeTextColor : [UIColor whiteColor],
                                         NSFontAttributeName : font,
                                         NSForegroundColorAttributeName : colorActive
                                         }; //active tab
    NSDictionary *normalProperties = @{
                                       UITextAttributeTextColor : [LKColor colorWithIdentifier:LKColorLightRed],
                                       NSFontAttributeName : font,
                                       NSForegroundColorAttributeName : colorStandby
                                       }; //standby tab
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
        
    }
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:selectedProperties forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:normalProperties forState:UIControlStateNormal];
    
    //remove 1px default shadow.
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    if ([self respondsToSelector:@selector(setBarTintColor:)]) {
        [self.tabBar setBarTintColor:[LKColor colorWithIdentifier:LKColorRed]];
    } else {
        [self.tabBar setBackgroundColor:[LKColor colorWithIdentifier:LKColorRed]];
    }
    
    
    //inner shadow.
    [LKLayout addInsetShadowToView:self.tabBar ofSize:3];
    
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

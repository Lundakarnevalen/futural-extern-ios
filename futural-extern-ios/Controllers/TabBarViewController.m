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

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self customizeTabBar];
    
    [self setSelectedIndex:TAB_INDEX_DEFAULT]; //switch to map.
    
    NSLog(@"Karneval: %@", self.karneval);
    
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
    
    for(UITabBarItem *item in self.tabBar.items) {
        
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

+ (NSDictionary *)tabSprites {
    
    return @{
             @"NÖJEN" : @"entertainment",
             @"SCHEMA" : @"schedule",
             @"ÖVRIGT" : @"misc",
             @"KARTA" : @"map",
             @"MAT" : @"food"
             };
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

@end

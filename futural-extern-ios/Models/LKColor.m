//
//  LKColor.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKColor.h"

@implementation LKColor

+ (UIColor *)colorWithIdentifier:(LKColorIdentifier)identifier {
    
    float red = 0.0;
    float green = 0.0;
    float blue = 0.0;
    float alpha = 1.0;
    
    switch(identifier) {
            
        case LKColorRed:
            
            red = 240.0;
            green = 82.0;
            blue = 63.0;
            
            break;
            
        case LKColorDarkRed:
            
            red = 183;
            green = 63;
            blue = 47;
            
            break;
            
        case LKColorBlue:
            
            red = 76.0;
            green = 80.0;
            blue = 108.0;
            
            break;
            
        case LKColorGreen:
            
            red = 123.0;
            green = 202.0;
            blue = 173.0;
            
            break;
            
        case LKColorLightBlue:
            
            red = 195;
            green = 210;
            blue = 238;
            
            break;
            
        case LKColorDarkGreen:
            
            red = 114;
            green = 184;
            blue = 158;
            
            break;
            
        case LKColorYellow:
            
            red = 237.0;
            green = 204.0;
            blue = 60.0;
            
            break;
            
        case LKColorLightRed:
            
            red = 250.0;
            green = 186.0;
            blue = 181.0;
            
            break;
            
        case LKColorBeige:
            
            red = 248;
            green = 235;
            blue = 216;
            
            break;
            
    }
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    
}

+ (void)customizeNavigationBar:(UINavigationBar *)navigationBar {
    
    NSDictionary *textAttributes = @{
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont fontWithName:@"FuturaLT-Bold" size:18]
                                     };
    
    [navigationBar setTranslucent:NO];
    [navigationBar setBarTintColor:[self colorWithIdentifier:LKColorRed]];
    [navigationBar setTitleTextAttributes:textAttributes];
    
}

@end
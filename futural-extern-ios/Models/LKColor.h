//
//  LKColor.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    LKColorRed = 1,
    LKColorBlue = 2,
    LKColorGreen = 3,
    LKColorYellow = 4,
    LKColorLightRed = 5
    
} LKColorIdentifier;

@interface LKColor : NSObject

+ (UIColor *)colorWithIdentifier:(LKColorIdentifier)identifier;
+ (void)customizeNavigationBar:(UINavigationBar *)navigationBar; //consistent colors and fonts throughout the app.

@end

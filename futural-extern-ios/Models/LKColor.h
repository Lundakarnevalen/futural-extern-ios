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
    LKColorLightRed = 5,
    LKColorBeige = 6,
    LKColorDarkGreen = 7,
    LKColorDarkRed = 8,
    LKColorLightBlue = 9
    
} LKColorIdentifier;

@interface LKColor : NSObject

+ (UIColor *)colorWithIdentifier:(LKColorIdentifier)identifier;

@end

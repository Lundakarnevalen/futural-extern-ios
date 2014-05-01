//
//  LKImage.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-25.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKImage.h"

@implementation LKImage

- (void)drawCircularImage:(UIColor *)strokeColor {
    
    self.strokeColor = strokeColor;
    
    [self.layer setCornerRadius:(self.frame.size.width / 2)];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderColor:strokeColor.CGColor];
    [self.layer setBorderWidth:4];
    
}

@end

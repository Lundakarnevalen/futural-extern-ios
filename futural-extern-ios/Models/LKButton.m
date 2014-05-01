//
//  LKButton.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKButton.h"

@interface LKButton()

@property (nonatomic) CAShapeLayer *circleLayer;

@end

@implementation LKButton

- (void)drawCircleButton:(UIColor *)color withStrokeWidth:(NSInteger)strokeWidth {
    
    self.strokeColor = color;
    
    [self setTitle:nil forState:UIControlStateNormal];
    
    [self.layer setCornerRadius:self.frame.size.height / 2]; //makes the button circular.
    [self.layer setMasksToBounds:YES]; //crops the image.
    [self.layer setBorderWidth:strokeWidth];
    [self.layer setBorderColor:self.strokeColor.CGColor];
    [self setImage:self.backgroundImage forState:UIControlStateNormal];

}

@end

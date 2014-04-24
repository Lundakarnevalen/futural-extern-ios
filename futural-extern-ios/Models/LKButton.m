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
@property (nonatomic) UIColor *color;

@end

#define STROKE_DEFAULT 5.0

@implementation LKButton

- (void)drawCircleButton:(UIColor *)color {
    
    self.color = color;
    
    [self setTitle:nil forState:UIControlStateNormal];
    
    [self.layer setCornerRadius:self.frame.size.height / 2]; //makes the button circular.
    [self.layer setMasksToBounds:YES]; //crops the image.
    [self.layer setBorderWidth:STROKE_DEFAULT];
    [self.layer setBorderColor:color.CGColor];
    
    [self setImage:[[[[LKarneval sharedLKarneval] events] firstObject] imageForEvent] forState:UIControlStateNormal];

}

- (void)setHighlighted:(BOOL)highlighted {
    
    if (highlighted) {
        
        self.alpha = 0.25;
        
    } else {
        
        self.alpha = 1;
        
    }
    
}

@end

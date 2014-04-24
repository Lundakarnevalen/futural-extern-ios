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
    
    [self setTitleColor:color forState:UIControlStateNormal];
    
    self.circleLayer = [CAShapeLayer layer];
    
    [self.circleLayer setBounds:CGRectMake(0.0f, 0.0f, [self bounds].size.width, [self bounds].size.height)];
    [self.circleLayer setPosition:CGPointMake(CGRectGetMidX([self bounds]),CGRectGetMidY([self bounds]))];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    [self.circleLayer setPath:[path CGPath]];
    
    [self.circleLayer setStrokeColor:[color CGColor]];
    [self setTitle:nil forState:UIControlStateNormal];
    
    [self.circleLayer setLineWidth:STROKE_DEFAULT];
    [self.circleLayer setFillColor:[[UIColor clearColor] CGColor]];
    [self setImage:[[[[LKarneval sharedLKarneval] events] firstObject] imageForEvent] forState:UIControlStateNormal];
    
    [[self layer] addSublayer:self.circleLayer];
}

- (void)setHighlighted:(BOOL)highlighted {
    
    if (highlighted)
    {
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.circleLayer setFillColor:self.color.CGColor];
    }
    else
    {
        [self.circleLayer setFillColor:[UIColor clearColor].CGColor];
        self.titleLabel.textColor = self.color;
    }
}

@end

//
//  UILabel+Shadow+FuturaBoldFont.m
//  Lundakarnevalen
//
//  Created by Richard Luong on 2014-04-18.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "UILabel+Shadow+FuturaBoldFont.h"

@implementation UILabel_Shadow_FuturaBoldFont


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setFont:[UIFont fontWithName:@"FuturaLT-Bold" size:self.font.pointSize]];
    self.text = [self.text uppercaseString];
    //[self setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2]];
    [super drawRect:rect];
    
    CGFloat width = rect.size.width;
    CGFloat height = 3;
    CGFloat x = 0;
    CGFloat y = rect.size.height - height;
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.4;
    [self addSubview:shadow];
    
    // Drawing code
}


@end

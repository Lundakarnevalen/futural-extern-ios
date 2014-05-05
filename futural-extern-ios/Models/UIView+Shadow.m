//
//  UIView+Shadow.m
//  Lundakarnevalen
//
//  Created by Richard Luong on 2014-04-18.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView_Shadow

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGFloat width = rect.size.width;
    CGFloat height = 3;
    CGFloat x = 0;
    CGFloat y = rect.size.height - height;
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.4;
    [self addSubview:shadow];
}


@end

//
//  LKAnnotationView.m
//  Lundakarneval
//
//  Created by Richard Luong on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKAnnotationView.h"
#import "LKAnnotation.h"
#import "LKLayout.h"

@implementation LKAnnotationView

@synthesize centerOffset;

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"LKAnnotation" owner:self options:nil];
        UIView *nibView = [nibObjects objectAtIndex:0];
        UILabel *label = (UILabel *)[nibView viewWithTag:TAG_LABEL];
        UIImageView *image = (UIImageView *)[nibView viewWithTag:TAG_IMAGE];
        
        [label setFont:[LKLayout detailMapHeaderFont]];
        
        image.image = ((LKAnnotation *)annotation).image;
        
        label.text = annotation.title;
        
        [self addSubview:nibView];
        
        CGFloat width = ((UIImage *)[nibView viewWithTag:TAG_BUBBLE]).size.width;
        CGFloat height = ((UIImage *)[nibView viewWithTag:TAG_BUBBLE]).size.height;
        self.bounds = CGRectMake(0, 0, width, height);
        centerOffset = CGPointMake(0 , -height / 2);
    }
    
    return self;
    
}

@end

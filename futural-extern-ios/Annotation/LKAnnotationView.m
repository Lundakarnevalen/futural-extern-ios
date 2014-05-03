//
//  LKAnnotationView.m
//  Lundakarneval
//
//  Created by Richard Luong on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKAnnotationView.h"
#import "LKLayout.h"

@implementation LKAnnotationView

@synthesize centerOffset;

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.annotation = annotation;
        
        UIView *annotationView = [[[NSBundle mainBundle] loadNibNamed:@"LKAnnotation" owner:self options:nil] firstObject];
        UILabel *label = (UILabel *)[annotationView viewWithTag:TAG_LABEL];
        UIImageView *image = (UIImageView *)[annotationView viewWithTag:TAG_IMAGE];
        
        image.image = ((LKAnnotation *) self.annotation).image;
        label.text = self.annotation.title;
        
        [label setFont:[LKLayout detailMapHeaderFont]];
        
        [self addSubview:annotationView];
        
        CGFloat width = ((UIImage *)[annotationView viewWithTag:TAG_BUBBLE]).size.width;
        CGFloat height = ((UIImage *)[annotationView viewWithTag:TAG_BUBBLE]).size.height;
        self.bounds = CGRectMake(0, 0, width, height);
        centerOffset = CGPointMake(0 , -height / 2);
        
    }
    
    return self;
    
}

@end

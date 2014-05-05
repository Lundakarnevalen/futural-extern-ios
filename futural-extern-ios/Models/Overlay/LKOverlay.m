//
//  LKOverlay.m
//  Lundakarnevalen
//
//  Created by Richard Luong on 2014-04-17.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKOverlay.h"

@implementation LKOverlay

@synthesize coordinate;
@synthesize boundingMapRect;

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.image = image;
        coordinate = CLLocationCoordinate2DMake(55.70738293380098582475, 13.19098967697549085187);
        MKMapPoint upperLeft = MKMapPointForCoordinate(self.coordinate);
        
        boundingMapRect = MKMapRectMake(upperLeft.x, upperLeft.y, 5225, 5225);
    }
    
    return self;
}

@end

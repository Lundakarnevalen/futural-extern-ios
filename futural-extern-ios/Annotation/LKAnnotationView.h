//
//  LKAnnotationView.h
//  Lundakarneval
//
//  Created by Richard Luong on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "LKAnnotation.h"

#define TAG_LABEL 1002
#define TAG_IMAGE 1001
#define TAG_BUBBLE 1003

@interface LKAnnotationView : MKAnnotationView

@property (nonatomic) LKAnnotation *annotation;

@end

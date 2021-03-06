//
//  LKMapView.h
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-05-04.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

#import "LKAnnotation.h"

@interface LKMapView : MKMapView<MKMapViewDelegate>

- (void)renderOverlay;
- (void)returnToCenterMap;

- (void)addAndCenterAnnotation:(LKAnnotation *)annotation;

@end

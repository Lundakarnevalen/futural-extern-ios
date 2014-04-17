//
//  LKPlaceOverlay.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-17.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

#import "LKPlace.h"

@interface LKPlaceOverlay : NSObject <MKOverlay>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) MKMapRect boundingMapRect;

- (LKPlaceOverlay *)initWithPlace:(LKPlace *)place; //to connect the model with the map.

@end

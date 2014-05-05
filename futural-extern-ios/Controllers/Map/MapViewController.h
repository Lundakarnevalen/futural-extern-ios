//
//  MapViewController.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "LKMapView.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet LKMapView *mapView;

@property (nonatomic) LKarneval *karneval;
@property (nonatomic) NSMutableArray *placesToPin;

//detail to map
@property (nonatomic) LKPlaceCategory visitCategory;
@property (nonatomic) LKPlace *visitPlace;

@end

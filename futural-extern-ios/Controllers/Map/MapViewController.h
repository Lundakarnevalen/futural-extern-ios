//
//  MapViewController.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate, MKMapViewDelegate>

@property (nonatomic) LKarneval *karneval;

//detail to map
@property (nonatomic) LKPlaceCategory visitCategory;
@property (nonatomic) LKPlace *visitPlace;

@end

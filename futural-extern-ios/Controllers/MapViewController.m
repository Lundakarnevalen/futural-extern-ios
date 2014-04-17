//
//  MapViewController.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

#define MAP_VIEW_X 55.924332668033337
#define MAP_VIEW_Y 13.551104518235233
#define MAP_VIEW_X_SPAN 1.2522221323685514
#define MAP_VIEW_Y_SPAN 2.0859175922040549

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.mapView.mapType = MKMapTypeSatellite;
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(MAP_VIEW_X, MAP_VIEW_Y), MKCoordinateSpanMake(MAP_VIEW_X_SPAN, MAP_VIEW_Y_SPAN));
    
    [self printPlaces];
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {

    //richard, do your magic.
    
    return [[MKOverlayView alloc] init];
    
}

- (void)printPlaces { //debug
    
    for(LKPlace *place in self.karneval.places) {
        
        MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
        pin.coordinate = place.position;
        pin.title = place.name;
        [self.mapView addAnnotation:pin];
        
    }
    
}

#pragma mark Lazy Instantiations

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

@end

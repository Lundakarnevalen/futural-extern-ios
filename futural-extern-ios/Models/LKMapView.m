//
//  LKMapView.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-05-04.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKLayout.h"
#import "LKColor.h"
#import "LKMapView.h"
#import "LKOverlay.h"
#import "LKOverlayRenderer.h"
#import "LKAnnotation.h"
#import "LKAnnotationView.h"

#import "EntertainmentViewController.h"
#import "FoodViewController.h"
#import "MiscellaneousViewController.h"

@implementation LKMapView

- (void)renderOverlay {
    
    NSLog(@"I'm ALIVE!");
    
    self.delegate = self;
    self.showsPointsOfInterest = NO; //remove coffee shops, restaurants, etc.
    self.mapType = MKMapTypeSatellite; //remove street names.
    
    LKOverlay *map = [[LKOverlay alloc] initWithImage:[UIImage imageNamed:@"Lundakarnevalen"]];
    
    self.tintColor = [LKColor colorWithIdentifier:LKColorRed];
    
    if ([self respondsToSelector:@selector(addOverlay:level:)]) {
        [self addOverlay:map  level:MKOverlayLevelAboveRoads];
    } else {
        [self addOverlay:map];
    }
    
    [self returnToCenterMap];
    
}

- (void)returnToCenterMap {
    
    NSLog(@"Escpaed from the map. Returning ..");
    self.region =  MKCoordinateRegionMake(
                                                  CLLocationCoordinate2DMake(55.705444211518049,13.194497033688751),
                                                  MKCoordinateSpanMake(0.0038183853724191863, 0.0047661187034577779));
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:LKAnnotation.class]) {
        LKAnnotation *anno = (LKAnnotation *)annotation;
        LKAnnotationView *sav = [[LKAnnotationView alloc] initWithAnnotation:anno reuseIdentifier:@""];
        sav.canShowCallout = NO;
        //        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hamburger.png"]];
        //        image.contentMode = UIViewContentModeScaleAspectFit;
        //        UIView *leftCAV = [[UIView alloc] initWithFrame:CGRectMake(0,0,25,25)];
        //        image.frame = leftCAV.frame;
        //        [leftCAV addSubview: image];
        //        sav.leftCalloutAccessoryView = leftCAV;
        //
        //        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //        [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        //sav.rightCalloutAccessoryView = rightButton;
        return sav;
        
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    LKAnnotationView *annotationView = (LKAnnotationView *)view;
    LKPlace *place = annotationView.annotation.place;
    
    NSDictionary *filters = @{
                              @"entertainment" : [LKarneval LKPlaceFilterEntertainment],
                              @"food" : [LKarneval LKPlaceFilterFood],
                              @"toilet" : [LKarneval LKPlaceFilterToilet],
                              @"trash" : [LKarneval LKPlaceFilterTrash],
                              @"misc" : [LKarneval LKPlaceFilterOther]
                              };
    
    NSDictionary *tabIndexes = @{
                                 @"entertainment" : @0,
                                 @"food" : @1,
                                 @"toilet" : @4,
                                 @"trash" : @4,
                                 @"misc" : @4
                                 }; //change this if the order of the tabs changes.
    
    [filters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSArray *currentFilter = (NSArray *)obj;
        
        [currentFilter enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            LKPlaceCategory category = [obj integerValue]; //inside of nsnumber.
            
            if(category == place.category) {
                
                NSNumber *tabIndex = tabIndexes[key]; //nsnumber
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"map.to.detail" object:self userInfo:@{@"place" : place, @"index" : tabIndex}];
                
                NSLog(@"This is contained inside of %@.", key);
                
            }
            
        }];
        
    }];
    
    NSLog(@"This annotiation is %@", annotationView.annotation.place.parent.identifier);
    
}

- (void)addAndCenterAnnotation:(LKAnnotation *)annotation {
    
    MKCoordinateRegion region = MKCoordinateRegionMake(annotation.place.position, MKCoordinateSpanMake(0.0001, 0.0001));
    
    [self addAnnotation:annotation];
    [self setRegion:region];
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    NSLog(@"%f, %f",mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
    
    if (mapView.region.span.latitudeDelta > 0.0055911036392117808) {
        [self returnToCenterMap];
    } else if (mapView.region.center.latitude < 55.70295306978420057931) {
        [self returnToCenterMap];
    } else if (mapView.region.center.latitude > 55.71001229335885085447) {
        [self returnToCenterMap];
    } else if (mapView.region.center.longitude < 13.18507803164854941258) {
        [self returnToCenterMap];
    } else if (mapView.region.center.longitude > 13.20106887303782450260) {
        [self returnToCenterMap];
    }
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:LKOverlay.class]) {
        LKOverlay *map = (LKOverlay *)overlay;
        LKOverlayRenderer *overlayRenderer = [[LKOverlayRenderer alloc] initWithOverlay:map];
        return overlayRenderer;
    }
    return nil;
}

@end

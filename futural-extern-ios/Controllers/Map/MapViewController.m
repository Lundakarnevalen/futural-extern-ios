//
//  MapViewController.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//
#import "MapKit/MapKit.h"

#import "MapViewController.h"
#import "ECSlidingViewController.h"
#import "EntertainmentViewController.h"
#import "FoodViewController.h"
#import "MiscellaneousViewController.h"

#import "LKAnnotation.h"
#import "LKAnnotationView.h"
#import "LKOverlay.h"
#import "LKOverlayRenderer.h"

#import "MapFilterViewController.h"
#import "CreateAnnotationsViewController.h"

@interface MapViewController ()

@property (nonatomic, strong) NSMutableDictionary *filter;
@property (weak, nonatomic) IBOutlet UIView *filterDescView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.visitCategory = 0;
    
    [self.mapView renderOverlay];
    
    self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Filter"];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self.slidingViewController setAnchorLeftRevealAmount:150.0f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateToDetail:) name:@"map.to.detail" object:nil]; //map model
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterMapTableViewRowDidSelect:) name:FilterMapTableViewRowDidSelect object:nil]; //filter

    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showFilterDescView"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"showFilterDescView"];
        self.filterDescView.hidden = NO;
    } else {
        NSNumber *showView = [[NSUserDefaults standardUserDefaults] objectForKey:@"showFilterDescView"];
        BOOL hidden = ![showView boolValue];
        self.filterDescView.hidden = hidden;
    }
    
    [self reloadAnnotations];
    
    if(self.visitPlace) {
        
        [self renderAllPlaces];
        
        MKMapRect zoomRect = MKMapRectNull;

        for(id <MKAnnotation>object in self.mapView.annotations) {
            
            NSString *className = NSStringFromClass([object class]);
            
            if(![className isEqualToString:@"MKUserLocation"]) { //or it'll crash, MKUser is the dot telling where the user is atm.
                
            LKAnnotation *annotation = (LKAnnotation *)object;
            LKPlace *place = annotation.place;
            
            if([place.name isEqualToString:self.visitPlace.name]) {
                
                MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
                MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
                
                if (MKMapRectIsNull(zoomRect)) {
                    zoomRect = pointRect;
                } else {
                    zoomRect = MKMapRectUnion(zoomRect, pointRect);
                }
                
            } else {
                
                [self.mapView removeAnnotation:object];
                
            }
                
            }
            
        }
        
        [self.mapView setVisibleMapRect:zoomRect animated:YES];
        self.visitPlace = nil;
        
    } else if(self.visitCategory != 0) {
        
        [self renderAllPlaces];
        
        for(id <MKAnnotation>annotation in self.mapView.annotations) {
            
            NSString *className = NSStringFromClass([annotation class]);
            
            if(![className isEqualToString:@"MKUserLocation"]) {
            
                LKAnnotation *a = (LKAnnotation *)annotation;
                
                if(a.place.category != self.visitCategory) {
                    
                    [self.mapView removeAnnotation:annotation];
                    
                }
                
            }
            
        }
        
        [self.mapView returnToCenterMap];
        self.visitCategory = 0;
        
    }
    
}

-(void)filterMapTableViewRowDidSelect:(NSNotification *)notification {
    [self reloadAnnotations];
    NSLog(@"Filter row selected.");
}

- (IBAction)mapViewClicked:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.mapView];
    CLLocationCoordinate2D coord = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    NSString *lat = [[NSString stringWithFormat:@"%.20f", coord.latitude] stringByReplacingOccurrencesOfString:@"." withString:@","];
    NSString *lng = [[NSString stringWithFormat:@"%.20f", coord.longitude] stringByReplacingOccurrencesOfString:@"." withString:@","];
    NSLog(@"\nx:\t%f\ty:\t%f\nla:\t%@\tln:\t%@", point.x, point.y, lat, lng);
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    //[self performSegueWithIdentifier:@"createAnnotationSegue" sender:location];
}

- (IBAction)showMapButtonClicked:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"showFilterDescView"];
    self.filterDescView.hidden = YES;
    [self.slidingViewController anchorTopViewTo:ECLeft];
    
}

- (void)navigateToDetail:(NSNotification *)notification {
    
    NSLog(@"YES %@", notification);
    
    LKPlace *place = notification.userInfo[@"place"];
    NSInteger tabIndex = [notification.userInfo[@"index"] integerValue];
    
    [[[self.tabBarController viewControllers] objectAtIndex:tabIndex] popToRootViewControllerAnimated:NO];
    
    EntertainmentViewController *vc = (EntertainmentViewController *)[[[self.tabBarController viewControllers] objectAtIndex:tabIndex] visibleViewController]; //fifän.
    vc.visitIdentifier = place.parent.name;
    vc.visitPlace = place.parent;
    [self.tabBarController setSelectedIndex:tabIndex];
    
}

-(void)reloadAnnotations {
    
    NSMutableArray *places = [[NSMutableArray alloc] init];
    [self.mapView removeAnnotations:[self.mapView annotations]];
    
    self.filter = (NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"filter"];
    if (!self.filter) {
        self.filter = [[NSMutableDictionary alloc] init];
        [self.filter setValue:[NSNumber numberWithBool:NO] forKey:@"food"];
        [self.filter setValue:[NSNumber numberWithBool:NO] forKey:@"entertainment"];
        [self.filter setValue:[NSNumber numberWithBool:NO] forKey:@"other"];
        [self.filter setValue:[NSNumber numberWithBool:NO] forKey:@"toilet"];
        [self.filter setValue:[NSNumber numberWithBool:NO] forKey:@"trash"];
        [[NSUserDefaults standardUserDefaults] setObject:self.filter forKey:@"filter"];
    }
    
    if ([self.filter[@"food"] boolValue]) {
        [places addObjectsFromArray:[LKarneval LKPlaceFilterFood]];
    }
    
    if ([self.filter[@"entertainment"] boolValue]) {
        [places addObjectsFromArray:[LKarneval LKPlaceFilterEntertainment]];
    }
    
    if ([self.filter[@"toilet"] boolValue]) {
        [places addObjectsFromArray:[LKarneval LKPlaceFilterToilet]];
    }
    
    if ([self.filter[@"trash"] boolValue]) {
        [places addObjectsFromArray:[LKarneval LKPlaceFilterTrash]];
    }
    
    if ([self.filter[@"other"] boolValue]) {
        [places addObjectsFromArray:[LKarneval LKPlaceFilterOther]];
    }
    
    for (LKPlace *place in [self.karneval placesFilteredByCategories:places]) {
    
        [place.subPlaces enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            
            LKAnnotation *anno = [[LKAnnotation alloc] initWithPlace:place andPositionIndexOf:index];
            [self.mapView addAnnotation:anno];
            
        }];
        
    }

}

- (void)renderAllPlaces { //used while presenting specific places.
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    for (LKPlace *place in self.karneval.places) {
        
        [place.subPlaces enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            
            LKAnnotation *anno = [[LKAnnotation alloc] initWithPlace:place andPositionIndexOf:index];
            [self.mapView addAnnotation:anno];
            
        }];
        
    }
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

- (NSMutableArray *)placesToPin {
    
    if(!_placesToPin) {
        
        _placesToPin = [[NSMutableArray alloc] init];
        
    }
    
    return _placesToPin;
    
}

@end

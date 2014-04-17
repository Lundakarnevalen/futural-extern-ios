//
//  MapViewController.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "MapViewController.h"
#import "ECSlidingViewController.h"

#import "LKAnnotation.h"
#import "LKAnnotationView.h"
#import "LKOverlay.h"
#import "LKOverlayRenderer.h"

@interface MapViewController ()

@property (nonatomic, strong) NSDictionary *filter;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *img;

@end

@implementation MapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Filter"];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self.slidingViewController setAnchorLeftRevealAmount:150.0f];
    
    LKOverlay *map = [[LKOverlay alloc] initWithImage:[UIImage imageNamed:@"Lundakarnevalen"]];
    [self.mapView addOverlay:map  level:MKOverlayLevelAboveRoads];
    
    self.mapView.region = MKCoordinateRegionMake(
                                             CLLocationCoordinate2DMake(55.705282871899165, 13.194099413861689),
                                             MKCoordinateSpanMake(0.0048452481526979341, 0.0081815629812922452));

    
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (self.navigationController.navigationBar.alpha != 0) {
        [UIView animateWithDuration:0.3
                         animations:^(void) { self.navigationController.navigationBar.alpha = 0; }
                         completion:nil];
    }
    [super viewDidAppear:animated];
    [self reloadAnnotations];
}

- (void)logMap {
    CGPoint point = self.img.frame.origin;
    CLLocationCoordinate2D coord = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    NSLog(@"\nx:\t%f\ty:\t%f\nla:\t%f\tln:\t%f", point.x, point.y, coord.latitude, coord.longitude);
}

- (IBAction)showMapButtonClicked:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

-(void)reloadAnnotations {
//    self.filter = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"filter"];
//    if (!self.filter) {
//        NSArray *filter = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"filter" ofType:@"plist"]];
//        NSNumber *yesValue = [NSNumber numberWithBool:YES];
//        NSNumber *noValue = [NSNumber numberWithBool:NO];
//        self.filter = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:yesValue, noValue, yesValue, nil] forKeys:filter];
//        [[NSUserDefaults standardUserDefaults] setObject:self.filter forKey:@"filter"];
//    }
//    
//    [self.mapView removeAnnotations:self.mapView.annotations];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"annotations" ofType:@"plist"];
//    NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSArray *annotations = nil;
//    NSString *docsPath = [docsFolder stringByAppendingString:@"/annotations.plist"];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:docsPath]) {
//        annotations = [NSArray arrayWithContentsOfFile:docsPath];
//    } else {
//        annotations = [NSArray arrayWithContentsOfFile:path];
//    }
    
    LKarneval *karneval = [LKarneval sharedLKarneval];
    
    for (LKPlace *place in karneval.places) {
        LKAnnotation *anno = [[LKAnnotation alloc] initWithPlace:place];
        [self.mapView addAnnotation:anno];
    }
    
//    for (NSDictionary *dict in annotations) {
//        double lat = [dict[@"coordinates"][@"lat"] doubleValue];
//        double lng = [dict[@"coordinates"][@"lng"] doubleValue];
//        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
//        NSString *title = [dict[@"title"] uppercaseString];
//        NSString *subTitle = dict[@"subtitle"];
//        UIImage *img = [UIImage imageNamed:dict[@"image"]];
//        NSArray *filterStrings = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"filter" ofType:@"plist"]];
//        NSInteger index = [dict[@"type"] integerValue];
//        NSString *type = [filterStrings objectAtIndex:index];
//        if ([self.filter objectForKey:type] == [NSNumber numberWithBool:YES]) {
//            LKAnnotation *anno = [[LKAnnotation alloc] initWithCoordinate:coord title:title subtitle:subTitle image:img];
//            
//            [self.mapView addAnnotation:anno];
//        }
//        
//    }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:LKOverlay.class]) {
        LKOverlay *map = (LKOverlay *)overlay;
        LKOverlayRenderer *overlayRenderer = [[LKOverlayRenderer alloc] initWithOverlay:map];
        return overlayRenderer;
    }
    return nil;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:LKAnnotation.class]) {
        LKAnnotation *anno = (LKAnnotation *)annotation;
        LKAnnotationView *sav = [[LKAnnotationView alloc] initWithAnnotation:anno reuseIdentifier:@""];
        sav.canShowCallout = NO;
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hamburger.png"]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        UIView *leftCAV = [[UIView alloc] initWithFrame:CGRectMake(0,0,25,25)];
        image.frame = leftCAV.frame;
        [leftCAV addSubview: image];
        sav.leftCalloutAccessoryView = leftCAV;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        //sav.rightCalloutAccessoryView = rightButton;
        return sav;
        
    }
    return nil;
}

@end

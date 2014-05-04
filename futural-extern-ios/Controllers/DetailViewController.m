//
//  DetailViewController.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-27.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "DetailViewController.h"
#import "MultipleChoicesViewController.h"
#import "MapViewController.h"
#import "InitViewController.h"

#import "LKLayout.h"
#import "LKColor.h"
#import "LKAnnotation.h"
#import "LKAnnotationView.h"

@interface DetailViewController() { }

@property (nonatomic) MultipleChoicesViewController *choiceVC;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:[LKLayout defaultTitle]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(multipleChoice:) name:@"choiceClick" object:nil];
    
    [self customizeView];

}

- (void)multipleChoice:(NSNotification *)notification {
    
    LKPlace *place = (LKPlace *)notification.userInfo[@"place"];
    
    [self navigateToMapWithPlace:place];
    
}

- (IBAction)sectionChanged:(id)sender {
    
    NSInteger viewTag = 5000;
    
    UISegmentedControl *segment = sender;
    NSInteger index = segment.selectedSegmentIndex;

    NSArray *choices;
    
    if(self.place.category == LKPlaceCategoryScene) {
        
        choices = [self.karneval eventsAtPlaceWithIdentifier:self.place.identifier];

    } else {
        
        choices = self.place.subPlaces;
        
    }
    
    if(self.choiceVC && index == 0) {
    
        UIView *choiceView = [self.view viewWithTag:viewTag];
        [choiceView removeFromSuperview];
        
    } else {
        
        CGRect c = self.view.frame;
        
        self.choiceVC.choices = [choices mutableCopy];
        self.choiceVC.strokeColor = self.logotypeImage.strokeColor;
        self.choiceVC.desiredBackgroundImage = self.coverImage.image;
        self.choiceVC.view.tag = viewTag;
        self.choiceVC.view.frame = CGRectMake(c.origin.x, c.origin.y - self.navigationController.navigationBar.frame.size.height - 20, c.size.width, c.size.height); //make it fit (x)
        [self.view addSubview:self.choiceVC.view];
        
    }
    
}

- (void)customizeView {
    
    UIColor *informationBarColor = [UIColor grayColor];
    UIColor *logotypeStrokeColor = [UIColor grayColor];
    UIImage *coverImage;
    NSString *headerText;

    [self.sectionButton setHidden:NO];
    
    if([self.segueIdentifier isEqualToString:@"food.detail"]) {
        
        informationBarColor = [LKColor colorWithIdentifier:LKColorDarkGreen];
        logotypeStrokeColor = [LKColor colorWithIdentifier:LKColorBeige];
        
    }
    
    if([self.segueIdentifier isEqualToString:@"entertainment.detail"]) {
        
        informationBarColor = [LKColor colorWithIdentifier:LKColorDarkRed];
        logotypeStrokeColor = [LKColor colorWithIdentifier:LKColorGreen];
        
    }
    
    if([self.segueIdentifier isEqualToString:@"event.detail"]) {
        
        informationBarColor = [LKColor colorWithIdentifier:LKColorBlue];
        logotypeStrokeColor = [UIColor whiteColor];
        [self.sectionButton setHidden:YES];
        
    }
    
    if(self.place.category == LKPlaceCategoryScene) { //if it's a place being shown.
        
        [self.sectionButton setTitle:@"EVENTS" forSegmentAtIndex:1];
        
    }
    
    if([self.place.subPlaces count] < 2 && self.place.category != LKPlaceCategoryScene) {
     
        [self.sectionButton setHidden:YES];
        
    }
    
    NSInteger randomIndex = arc4random() % [self.place.subPlaces count];
    LKPlace *randomPlace = [self.place.subPlaces objectAtIndex:randomIndex];
    MKCoordinateRegion region = MKCoordinateRegionMake(randomPlace.position, MKCoordinateSpanMake(0.0001, 0.0001));
    LKAnnotation *annotation = [[LKAnnotation alloc] initWithPlace:self.place andPositionIndexOf:randomIndex];
    [self.miniMap addAnnotation:annotation];
    
    [self.miniMap setRegion:region];
    
    [LKLayout customizeSegment:self.sectionButton];
    
    [self.informationBar setBackgroundColor:informationBarColor];
    [LKLayout addInsetShadowToView:self.informationBar ofSize:3];
    [LKLayout addShadowToView:self.informationBar ofSize:3];
    
    [self.statusView setBackgroundColor:[LKColor colorWithIdentifier:LKColorGreen]];
    [self.statusLabel setFont:[LKLayout detailMapHeaderFont]];
    [LKLayout addShadowToView:self.statusView ofSize:3];
    
    [self.cashLabel setFont:[LKLayout detailPaymentFont]];
    [self.cardLabel setFont:[LKLayout detailPaymentFont]];
    
    if(self.place) {
        
        [self.logotypeImage setImage:[self.place imageForPlace]];
        [self.headerLabel setText:[self.place.name uppercaseString]];
        [self.descriptionView setText:self.place.information];
        headerText = [[NSString stringWithFormat:@"Vad är %@?", self.place.name] uppercaseString];
        coverImage = [self.place coverImage];
        
        [self.statusView setHidden:NO];
        
    } else { //event, hide symbols.
        
        [self.statusView setHidden:YES];
        
        [self.logotypeImage setImage:[self.event imageForEvent]];
        [self.headerLabel setText:[self.event.name uppercaseString]];
        [self.subHeaderLabel setText:[self.event.place.name uppercaseString]];
        [self.descriptionView setText:self.event.information];
        headerText = [[NSString stringWithFormat:@"Vem är %@?", self.event.name] uppercaseString];
        coverImage = [self.event coverImage];
        
    }

    [self.logotypeImage drawCircularImage:logotypeStrokeColor];

    [self.headerLabel setFont:[LKLayout detailHeaderFont]];
    [LKLayout addShadowToLabel:self.headerLabel withSizeOf:2];
  
    [self.subHeaderLabel setFont:[LKLayout detailSubHeaderFont]];
    [LKLayout addShadowToLabel:self.subHeaderLabel withSizeOf:2];
    
    [self.mapLabel setFont:[LKLayout detailMapHeaderFont]];
    [LKLayout addShadowToView:self.mapView ofSize:3];
    
    [self.informationHeader setFont:[LKLayout informationHeaderFont]];
    [self.informationHeader setText:headerText];
    
    coverImage = [LKLayout blurImage:coverImage withRadiusOf:2.0]; //pretty laggy... :(
    [self.coverImage setImage:coverImage];
    
}

- (IBAction)findMe:(id)sender {
    
    [self navigateToMapWithPlace:self.place];
    
}

- (void)navigateToMapWithPlace:(LKPlace *)place {
    
    NSInteger tabIndex = 2;
    MapViewController *vc = (MapViewController *)[(UINavigationController *)[[[self.tabBarController viewControllers] objectAtIndex:tabIndex] topViewController] visibleViewController]; //fifän, igen.
    
    if(place) {
        
        NSInteger subPlaces = [place.subPlaces count];
        
        if(subPlaces > 1) {
            
            vc.visitCategory = place.category;
            NSLog(@"Multiple places that are being requested, filter excluesively.");
            
        } else {
            
            vc.visitPlace = place;
            
        }
        
    }
    
    [self.tabBarController setSelectedIndex:tabIndex];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"map.detail"]) {
        
        MapViewController *vc = (MapViewController *)segue.destinationViewController;
        vc.visitPlace = self.place;
        
    }
    
}

- (MultipleChoicesViewController *)choiceVC {
    
    if(!_choiceVC) {
        
        _choiceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"choices"];
        
        
    }
    
    return _choiceVC;
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

@end

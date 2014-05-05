//
//  DetailViewController.h
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-27.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "LKImage.h"
#import "LKMapView.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *informationBar;
@property (weak, nonatomic) IBOutlet LKImage *logotypeImage;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *subHeaderLabel;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *mapLabel;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UIImageView *cashImage;
@property (weak, nonatomic) IBOutlet UILabel *informationHeader;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sectionButton;
@property (weak, nonatomic) IBOutlet LKMapView *miniMap;

@property (nonatomic) NSString *segueIdentifier; //the segue identifier used to show this view.
@property (nonatomic) LKarneval *karneval;
@property (nonatomic) LKPlace *place;
@property (nonatomic) LKEvent *event;

@end

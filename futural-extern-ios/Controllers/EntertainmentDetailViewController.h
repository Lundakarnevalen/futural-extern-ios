//
//  EntertainmentDetailViewController.h
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-27.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKImage.h"

@interface EntertainmentDetailViewController : UIViewController

@property (nonatomic) LKPlace *place;
@property (weak, nonatomic) IBOutlet LKImage *logotypeImage;
@property (weak, nonatomic) IBOutlet UIView *statusSign;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *mapLabel;
@property (weak, nonatomic) IBOutlet UILabel *subHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UIView *informationBar;

@end

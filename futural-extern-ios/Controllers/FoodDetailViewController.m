//
//  FoodDetailViewController.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-26.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "LKColor.h"
#import "LKLayout.h"

@implementation FoodDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self customizeView];
    
    [self.logotypeImage setImage:[self.place imageForPlace]];
    [self.headerLabel setText:[self.place.name uppercaseString]];
    
    UIImage *coverImage = [self.place coverImage];
    coverImage = [LKLayout blurImage:coverImage withRadiusOf:2.0]; //pretty laggy... :(
    [self.coverImageView setImage:coverImage];
    
}

- (void)customizeView {
    
    [self.logotypeImage drawCircularImage:[LKColor colorWithIdentifier:LKColorBeige]];
    
    [self.headerLabel setFont:[LKLayout detailHeaderFont]];
    
    [self.subHeaderLabel setFont:[LKLayout detailSubHeaderFont]];
    
    [self.mapLabel setFont:[LKLayout detailMapHeaderFont]];
    [LKLayout addShadowToView:self.mapView ofSize:3];
    
    [self.statusLabel setFont:[LKLayout detailMapHeaderFont]];
    [LKLayout addShadowToView:self.statusSign ofSize:3];
    
}

@end

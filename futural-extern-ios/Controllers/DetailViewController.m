//
//  DetailViewController.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-27.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "DetailViewController.h"

#import "LKLayout.h"
#import "LKColor.h"

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:[LKLayout defaultTitle]];
    
    [self customizeView];

}

- (void)customizeView {
    
    UIColor *informationBarColor = [UIColor grayColor];
    UIColor *logotypeStrokeColor = [UIColor grayColor];
    
    if([self.segueIdentifier isEqualToString:@"food.detail"]) {
        
        informationBarColor = [LKColor colorWithIdentifier:LKColorDarkGreen];
        logotypeStrokeColor = [LKColor colorWithIdentifier:LKColorBeige];
        
    }
    
    if([self.segueIdentifier isEqualToString:@"entertainment.detail"]) {
        
        informationBarColor = [LKColor colorWithIdentifier:LKColorDarkRed];
        logotypeStrokeColor = [LKColor colorWithIdentifier:LKColorGreen];
        
        NSLog(@"Subplaces %@", self.place.subPlaces);
        
    }
    
    [self.informationBar setBackgroundColor:informationBarColor];
    [LKLayout addInsetShadowToView:self.informationBar ofSize:3];
    [LKLayout addShadowToView:self.informationBar ofSize:3];
    
    [self.statusView setBackgroundColor:[LKColor colorWithIdentifier:LKColorGreen]];
    [self.statusLabel setFont:[LKLayout detailMapHeaderFont]];
    [LKLayout addShadowToView:self.statusView ofSize:3];
    
    [self.cashLabel setFont:[LKLayout detailPaymentFont]];
    [self.cardLabel setFont:[LKLayout detailPaymentFont]];
    
    [self.cashImage setHidden:![self.place acceptsCash]];
    [self.cashLabel setHidden:![self.place acceptsCash]];
    [self.cardImage setHidden:![self.place acceptsCard]];
    [self.cardLabel setHidden:![self.place acceptsCard]];

    [self.logotypeImage setImage:[self.place imageForPlace]];
    [self.logotypeImage drawCircularImage:logotypeStrokeColor];

    [self.headerLabel setFont:[LKLayout detailHeaderFont]];
    [LKLayout addShadowToLabel:self.headerLabel withSizeOf:2];
  
    [self.subHeaderLabel setFont:[LKLayout detailSubHeaderFont]];
    [LKLayout addShadowToLabel:self.subHeaderLabel withSizeOf:2];
    
    [self.mapLabel setFont:[LKLayout detailMapHeaderFont]];
    [LKLayout addShadowToView:self.mapView ofSize:3];
    
    [self.headerLabel setText:[self.place.name uppercaseString]];
    
    NSString *headerText = [[NSString stringWithFormat:@"Vad är %@?", self.place.name] uppercaseString];
    [self.informationHeader setFont:[LKLayout informationHeaderFont]];
    [self.informationHeader setText:headerText];
    
    [self.descriptionView setText:self.place.information];
    
    UIImage *coverImage = [self.place coverImage];
    coverImage = [LKLayout blurImage:coverImage withRadiusOf:2.0]; //pretty laggy... :(
    [self.coverImage setImage:coverImage];
    
}

@end

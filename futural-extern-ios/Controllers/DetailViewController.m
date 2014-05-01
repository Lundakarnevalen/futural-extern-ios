//
//  DetailViewController.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-27.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "DetailViewController.h"
#import "MultipleChoicesViewController.h"

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
    UIImage *coverImage;
    NSString *headerText;
    
    if([self.segueIdentifier isEqualToString:@"food.detail"]) {
        
        informationBarColor = [LKColor colorWithIdentifier:LKColorDarkGreen];
        logotypeStrokeColor = [LKColor colorWithIdentifier:LKColorBeige];
        
    }
    
    if([self.segueIdentifier isEqualToString:@"entertainment.detail"]) {
        
        informationBarColor = [LKColor colorWithIdentifier:LKColorDarkRed];
        logotypeStrokeColor = [LKColor colorWithIdentifier:LKColorGreen];
        
        NSLog(@"Subplaces %@", self.place.subPlaces);
        
    }
    
    if([self.segueIdentifier isEqualToString:@"event.detail"]) {
        
        informationBarColor = [LKColor colorWithIdentifier:LKColorLightBlue];
        logotypeStrokeColor = [UIColor whiteColor];
        
    }
    
    [self.informationBar setBackgroundColor:informationBarColor];
    [LKLayout addInsetShadowToView:self.informationBar ofSize:3];
    [LKLayout addShadowToView:self.informationBar ofSize:3];
    
    [self.statusView setBackgroundColor:[LKColor colorWithIdentifier:LKColorGreen]];
    [self.statusLabel setFont:[LKLayout detailMapHeaderFont]];
    [LKLayout addShadowToView:self.statusView ofSize:3];
    
    [self.cashLabel setFont:[LKLayout detailPaymentFont]];
    [self.cardLabel setFont:[LKLayout detailPaymentFont]];
    
    if(self.place) {
        
        [self.cashImage setHidden:![self.place acceptsCash]];
        [self.cashLabel setHidden:![self.place acceptsCash]];
        [self.cardImage setHidden:![self.place acceptsCard]];
        [self.cardLabel setHidden:![self.place acceptsCard]];
        
        [self.logotypeImage setImage:[self.place imageForPlace]];
        [self.headerLabel setText:[self.place.name uppercaseString]];
        [self.descriptionView setText:self.place.information];
        headerText = [[NSString stringWithFormat:@"Vad är %@?", self.place.name] uppercaseString];
        coverImage = [self.place coverImage];
        
        [self.statusView setHidden:NO];
        
    } else { //event, hide symbols.
        
        [self.cashImage setHidden:YES];
        [self.cashLabel setHidden:YES];
        [self.cardImage setHidden:YES];
        [self.cardLabel setHidden:YES];
        
        [self.statusView setHidden:YES];
        
        [self.logotypeImage setImage:[self.event imageForEvent]];
        [self.headerLabel setText:[self.event.name uppercaseString]];
        [self.subHeaderLabel setText:[self.event.place.name uppercaseString]];
        [self.descriptionView setText:self.event.information];
        headerText = [[NSString stringWithFormat:@"Vad är %@?", self.event.name] uppercaseString];
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
    
    if(self.place) {
        
        NSInteger subPlaces = [self.place.subPlaces count];
        
        if(subPlaces > 1) {
            
            [self performSegueWithIdentifier:@"detail.grid" sender:sender];
            
        } else {
            
            NSLog(@"Take me there!");
            
        }
        
    } else {
        
        NSLog(@"This is an event, take me there.");
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    LKButton *button = sender;
    MultipleChoicesViewController *choicesVC = segue.destinationViewController;
    
    choicesVC.choices = self.place.subPlaces;
    choicesVC.strokeColor = [LKColor colorWithIdentifier:LKColorBeige];
    choicesVC.desiredBackgroundImage = self.coverImage.image;
    
}

@end

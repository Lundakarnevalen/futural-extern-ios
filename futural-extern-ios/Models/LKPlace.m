//
//  LKPlace.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKPlace.h"

@implementation LKPlace

- (LKPlace *)initWithProperties:(NSDictionary *)propertyList {
    
    self = [super init];
    
    if(self) {
        
        //create logic to read from a property list and store it in this model
        self.name = propertyList[@"name"];
        self.information = propertyList[@"description"];
        self.category = [propertyList[@"category"] integerValue];
        self.alcohol = [propertyList[@"alcohol"] boolValue];
        self.image = [UIImage imageNamed:propertyList[@"image"]];
        self.annotationImage = [UIImage imageNamed:propertyList[@"annotation_image"]];
        
        for(NSString *option in propertyList[@"payment_options"]) {
            
            NSNumber *paymentOption = [NSNumber numberWithInteger:[option integerValue]];
            [self.paymentOptions addObject:paymentOption];
            
        }
        
        //NSDictionary *position = propertyList[@"position"];
        NSArray *positions = propertyList[@"positions"];
        
        for(NSDictionary *position in positions) {
            
            CLLocationDegrees latitude = [position[@"latitude"] doubleValue];
            CLLocationDegrees longitude = [position[@"longitude"] doubleValue];
            
            CLLocation *coordinates = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude]; //send message 'coordinate' to get the CLLocation2D blublub.
            
            [self.positions addObject:coordinates];
            
        }
        
    }
    
    return self;
    
}

- (BOOL)isFree {
    
    return [self.paymentOptions count] == 0;
    
}

- (BOOL)acceptsCard {
    
    //loop through the array paymentOptions, if it finds an object containing LKPaymentOptionCard the place accepts card.
    return NO;
    
}

- (BOOL)acceptsFutural {
    
    //look at acceptsCard
    return NO;
    
}

- (BOOL)acceptsPhone {
    
    //look at acceptsCard
    return NO;
    
}

- (CLLocationCoordinate2D)position {
    
    //as for now.
    _position = [[_positions firstObject] coordinate];
    return _position;
    
}

- (UIImage *)coverImage {
    
    UIImage *cover = [UIImage imageNamed:[NSString stringWithFormat:@"cover-%@", self.identifier]];
    
    if(cover) {
        
        return cover;
        
    } else {
        
        return [UIImage imageNamed:@"cover-unknown"];
        
    }
    
}

- (UIImage *)imageForPlace {
    
    UIImage *identifierImage = [self.class imageForIdentifier:self.identifier];
    
    if(identifierImage) {
        
        return identifierImage;
        
    } else { //fallback if no specific image/logotype.
        
        return [self.class imageForCategory:self.category];
        
    }
}

- (UIImage *)imageForAnnotation {
    
    return [self imageForPlace];
    
}

#pragma mark Lazy Instantiation

- (NSMutableArray *)paymentOptions {
    
    if(!_paymentOptions) {
        
        _paymentOptions = [[NSMutableArray alloc] init];
        
    }
    
    return _paymentOptions;
    
}

- (NSMutableArray *)positions {
    
    if(!_positions) {
        
        _positions = [[NSMutableArray alloc] init];
        
    }
    
    return _positions;
    
}

#pragma mark Misc

- (NSString *)description {
    
    return [NSString stringWithFormat:@"This is %@ and I'm located at %d places, our payment options are %@", self.name, [self.positions count], self.paymentOptions];
    
}

#pragma mark Class methods

+ (UIImage *)imageForIdentifier:(NSString *)identifier {
    
    return [UIImage imageNamed:identifier];
    
}

+ (UIImage *)imageForCategory:(LKPlaceCategory)category {
 
    NSString *imageName;
    
    switch(category) {
            
        case LKPlaceCategoryATM:
            
            break;
            
        case LKPlaceCategoryBeverage:
            
            break;
            
        case LKPlaceCategoryChargingStation:
            
            break;
            
        case LKPlaceCategoryCoffee:
            
            break;
            
        case LKPlaceCategoryFirstAid:
            
            break;
            
        case LKPlaceCategoryFood:
            
            imageName = @"hamburger-drink";
            
            break;
            
        case LKPlaceCategoryLottery:
            
            break;
            
        case LKPlaceCategoryMinorEntertainment:
            
            break;
            
        case LKPlaceCategoryParking:
            
            break;
            
        case LKPlaceCategoryScene:
            
            imageName = @"showen";
            
            break;
            
        case LKPlaceCategoryShop:
            
            break;
            
        case LKPlaceCategorySnacks:
            
            break;
            
        case LKPlaceCategoryTent:
            
            break;
            
        case LKPlaceCategoryToilet:
            
            break;
            
        default:
            
            imageName = @"unknown";
            
            break;
            
    }
    
    return [UIImage imageNamed:imageName];
    
}

@end

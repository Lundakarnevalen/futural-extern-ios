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
        
        self.name = propertyList[@"name"];
        self.information = propertyList[@"description"];
        self.category = [propertyList[@"category"] integerValue];
        self.alcohol = [propertyList[@"alcohol"] boolValue];
        
        for(NSString *option in propertyList[@"payment_options"]) {
            
            NSNumber *paymentOption = [NSNumber numberWithInteger:[option integerValue]];
            [self.paymentOptions addObject:paymentOption];
            
        }
        
        if(propertyList[@"position"]) {
            
            NSDictionary *position = propertyList[@"position"];
            
            CLLocationCoordinate2D coordinates;
            coordinates.latitude = [position[@"latitude"] floatValue];
            coordinates.longitude = [position[@"longitude"] floatValue];
            
            self.position = coordinates;
            
        }
        
        NSArray *positions = propertyList[@"positions"];
        
        for(NSDictionary *position in positions) {
            
            NSString *name = position[@"name"];
            
            LKPlace *subPlace = [[LKPlace alloc] initWithProperties:position];
            subPlace.parent = self;

            if(!name) {
                
                subPlace.name = self.name; //fallback to category if no name is set.
                
            }
            
            [self.subPlaces addObject:subPlace];
            
        }
        
    }
    
    return self;
    
}

- (BOOL)isFree {
    
    return [self.paymentOptions count] == 0;
    
}

- (BOOL)acceptsCard {
    
    for(NSNumber *paymentContainer in self.paymentOptions) {
        
        if([paymentContainer integerValue] == LKPaymentOptionCard) {
            
            return YES;
            
        }
        
    }
    
    return NO;
    
}

- (BOOL)acceptsCash {
    
    for(NSNumber *paymentContainer in self.paymentOptions) {
        
        if([paymentContainer integerValue] == LKPaymentOptionCash) {
            
            return YES;
            
        }
        
    }
    
    return NO;
    
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
    UIImage *parentImage = [self.parent imageForPlace];
    
    if(identifierImage) {
        
        return identifierImage;
        
    } else if (parentImage) {
        
        return parentImage;
        
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

- (NSMutableArray *)subPlaces {
    
    if(!_subPlaces) {
        
        _subPlaces = [[NSMutableArray alloc] init];
        
    }
    
    return _subPlaces;
    
}

#pragma mark Misc

- (NSString *)description {
    
    return [NSString stringWithFormat:@"This is %@ and I'm located at %lu places, our payment options are %@", self.name, (unsigned long)[self.subPlaces count], self.paymentOptions];
    
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
            
        default:
            
            //imageName = @"unknown";
            
            break;
            
    }
    
    return [UIImage imageNamed:imageName];
    
}

@end

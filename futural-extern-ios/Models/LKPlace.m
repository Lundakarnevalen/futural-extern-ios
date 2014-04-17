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
        self.description = propertyList[@"description"];
        self.category = [propertyList[@"category"] integerValue];
        self.alcohol = [propertyList[@"alcohol"] boolValue];
        
        for(NSString *option in propertyList[@"payment_options"]) {
            
            NSNumber *paymentOption = [NSNumber numberWithInteger:[option integerValue]];
            [self.paymentOptions addObject:paymentOption];
            
        }
        
        NSDictionary *position = propertyList[@"position"];
        CLLocationDegrees latitude = [position[@"latitude"] doubleValue];
        CLLocationDegrees longitude = [position[@"longitude"] doubleValue];
        
        self.position = CLLocationCoordinate2DMake(latitude, longitude);
        
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

#pragma mark Lazy Instantiation

- (NSMutableArray *)paymentOptions {
    
    if(!_paymentOptions) {
        
        _paymentOptions = [[NSMutableArray alloc] init];
        
    }
    
    return _paymentOptions;
    
}

#pragma mark Misc

- (NSString *)description {
    
    return [NSString stringWithFormat:@"This is %@ and I'm located at %f&%f, our payment options are %@", self.name, self.position.latitude, self.position.longitude, self.paymentOptions];
    
}

@end

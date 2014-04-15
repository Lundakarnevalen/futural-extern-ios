//
//  LKPlace.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import "LKPlace.h"

@implementation LKPlace

- (LKPlace *)initWithProperties:(NSDictionary *)propertyList {
    
    self = [super init];
    
    if(self) {
        
        //create logic to read from a property list and store it in this model
        
    }
    
    return self;
    
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

@end

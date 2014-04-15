//
//  LKPlace.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

typedef enum {
    
    LKPaymentOptionCard = 1,
    LKPaymentOptionPhone = 2,
    LKPaymentOptionFutural = 3
    
} LKPaymentOption;

typedef enum {
    
    LKPlaceIdentifierFood = 1,
    LKPlaceIdentifierIceCream = 2,
    LKPlaceIdentifierBeverage = 3,
    LKPlaceIdentifierSnacks = 4
    
} LKPlaceIdentifier;

@interface LKPlace : NSObject

@property (nonatomic) LKPlaceIdentifier *identifier;
@property (nonatomic) CLLocationDegrees *position;

@property (nonatomic, getter = isSellingAlcohol) BOOL alcohol; //selling alcoholic beverages?
@property (nonatomic, getter = isFree) BOOL free; //entrance free, etc?
@property (nonatomic) NSMutableArray *paymentOptions; //of LKPaymentOption. what kind of payments are available (card, phone, futural)

@end

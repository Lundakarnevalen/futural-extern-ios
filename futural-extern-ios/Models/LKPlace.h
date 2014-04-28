//
//  LKPlace.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

#import "LKSubPlace.h"

typedef enum {
    
    LKPaymentOptionCard = 1,
    LKPaymentOptionPhone = 2,
    LKPaymentOptionFutural = 3,
    LKPaymentOptionCash = 4
    
} LKPaymentOption;

typedef enum {
    
    LKPlaceCategoryFood = 1,
    LKPlaceCategoryBeverage = 2,
    LKPlaceCategorySnacks = 3,
    LKPlaceCategoryTent = 4,
    LKPlaceCategoryToilet = 5,
    LKPlaceCategoryFirstAid = 6,
    LKPlaceCategoryChargingStation = 7,
    LKPlaceCategoryScene = 8,
    LKPlaceCategoryShop = 9,
    LKPlaceCategoryLottery = 10,
    LKPlaceCategoryMinorEntertainment = 11,
    LKPlaceCategoryCoffee = 12,
    LKPlaceCategoryParking = 13,
    LKPlaceCategoryATM = 14,
    LKPlaceCategoryTrash = 15,
    LKPlaceCategoryPolice = 16,
    LKPlaceCategoryFireEscape = 17,
    LKPlaceCategoryRadio = 18,
    LKPlaceCategoryEntrance = 19,
    LKPlaceCategoryShow = 20,
    LKPlaceCategoryTickets = 21,
    LKPlaceCategoryEntertainment = 22
    
} LKPlaceCategory;

@interface LKPlace : NSObject

@property (nonatomic) NSString *identifier; //has to be different from the other places.
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *information;
@property (nonatomic) UIImage *image;
@property (nonatomic) UIImage *annotationImage;

@property (nonatomic) LKPlaceCategory category;
@property (nonatomic) CLLocationCoordinate2D position;
@property (nonatomic) NSMutableArray *subPlaces; //of LKSubPlace

@property (nonatomic, getter = isSellingAlcohol) BOOL alcohol; //selling alcoholic beverages?
@property (nonatomic) NSMutableArray *paymentOptions; //of LKPaymentOption. what kind of payments are available (card, phone, futural). IF THE ARRAY IS EMPTY, IT'S FOR FREE.

- (LKPlace *)initWithProperties:(NSDictionary *)propertyList;

- (UIImage *)image;
- (UIImage *)imageForAnnotation;
+ (UIImage *)imageForCategory:(LKPlaceCategory)category;
- (UIImage *)imageForPlace;
- (UIImage *)coverImage;

@end

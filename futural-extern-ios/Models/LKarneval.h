//
//  LKarneval.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

#import "LKPlace.h"
#import "LKEvent.h"

@interface LKarneval : NSObject

@property (nonatomic) NSMutableArray *places;
@property (nonatomic) NSMutableArray *events;

@property (nonatomic) NSDictionary *openingHours;

extern const int NumberOfFilters;

+ (LKarneval *)sharedLKarneval; //USE THIS, it's stuffed with data about the karneval.

//filter places, the filters will look like @[@(LKPlaceCategory), @(LKPlaceCategory)];
- (NSArray *)placesExcludedByCategories:(NSArray *)categories;
- (NSArray *)placesFilteredByCategories:(NSArray *)categories;

- (NSArray *)eventsAtPlaceWithIdentifier:(NSString *)identifier; //get events associated with a place.
- (NSArray *)favoriteEvents;
- (NSArray *)upcomingEvents;

+ (NSArray *)LKPlaceFilterFood;
+ (NSArray *)LKPlaceFilterEntertainment;
+ (NSArray *)LKPlaceFilterOther;

@end

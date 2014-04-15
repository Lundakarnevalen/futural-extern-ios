//
//  LKEvent.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

#import "LKSektion.h"
#import "LKPlace.h"

@interface LKEvent : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description; //description of the event.
@property (nonatomic) LKPlace *place; //where the event is located.

@property (nonatomic) NSDate *date;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) LKSektion *host; //the sektion that is hosting the event.

@property (nonatomic, getter = isCancelled) BOOL cancelled; //if the event is cancelled.
@property (nonatomic) NSString *reason; //a message telling the user why it's cancelled.

@property (nonatomic, getter = isFavorite) BOOL favorite; //if the user set the event as a favorite.



- (LKEvent *)initWithProperties:(NSDictionary *)propertyList; //instantiate class with property data.

- (BOOL)isOver; //check if the event has already taken place.
- (NSInteger)secondsLeft; //calculate how many seconds until the event is taking place (for use with push messages).
- (NSString *)timeLeft; //return the time left until launch date, thought that we could use the following format dd:hh:mm (for use with views)

@end

//
//  LKEvent.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@interface LKEvent : NSObject

@property (nonatomic) NSString *identifier; //does not have to be unique, but this is the string that connects the event to an image.

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *information; //description of the event.
@property (nonatomic) LKPlace *place; //where the event is located.
@property (nonatomic) UILocalNotification *notification; //grabbed from appdelegate if it's there, otherwise, new instance with data.

@property (nonatomic) NSDate *start;
@property (nonatomic) NSDate *end;

@property (nonatomic, getter = isFavorite) BOOL favorite; //if the user set the event as a favorite.



- (LKEvent *)initWithProperties:(NSDictionary *)propertyList; //instantiate class with property data.

- (BOOL)isOver; //check if the event has already taken place.
- (NSString *)timeLeft; //return the time left until launch date, thought that we could use the following format dd:hh:mm (for use with views)

- (NSString *)formattedStartTimeWithWeekday;
//the following are in HH:mm format.
- (NSString *)formattedStartTime;
- (NSString *)formattedEndTime;

//if there's no event image, it will grab the LKPlace image instead.
- (UIImage *)imageForEvent;
- (UIImage *)coverImage;

@end

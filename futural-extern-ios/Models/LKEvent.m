//
//  LKEvent.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKEvent.h"

@implementation LKEvent

@synthesize favorite = _favorite;

- (LKEvent *)initWithProperties:(NSDictionary *)propertyList {
    
    self = [super init];
    
    if(self) {
        
        self.identifier = propertyList[@"identifier"];
        self.name = propertyList[@"name"];
        self.information = propertyList[@"description"];
        
        NSDictionary *dates = propertyList[@"date"];
        self.start = [dates objectForKey:@"start"];
        self.end = [dates objectForKey:@"end"];
        
    }
    
    return self;
    
}

- (BOOL)isOver {
    
    NSDate *today = [NSDate date];
    return [[today laterDate:self.end] isEqualToDate:today];
    
}

- (BOOL)isFavorite {
    
    _favorite = (BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:[self dataIdentifier]];
    
    return _favorite;
    
}

- (void)setFavorite:(BOOL)favorite {
    
    _favorite = favorite;
    [[NSUserDefaults standardUserDefaults] setBool:favorite forKey:[self dataIdentifier]];
    [[NSUserDefaults standardUserDefaults] synchronize]; //important, or there may be some slight delays.
    
}

- (NSString *)dataIdentifier { //the identifier that connects this event to the event in the database.
    
    NSString *identifier = [NSString stringWithFormat:@"%@ %@:%@", [self.name lowercaseString], [self formattedStartTime], [self formattedEndTime]];
    
    return identifier;
    
}

- (NSString *)timeLeft {
    
    //return the time left until launch date, thought that we could use the following format dd:hh:mm (for use with views)
    return @"dd:hh:mm";
    
}

- (void)enableNotification {

#warning not done.
    NSString *message = [NSString stringWithFormat:@"%@ börjar om 15 min vid %@.", self.name, self.place.name];
    NSDate *firingDate = [self.start dateByAddingTimeInterval:-60*15];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = firingDate;
    localNotification.alertBody = message;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

- (NSString *)formattedStartTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    return [dateFormatter stringFromDate:self.start];
    
}

- (NSString *)formattedEndTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    return [dateFormatter stringFromDate:self.end];
    
}

- (NSString *)formattedStartTimeWithWeekday {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    return [dateFormatter stringFromDate:self.end];
    
}

- (UIImage *)imageForEvent {
    
    UIImage *eventImage = [UIImage imageNamed:self.identifier];
    
    if(!eventImage) {
        
        return [LKPlace imageForCategory:self.place.category];
        
    }
    
    return eventImage;
    
}

- (UIImage *)coverImage {
    
    UIImage *coverImage = [UIImage imageNamed:[NSString stringWithFormat:@"cover-%@", self.identifier]];
    
    if(!coverImage) {
        
        //fallback to place.
        return [self.place coverImage];
        
    }
    
    return coverImage;
    
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"This event called %@ is taking place at %@", self.name, self.place.name];
    
}

#pragma mark Lazy Instantiation

- (LKPlace *)place {
    
    if(!_place) {
        
        _place = [[LKPlace alloc] init];
        
    }
    
    return _place;
    
}

- (UILocalNotification *)notification {
    
    if(!_notification) {
        
#warning not done.
//        UIApplication *app = [UIApplication sharedApplication];
//        NSArray *eventArray = [app scheduledLocalNotifications];
//        for (int i=0; i<[eventArray count]; i++)
//        {
//            UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
//            NSDictionary *userInfoCurrent = oneEvent.userInfo;
//            NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"uid"]];
//            if ([uid isEqualToString:uidtodelete])
//            {
//                //Cancelling local notification
//                [app cancelLocalNotification:oneEvent];
//                break;
//            }
//        }
        
    }
    
    return _notification;
    
}

@end

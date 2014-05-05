//
//  LKEvent.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKEvent.h"

@interface LKEvent() { }

@property (nonatomic) NSInteger minutesBeforeEvent;

@end

@implementation LKEvent

@synthesize favorite = _favorite;

- (LKEvent *)initWithProperties:(NSDictionary *)propertyList {
    
    self = [super init];
    
    if(self) {
        
        self.minutesBeforeEvent = 15; //change this if necessary.
        
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
    
    if(_favorite) {
        [self enableNotification];
    } else {
        [self disableNotification];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:favorite forKey:[self dataIdentifier]];
    [[NSUserDefaults standardUserDefaults] synchronize]; //important, or there may be some slight delays.
    
}

- (NSString *)dataIdentifier { //the identifier that connects this event to the event in the database.
    
    NSString *identifier = [NSString stringWithFormat:@"%@ %@:%@", [self.name lowercaseString], self.start, self.end];
    
    return identifier;
    
}

- (void)disableNotification {
    
    NSLog(@"Disabling %@", [self dataIdentifier]);
    [[UIApplication sharedApplication] cancelLocalNotification:self.notification];
    
}

- (void)enableNotification {
    
    NSLog(@"Enabling %@", [self dataIdentifier]);
    [[UIApplication sharedApplication] scheduleLocalNotification:self.notification];

    
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
        
        NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
        
        NSLog(@"Looking for %@", [self dataIdentifier]);
        
        for(UILocalNotification *notification in notifications) {
            
            NSDictionary *information = notification.userInfo;
            NSString *identifier = [information valueForKey:@"identifier"];
            
            if ([identifier isEqualToString:[self dataIdentifier]]) {
                
                _notification = notification;
                break;
                
            }
            
        }
        
        if(!_notification) { //not there.
            
            NSLog(@"Did not find %@", [self dataIdentifier]);
            
            NSString *message = [NSString stringWithFormat:@"%@ börjar om %d min vid %@.", self.name, self.minutesBeforeEvent, self.place.name];
            NSDate *firingDate = [self.start dateByAddingTimeInterval:-60 * self.minutesBeforeEvent];
            
            UILocalNotification* notification = [[UILocalNotification alloc] init];
            notification.fireDate = firingDate;
            notification.alertBody = message;
            notification.userInfo = @{ @"identifier" : [self dataIdentifier] };
            notification.timeZone = [NSTimeZone defaultTimeZone];
            
            _notification = notification;
            
        }
        
    }
    
    return _notification;
    
}

@end

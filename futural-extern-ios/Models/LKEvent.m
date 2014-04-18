//
//  LKEvent.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKEvent.h"

@implementation LKEvent

- (LKEvent *)initWithProperties:(NSDictionary *)propertyList {
    
    self = [super init];
    
    if(self) {
        
        self.identifier = propertyList[@"identifier"];
        self.name = propertyList[@"name"];
        self.description = propertyList[@"description"];
        
        NSDictionary *dates = propertyList[@"date"];
        self.start = [dates objectForKey:@"start"];
        self.end = [dates objectForKey:@"end"];
        
        //add logic to read a property list containing all the information about the event.
        
    }
    
    return self;
    
}

- (BOOL)isOver {
    
    //check if the event has already taken place.
    return NO;
    
}

- (NSInteger)secondsLeft {
    
    //calculate how many seconds until the event is taking place (for use with push messages).
    return 3600;
    
}

- (NSString *)timeLeft {
    
    //return the time left until launch date, thought that we could use the following format dd:hh:mm (for use with views)
    return @"dd:hh:mm";
    
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

- (UIImage *)imageForEvent {
    
    UIImage *eventImage = [UIImage imageNamed:self.identifier];
    
    if(!eventImage) {
        
        return [LKPlace imageForCategory:self.place.category];
        
    }
    
    return eventImage;
    
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

@end

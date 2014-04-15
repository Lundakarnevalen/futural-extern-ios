//
//  LKEvent.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import "LKEvent.h"

@implementation LKEvent

- (LKEvent *)initWithProperties:(NSDictionary *)propertyList {
    
    self = [super init];
    
    if(self) {
        
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

#pragma mark Lazy Instantiation

- (LKPlace *)place {
    
    if(!_place) {
        
        _place = [[LKPlace alloc] init];
        
    }
    
    return _place;
    
}

- (LKSektion *)host {
    
    if(!_host) {
        
        _host = [[LKSektion alloc] init]; //fix to get the right data.
        
    }
    
    return _host;
    
}

@end

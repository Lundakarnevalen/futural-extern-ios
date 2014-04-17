//
//  LKarneval.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKarneval.h"

#define PLIST_PLACES "Places"
#define PLIST_EVENTS "Events"

@implementation LKarneval

#pragma mark Singleton

+ (LKarneval *)sharedLKarneval {
    
    static LKarneval *sharedLKarneval;
    
    @synchronized(self) { //low level thread stuff, don't bother.
        
        if(!sharedLKarneval) {
            
            sharedLKarneval = [[LKarneval alloc] init];
            
        }
        
        return sharedLKarneval;
        
    }
    
}

#pragma mark Designated initializer

- (LKarneval *)init {
    
    self = [super init];
    
    if(self) {
        
        //load events, places and store it in specific arrays.
        
    }
    
    return self;
    
}

#pragma mark Lazy Instantiation

- (NSDictionary *)openingHours {
    
    if(!_openingHours) {
        
        NSLog(@"%@: reading opening hours..", self.class);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"OpeningHours" ofType:@"plist"];
        _openingHours = [NSDictionary dictionaryWithContentsOfFile:path];
        
    }
    
    return _openingHours;
    
}

- (NSMutableArray *)places {
    
    if(!_places) {
        
        _places = [[NSMutableArray alloc] init];
        
        NSLog(@"%@: reading places..", self.class);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Places" ofType:@"plist"];
        NSDictionary *places = [NSDictionary dictionaryWithContentsOfFile:path];
        
        for(NSString *identifier in places) {
            
            LKPlace *place = [[LKPlace alloc] initWithProperties:places[identifier]];
            place.identifier = identifier;
            
            NSLog(@"%@", place);
            
            [_places addObject:place];
            
        }
        
    }
    
    return _places;
    
}

- (NSMutableArray *)events {
    
    if(!_events) {
        
        _events = [[NSMutableArray alloc] init];
        
        NSLog(@"%@: reading events..", self.class);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
        NSArray *events = [NSArray arrayWithContentsOfFile:path];
        
        for(NSDictionary *eventProperties in events) {
            
            LKEvent *event = [[LKEvent alloc] initWithProperties:eventProperties];
            //add place object as well.
            
            [_events addObject:event];
            
        }
        
    }
    
    return _events;
    
}

#pragma mark Misc

- (NSString *)description {
    
    return [NSString stringWithFormat:@"This is %@ and we're opening at %@, at the moment we have %d events and %d places to see.", self.class, self.openingHours, [self.places count], [self.events count]];
    
}

@end

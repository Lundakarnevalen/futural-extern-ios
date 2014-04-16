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
        NSLog(@"Hello world");
        
    }
    
    return self;
    
}

#pragma mark Lazy Instantiation

- (NSDictionary *)openingHours {
    
    if(_openingHours) {
        
        _openingHours = @{}; //store in plist
        
    }
    
    return _openingHours;
    
}

@end

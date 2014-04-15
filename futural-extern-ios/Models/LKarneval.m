//
//  LKarneval.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import "LKarneval.h"

@implementation LKarneval

- (LKarneval *)init {
    
    self = [super init];
    
    if(self) {
        
        //load events, places and store it in specific arrays.
        
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

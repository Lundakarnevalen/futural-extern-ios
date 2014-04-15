//
//  LKarneval.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import "LKarneval.h"

@implementation LKarneval

#pragma mark Lazy Instantiation

- (NSDictionary *)openingHours {
    
    if(_openingHours) {
        
        _openingHours = @{
                          @"2014-05-16" : @{
                                  @"open" : @"09:00",
                                  @"close" : @"21:00"
                                  },
                          @"2014-05-17" : @{
                                  @"open" : @"09:00",
                                  @"close" : @"21:00"
                                  },
                          @"2014-05-18" : @{
                                  @"open" : @"09:00",
                                  @"close" : @"21:00"
                                  },
                          }; //store in plist 
        
    }
    
    return _openingHours;
    
}

@end

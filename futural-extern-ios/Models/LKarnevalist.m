//
//  LKarnevalist.m
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKarnevalist.h"

@implementation LKarnevalist

- (LKarnevalist *)initWithProperties:(NSDictionary *)propertyList {
    
    self = [super init];
    
    if(self) {
        
        //create logic to read from a property list and store it in this model
        
    }
    
    return self;
    
}

- (NSURL *)phoneURL {
    
    //return the url below with appended phone number. TIP:http://stackoverflow.com/questions/6323171/making-a-phone-call-in-an-ios-application
    return [NSURL URLWithString:@"telprompt://"];
    
}

- (NSArray *)tweets {
    
    //use twitter API to fetch tweets with certain hash-tag.
    return @[@"tweets from the karnevalist"];
    
}

@end

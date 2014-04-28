//
//  LKSubPlace.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-28.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKSubPlace.h"

@implementation LKSubPlace

- (instancetype)initWithName:(NSString *)name andPosition:(CLLocation *)position {
    
    self = [super init];
    
    if(self) {
        
        self.name = name;
        self.position = position;
        
    }
    
    return self;
    
}

@end

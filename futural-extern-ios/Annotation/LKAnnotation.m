//
//  LKAnnotation.m
//  Lundakarneval
//
//  Created by Richard Luong on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKAnnotation.h"

@implementation LKAnnotation

@synthesize title;
@synthesize coordinate;

//designated init
-(instancetype)initWithPlace:(LKPlace *)place andPositionIndexOf:(NSInteger)positionIndex {
    
    self = [super init];
    
    if (self) {
        
        LKPlace *subPlace = [place.subPlaces objectAtIndex:positionIndex];
        
        self.place = subPlace;
        coordinate = subPlace.position;
        title = [subPlace.name uppercaseString];
        self.image = [place imageForAnnotation];
        
    }
    
    return self;
    
}

- (instancetype)initWithPlace:(LKPlace *)place {
    
    self = [super init];
    
    if(self) {
    
    self.place = place;
    coordinate = place.position;
    title = [place.name uppercaseString];
    self.image = [place imageForAnnotation];
        
    }
    
    return self;
    
}

@end

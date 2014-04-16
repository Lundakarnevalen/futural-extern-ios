//
//  LKarneval.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKarneval : NSObject

@property (nonatomic) NSMutableArray *places;
@property (nonatomic) NSMutableArray *events;

@property (nonatomic) NSDictionary *openingHours;

+ (LKarneval *)sharedLKarneval; //USE THIS, it's stuffed with data about the karneval.

@end

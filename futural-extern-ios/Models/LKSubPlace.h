//
//  LKSubPlace.h
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-28.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKSubPlace : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) CLLocation *position;

- (instancetype)initWithName:(NSString *)name andPosition:(CLLocation *)position; //designated initializer

@end

//
//  LKSektion.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKSektion : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;

@property (nonatomic) NSArray *generals; //of LKarnevalist. (sektions-chefer)

@end

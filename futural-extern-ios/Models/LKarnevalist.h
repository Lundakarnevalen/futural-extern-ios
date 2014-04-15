//
//  LKarnevalist.h
//  futural-extern-ios
//
//  Created by Victor Ingman on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKarnevalist : NSObject

@property (nonatomic) NSString *firstname;
@property (nonatomic) NSString *lastname;
@property (nonatomic) NSString *title;

@property (nonatomic) NSString *phoneNumber; //possibility to call. (maybe)
@property (nonatomic) NSString *email; //possibility to mail.
@property (nonatomic) NSString *twitter; //possibility to fetch tweets from the karnevalist.

@property (nonatomic) NSURL *photoURL;


- (NSURL *)phoneURL; //returns url formatted for a phone call.

@end

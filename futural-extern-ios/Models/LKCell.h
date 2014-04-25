//
//  LKCell.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKCell : NSObject

@property (nonatomic) CGPoint position;
@property (nonatomic) CGSize size;

- (LKCell *)initWithRadius:(NSInteger)radius;

@end

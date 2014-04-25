//
//  LKCell.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKCell.h"

@implementation LKCell

- (LKCell *)initWithRadius:(NSInteger)radius {
    
    self = [super init];
    
    if(self) {
        
        self.size = CGSizeMake(radius, radius);
        
    }
    
    return self;
    
}

@end

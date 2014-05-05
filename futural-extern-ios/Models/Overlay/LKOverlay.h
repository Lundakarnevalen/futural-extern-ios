//
//  LKOverlay.h
//  Lundakarnevalen
//
//  Created by Richard Luong on 2014-04-17.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LKOverlay : NSObject <MKOverlay>

- (instancetype)initWithImage:(UIImage *)image;

@property (nonatomic, strong) UIImage *image;

@end

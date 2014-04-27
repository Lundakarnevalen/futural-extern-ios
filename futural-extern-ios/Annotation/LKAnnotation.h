//
//  LKAnnotation.h
//  Lundakarneval
//
//  Created by Richard Luong on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LKAnnotation : NSObject <MKAnnotation>

-(instancetype)initWithPlace:(LKPlace *)place andPositionIndexOf:(NSInteger)positionIndex; //as we are now having multiple positions per place.

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;

@end

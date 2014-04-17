//
//  EntertainmentDetailViewController.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-17.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntertainmentDetailViewController : UIViewController

@property (nonatomic) LKarneval *karneval;
@property (nonatomic) LKPlace *place; //the place that is being requested.

@end

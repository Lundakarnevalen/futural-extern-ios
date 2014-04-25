//
//  FoodViewController.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKButton.h"
#import "LKColor.h"
#import "LKGrid.h"
#import "LKLayout.h"

@interface FoodViewController : UIViewController

@property (nonatomic) LKGrid *grid;
@property (nonatomic) LKarneval *karneval;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

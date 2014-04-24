//
//  MiscellaneousViewController.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKGrid.h"
#import "LKButton.h"
#import "LKColor.h"

@interface MiscellaneousViewController : UIViewController

@property (nonatomic) LKGrid *grid;
@property (nonatomic) LKarneval *karneval;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

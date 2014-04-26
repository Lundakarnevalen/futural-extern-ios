//
//  FoodDetailViewController.h
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-26.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKImage.h"

@interface FoodDetailViewController : UIViewController

@property (nonatomic) LKPlace *place; //the place being shown.

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet LKImage *logotypeImage;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *subHeaderLabel;

@end

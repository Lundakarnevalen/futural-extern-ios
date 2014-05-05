//
//  OvumSecretaViewController.h
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-05-05.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKImage.h"

@interface OvumSecretaViewController : UIViewController


@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *blockViews;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

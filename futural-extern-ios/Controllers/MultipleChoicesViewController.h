//
//  MultipleChoicesViewController.h
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-29.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKLayout.h"

@interface MultipleChoicesViewController : UIViewController

@property (nonatomic) LKGrid *grid;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//set these when segue'ing.
@property (nonatomic) NSString *parentName;
@property (nonatomic) NSMutableArray *choices;
@property (nonatomic) UIColor *strokeColor;
@property (nonatomic) UIImage *desiredBackgroundImage;
@property (nonatomic) UIImage *logotype;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

//
//  LKButton.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKButton : UIButton

@property (nonatomic) UIImage *backgroundImage;

- (void)drawCircleButton:(UIColor *)color;

@end

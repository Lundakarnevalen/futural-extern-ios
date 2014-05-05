//
//  LKButton.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKButton : UIButton

@property (nonatomic) NSString *identifier;
@property (nonatomic) UIImage *backgroundImage;
@property (nonatomic) UIColor *strokeColor;

- (void)drawCircleButton:(UIColor *)color withStrokeWidth:(NSInteger)strokeWidth;

@end

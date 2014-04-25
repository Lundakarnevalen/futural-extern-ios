//
//  LKLayout.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-25.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKLayout.h"

@implementation LKLayout

+ (UIFont *)gridFont {
    
    return [UIFont fontWithName:@"Futura-Bold" size:[self gridFontSize]];
    
}

+ (NSInteger)gridFontSize {
    
    return 12;
    
}

+ (float)gridCellRadius {
    
    return 80.0;
    
}

+ (NSInteger)gridCellStrokeWidth {
    
    return 5;
    
}

+ (LKButton *)buttonForCell:(LKCell *)cell withStrokeColor:(UIColor *)strokeColor andImage:(UIImage *)image {
    
    LKButton *button = [[LKButton alloc] init];
    
    CGPoint position;
    position.x = cell.position.x;
    position.y = cell.position.y;
    
    CGSize size;
    size.width = cell.size.width;
    size.height = cell.size.height;
    
    CGRect frame;
    frame.origin = position;
    frame.size = size;
    
    button.frame = frame;

    [button setBackgroundImage:image];
    
    [button drawCircleButton:strokeColor withStrokeWidth:[self gridCellStrokeWidth]];
    
    return button;
    
}

+ (UILabel *)titleLabelForCell:(LKCell *)cell withTitle:(NSString *)title {
    
    float scale = 1.5; //scale in relation to the cell size (change this if unalligned).
    float scaledWidth = [self gridCellRadius] * scale;
    float widthAdded = scaledWidth - (scaledWidth / scale);
    
    CGSize titleSize;
    titleSize.width = scaledWidth;
    titleSize.height = [self gridFontSize];
    
    CGPoint titlePosition;
    titlePosition.x = cell.position.x - (widthAdded / 2);
    titlePosition.y = cell.position.y + ([self gridCellRadius] / 0.9);
    
    CGRect titleFrame;
    titleFrame.origin = titlePosition;
    titleFrame.size = titleSize;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.font = [UIFont fontWithName:@"Futura-Bold" size:[self gridFontSize]];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [title uppercaseString];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    
    return titleLabel;
    
}

@end

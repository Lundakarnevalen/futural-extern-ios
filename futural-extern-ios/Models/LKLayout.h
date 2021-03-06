//
//  LKLayout.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-25.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LKGrid.h"
#import "LKButton.h"

@interface LKLayout : NSObject

+ (NSString *)futuraFontName;
+ (UIFont *)gridFont;
+ (NSInteger)gridFontSize;
+ (NSInteger)gridCellStrokeWidth;
+ (UIFont *)detailHeaderFont;
+ (UIFont *)detailSubHeaderFont;
+ (UIFont *)detailMapHeaderFont;
+ (NSString *)defaultTitle;
+ (UIFont *)detailPaymentFont;
+ (UIFont *)informationHeaderFont;
+ (UIFont *)fontForTableHeader;
+ (UIFont *)ovumSecretaHeader;

+ (void)addShadowToView:(UIView *)view ofSize:(NSInteger)shadowSize;
+ (void)addInsetShadowToView:(UIView *)view ofSize:(NSInteger)shadowSize;
+ (void)addShadowToLabel:(UILabel *)label withSizeOf:(NSInteger)size;
+ (void)customizeSegment:(UISegmentedControl *)segmentControl;

+ (UIImage *)blurImage:(UIImage *)image withRadiusOf:(float)blurRadius;

+ (UILabel *)titleLabelForCell:(LKCell *)cell withTitle:(NSString *)title;
+ (LKButton *)buttonForCell:(LKCell *)cell withStrokeColor:(UIColor *)strokeColor andImage:(UIImage *)image;

@end

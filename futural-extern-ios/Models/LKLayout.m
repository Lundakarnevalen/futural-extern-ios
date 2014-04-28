//
//  LKLayout.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-25.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKLayout.h"

#define SHADOW_SIZE 6.0

@implementation LKLayout

+ (UIFont *)gridFont {
    
    return [UIFont fontWithName:[self futuraFontName] size:[self gridFontSize]];
    
}

+ (NSString *)futuraFontName {
    
    return @"FuturaLT-Bold";
    
}

+ (NSString *)helveticaFontName {
    
    return @"Helvetica-Light";
    
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

+ (UIFont *)detailHeaderFont {
    
    return [UIFont fontWithName:[self futuraFontName] size:36];
    
}

+ (UIFont *)detailMapHeaderFont {
    
    return [UIFont fontWithName:[self futuraFontName] size:10];
    
}

+ (UIFont *)informationHeaderFont {
    
    return [UIFont fontWithName:[self futuraFontName] size:22];
    
}

+ (UIFont *)detailPaymentFont {
    
    return [UIFont fontWithName:[self futuraFontName] size:8];
    
}

+ (UIFont *)detailSubHeaderFont {
    
    return [UIFont fontWithName:[self helveticaFontName] size:14];
    
}

+ (NSString *)defaultTitle {
    
    return [@"Lundakarnevalen" uppercaseString];
    
}

+ (void)addShadowToLabel:(UILabel *)label withSizeOf:(NSInteger)size {
    
    [label setShadowColor:[UIColor colorWithWhite:0 alpha:0.25]];
    [label setShadowOffset:CGSizeMake(0, size)];
    
}

+ (UIImage *)blurImage:(UIImage *)image withRadiusOf:(float)blurRadius {
    
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:blurRadius] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    // *************** if you need scaling
    // return [[self class] scaleIfNeeded:cgImage];
    
    return returnImage;
    
}

+ (void)addInsetShadowToView:(UIView *)view ofSize:(NSInteger)shadowSize {
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, shadowSize)];
    shadow.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    
    [view addSubview:shadow];
    
}

+ (void)addShadowToView:(UIView *)view ofSize:(NSInteger)shadowSize {
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, view.frame.size.width, shadowSize)];
    shadow.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    
    [view addSubview:shadow];
    
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
    titleLabel.font = [self gridFont];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [title uppercaseString];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    return titleLabel;
    
}

@end

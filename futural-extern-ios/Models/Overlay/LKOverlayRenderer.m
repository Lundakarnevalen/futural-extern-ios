//
//  LKOverlayRenderer.m
//  Lundakarnevalen
//
//  Created by Richard Luong on 2014-04-17.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKOverlayRenderer.h"
#import "LKOverlay.h"

@implementation LKOverlayRenderer

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
    
    UIImage *image = ((LKOverlay *)self.overlay).image;
    CGImageRef imageReference = image.CGImage;
    
    MKMapRect theMapRect = self.overlay.boundingMapRect;
    CGRect theRect = [self rectForMapRect:theMapRect];
    
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -theRect.size.height);
    CGContextDrawImage(context, theRect, imageReference);
}

@end

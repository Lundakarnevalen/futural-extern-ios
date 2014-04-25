//
//  LKGrid.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LKCell.h"

@interface LKGrid : NSObject

@property (nonatomic) NSMutableArray *cells;
@property (nonatomic) CGRect frame;

- (LKGrid *)initWithFrame:(CGRect)frame andGridCells:(NSArray *)cells; //of LKCells

- (CGSize)contentSize;

+ (NSArray *)cellsFromArray:(NSArray *)array;

@end

//
//  LKGrid.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKGrid.h"

#define SPACING_ROW 40
#define COUNT_COLUMNS 2

@implementation LKGrid

- (LKGrid *)initWithFrame:(CGRect)frame andGridCells:(NSArray *)cells {
    
    self = [super init];
    
    if(self) {
        
        self.frame = frame;
        
        NSLog(@"Width: %f, Height: %f", frame.size.width, frame.size.height);
        
        [cells enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
           
            LKCell *cell = (LKCell *)object;
            
            NSInteger cellRadius = (cell.size.width / 2);
            NSInteger columnIndex = (index % COUNT_COLUMNS);
            NSInteger rowIndex = (index / COUNT_COLUMNS);
            NSLog(@"Row:%d, Col:%d", rowIndex, columnIndex);
            
            CGSize spacing;
            spacing.width = (self.frame.size.width / (COUNT_COLUMNS * 2));
            spacing.height = cellRadius + SPACING_ROW;
            NSLog(@"SpacingX:%f, SpacingY:%f", spacing.width, spacing.height);
            
            BOOL zeroIfFirstColumn = (columnIndex != 0); //zero if false, one if true.
            BOOL zeroIfFirstRow = (rowIndex != 0);
            BOOL zeroIfNotFirstRow = (rowIndex == 0);
            
            CGPoint position;
            position.x = spacing.width + (spacing.width * zeroIfFirstColumn * columnIndex) + (spacing.width * columnIndex) - (cell.size.width / 2); //don't bother, it's working though. WOOP!
            position.y = spacing.height + (spacing.height * rowIndex) - (cellRadius * zeroIfNotFirstRow) + (cellRadius * rowIndex * zeroIfFirstRow) - (cellRadius * zeroIfFirstRow);
            NSLog(@"x:%f, y:%f", position.x, position.y);
            
            cell.position = position;
            
            [self.cells addObject:cell];
            
        }];
        
    }
    
    return self;
    
}

- (CGSize)contentSize {
    
    NSInteger height = 0;
    NSInteger rows = (NSInteger) (([self.cells count] / COUNT_COLUMNS) + 0.5);
    
    for(LKCell *cell in self.cells) {
        
        height += (cell.size.height + SPACING_ROW);
        
    }
    
    height /= COUNT_COLUMNS;
    height += SPACING_ROW;
    
    CGSize size;
    size.width = self.frame.size.width;
    size.height = height;
    
    return size;
    
}

- (NSMutableArray *)cells {
    
    if(!_cells) {
        
        _cells = [[NSMutableArray alloc] init];
        
    }
    
    return _cells;
    
}

@end

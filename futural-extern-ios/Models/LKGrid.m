//
//  LKGrid.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "LKGrid.h"

#define SPACING_ROW 40
#define COUNT_COLUMNS 2 //make it dynamic.
#define RADIUS_DEFAULT 80

@implementation LKGrid

- (LKGrid *)initWithFrame:(CGRect)frame andGridCells:(NSArray *)cells {
    
    self = [super init];
    
    if(self) {
        
        self.frame = frame;
        
        [cells enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
           
            LKCell *cell = (LKCell *)object;
            
            NSInteger cellRadius = (cell.size.width / 2);
            NSInteger columnIndex = (index % COUNT_COLUMNS);
            NSInteger rowIndex = (index / COUNT_COLUMNS);
            
            CGSize spacing;
            spacing.width = (self.frame.size.width / (COUNT_COLUMNS * 2));
            spacing.height = cellRadius + SPACING_ROW;
            
            BOOL zeroIfFirstColumn = (columnIndex != 0); //zero if false, one if true.
            BOOL zeroIfFirstRow = (rowIndex != 0);
            BOOL zeroIfNotFirstRow = (rowIndex == 0);
            
            CGPoint position;
            position.x = spacing.width + (spacing.width * zeroIfFirstColumn * columnIndex) + (spacing.width * columnIndex) - (cell.size.width / 2); //don't bother, it's working though. WOOP!
            position.y = spacing.height + (spacing.height * rowIndex) - (cellRadius * zeroIfNotFirstRow) + (cellRadius * rowIndex * zeroIfFirstRow) - (cellRadius * zeroIfFirstRow);
            
            cell.position = position;
            
            [self.cells addObject:cell];
            
        }];
        
    }
    
    return self;
    
}

- (CGSize)contentSize {
    
    float height = 0;
    
    for(NSInteger index = 0; index < [self.cells count]; index++) {
        
        NSInteger modulus = index % COUNT_COLUMNS;
        
        if(modulus == 0) { //once every row.
        
            LKCell *cell = [self.cells objectAtIndex:index];
            height += (cell.size.height + SPACING_ROW);
            
        }
        
    }
    
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

+ (NSArray *)cellsFromArray:(NSArray *)array {
    
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    
    for(NSInteger index = 0; index < [array count]; index++) {
        
        [cells addObject:[[LKCell alloc] initWithRadius:RADIUS_DEFAULT]];
        
    }
    
    return cells;
    
}

@end

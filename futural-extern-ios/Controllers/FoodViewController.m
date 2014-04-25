//
//  FoodViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "FoodViewController.h"

#define RADIUS_DEFAULT 80
#define FONT_SIZE 12

@implementation FoodViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self renderGrid];
    
}

- (NSArray *)foodPlaces {
    
    return [self.karneval placesFilteredByCategories:[LKarneval LKPlaceFilterFood]];
    
}

- (void)renderGrid {
    
    UIColor *strokeColor = [LKColor colorWithIdentifier:LKColorBeige];
    [self.scrollView setContentSize:[self.grid contentSize]];
    
    [self.grid.cells enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
       
        LKCell *cell = (LKCell *)object;
        LKPlace *place = [[self foodPlaces] objectAtIndex:index];
        
        //BUTTON
        LKButton *button = [LKLayout buttonForCell:cell withStrokeColor:strokeColor andImage:[place imageForPlace]];
        
        //LABEL
        UILabel *title = [LKLayout titleLabelForCell:cell withTitle:place.name];
        
        [self.scrollView addSubview:button];
        [self.scrollView addSubview:title];
        
    }];
    
}

- (LKGrid *)grid {
    
    if(!_grid) {
        
        _grid = [[LKGrid alloc] initWithFrame:self.view.frame andGridCells:[LKGrid cellsFromArray:[self foodPlaces]]];
        
    }
    
    return _grid;
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

@end

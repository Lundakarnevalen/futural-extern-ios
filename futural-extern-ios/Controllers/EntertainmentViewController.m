//
//  EntertainmentViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "EntertainmentViewController.h"

#import "LKLayout.h"

@implementation EntertainmentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self renderGrid];
    
}

- (NSArray *)entertainmentPlaces {
    
    return  [self.karneval placesFilteredByCategories:[LKarneval LKPlaceFilterEntertainment]];
    
}

- (void)renderGrid {
    
    [self.scrollView setContentSize:[self.grid contentSize]];
    
    [self.grid.cells enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        
        LKCell *cell = (LKCell *)object;
        LKPlace *place = [self.karneval.places objectAtIndex:index];
        
        LKButton *button = [LKLayout buttonForCell:cell
                                   withStrokeColor:[LKColor colorWithIdentifier:LKColorGreen]
                                          andImage:[place imageForPlace]];
        
        UILabel *title = [LKLayout titleLabelForCell:cell
                                           withTitle:place.name];
        
        [self.scrollView addSubview:button];
        [self.scrollView addSubview:title];
        
    }];
    
}

- (LKGrid *)grid {
    
    if(!_grid) {
        
        _grid = [[LKGrid alloc] initWithFrame:self.view.frame andGridCells:[LKGrid cellsFromArray:[self entertainmentPlaces]]];
        
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

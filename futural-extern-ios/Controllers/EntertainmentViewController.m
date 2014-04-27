//
//  EntertainmentViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "EntertainmentViewController.h"
#import "EntertainmentDetailViewController.h"

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
        LKPlace *place = [[self entertainmentPlaces] objectAtIndex:index];
        
        LKButton *button = [LKLayout buttonForCell:cell
                                   withStrokeColor:[LKColor colorWithIdentifier:LKColorGreen]
                                          andImage:[place imageForPlace]];
        button.tag = index; //identifier
        [button addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *title = [LKLayout titleLabelForCell:cell
                                           withTitle:place.name];
        
        [self.scrollView addSubview:button];
        [self.scrollView addSubview:title];
        
    }];
    
}

- (void)cellClick:(id)sender {
    
    [self performSegueWithIdentifier:@"entertainment.detail" sender:sender];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    LKButton *button = (LKButton *)sender;
    LKPlace *place = [[self entertainmentPlaces] objectAtIndex:button.tag];
    
    EntertainmentDetailViewController *detailVC = [segue destinationViewController];
    detailVC.place = place;
    
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

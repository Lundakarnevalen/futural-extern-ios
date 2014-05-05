//
//  FoodViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "FoodViewController.h"
#import "DetailViewController.h"

#import "LKLayout.h"
#import "LKColor.h"

@implementation FoodViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self renderGrid];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    if(self.visitIdentifier) {
        
        NSLog(@"SHOW ME %@", self.visitIdentifier);
        self.visitPlace = nil;
        
        for(LKPlace *place in [self foodPlaces]) {
            
            if([place.name isEqualToString:self.visitIdentifier]) {
                
                self.visitPlace = place;
                
                [self performSegueWithIdentifier:@"food.detail" sender:self];
                
                break;
                
            }
            
        }
        
        self.visitIdentifier = nil;
        
    }
    
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
        
        LKButton *button = [LKLayout buttonForCell:cell
                                   withStrokeColor:strokeColor
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

    [self performSegueWithIdentifier:@"food.detail" sender:sender];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailViewController *detailVC = [segue destinationViewController];
    detailVC.segueIdentifier = segue.identifier;
    
    if([sender class] == [LKButton class]) {
        
        LKButton *button = (LKButton *)sender;
        LKPlace *place = [[self foodPlaces] objectAtIndex:button.tag];
        
        detailVC.place = place;
        
    } else { //segue via map.
        
        detailVC.place = self.visitPlace;
        
    }
    
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

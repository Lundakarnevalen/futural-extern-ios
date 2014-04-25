//
//  MiscellaneousViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "MiscellaneousViewController.h"

#import "LKLayout.h"

@implementation MiscellaneousViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.hidesBottomBarWhenPushed = NO;
    
    [self renderGrid];

}

- (void)renderGrid {
    
    [self.scrollView setContentSize:[self.grid contentSize]];
    
    [self.grid.cells enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        
        LKCell *cell = (LKCell *)object;
        LKPlace *place = [self.karneval.places objectAtIndex:index];
        
        LKButton *button = [LKLayout buttonForCell:cell
                                   withStrokeColor:[LKColor colorWithIdentifier:LKColorBeige]
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
    
    LKButton *button = (LKButton *)sender;
    
    LKPlace *place = [self.karneval.places objectAtIndex:button.tag];
    NSLog(@"name tapped:%@", place.name);
    
    [self performSegueWithIdentifier:@"misc.detail" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"segue time!");
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

- (LKGrid *)grid {
    
    if(!_grid) {
        
        _grid = [[LKGrid alloc] initWithFrame:self.scrollView.frame andGridCells:[LKGrid cellsFromArray:self.karneval.places]];
        
    }
    
    return _grid;
    
}

@end

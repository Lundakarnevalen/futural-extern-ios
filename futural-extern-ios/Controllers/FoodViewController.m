//
//  FoodViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "FoodViewController.h"

#define RADIUS_DEFAULT 80

@implementation FoodViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self resetScrollView];
    [self renderGrid];
    //[self.circleButton drawCircleButton:[LKColor colorWithIdentifier:LKColorGreen]];
    
}

- (void)resetScrollView { //remove prototypes.
    
    for(UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    
}

- (NSMutableArray *)cells {
    
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    
    for(NSInteger index = 0; index < [self.karneval.events count]; index++) {
        
        LKCell *cell = [[LKCell alloc] initWithRadius:RADIUS_DEFAULT];
        [cells addObject:cell];
        
    }
    
    return cells;
    
}

- (void)renderGrid {
    
    UIColor *strokeColor = [LKColor colorWithIdentifier:LKColorGreen];
    [self.scrollView setContentSize:[self.grid contentSize]];
    
    for(LKCell *cell in self.grid.cells) {
        
        LKButton *button = [[LKButton alloc] init];
        button.frame = CGRectMake(cell.position.x, cell.position.y, cell.size.width, cell.size.height);
        [button drawCircleButton:strokeColor];
        
        [self.scrollView addSubview:button];
        
    }
    
}

- (LKGrid *)grid {
    
    if(!_grid) {
        
        _grid = [[LKGrid alloc] initWithFrame:self.view.frame andGridCells:[self cells]];
        
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

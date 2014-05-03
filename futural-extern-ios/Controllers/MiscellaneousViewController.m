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

- (void)viewDidAppear:(BOOL)animated {
    
    if(self.visitIdentifier) {
        
        NSLog(@"SHOW ME %@", self.visitIdentifier);
        self.visitPlace = nil;
        
        for(LKPlace *place in [self miscPlaces]) {
            
            if([place.name isEqualToString:self.visitIdentifier]) {
                
                //self.visitPlace = place;
                [self performSegueForName:place.name];
                
                //needs to be dynamic.
                
                break;
                
            }
            
        }
        
        self.visitIdentifier = nil;
        
    }
    
}

- (void)performSegueForName:(NSString *)name {
    
    name = [name lowercaseString];
    
    NSLog(@"Segue requested for %@", name);
    
    if([name isEqualToString:@"radion"]) {
        
        [self performSegueWithIdentifier:@"radio.play" sender:self];
        
    }
    
}

- (NSArray *)miscPlaces {
    
    return [self.karneval placesFilteredByCategories:[LKarneval LKPlaceFilterMisc]];
    
}

- (void)renderGrid {
    
    [self.scrollView setContentSize:[self.grid contentSize]];
    
    [self.grid.cells enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        
        LKCell *cell = (LKCell *)object;
        LKPlace *place = [[self miscPlaces] objectAtIndex:index];
        
        LKButton *button = [LKLayout buttonForCell:cell
                                   withStrokeColor:[LKColor colorWithIdentifier:LKColorBeige]
                                          andImage:[place imageForPlace]];
        button.identifier = place.name;
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
    NSString *identifier = [button.identifier lowercaseString];
    
    [self performSegueForName:identifier];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

- (LKGrid *)grid {
    
    if(!_grid) {
        
        _grid = [[LKGrid alloc] initWithFrame:self.scrollView.frame andGridCells:[LKGrid cellsFromArray:[self miscPlaces]]];
        
    }
    
    return _grid;
    
}

@end

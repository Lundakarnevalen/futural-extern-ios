//
//  EntertainmentViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-24.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "EntertainmentViewController.h"

#define RADIUS_DEFAULT 80
#define FONT_SIZE 12

@implementation EntertainmentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self renderGrid];
    
}

- (void)renderGrid {
    
    UIColor *strokeColor = [LKColor colorWithIdentifier:LKColorRed];
    [self.scrollView setContentSize:[self.grid contentSize]];
    
    [self.grid.cells enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        
        LKCell *cell = (LKCell *)object;
        LKPlace *place = [self.karneval.places objectAtIndex:index];
        
        //BUTTON
        LKButton *button = [[LKButton alloc] init];
        button.frame = CGRectMake(cell.position.x, cell.position.y, cell.size.width, cell.size.height);
        button.backgroundImage = [place imageForPlace];
        [button drawCircleButton:strokeColor];
        
        //LABEL
        CGSize titleSize;
        titleSize.width = RADIUS_DEFAULT;
        titleSize.height = FONT_SIZE;
        
        CGPoint titlePosition;
        titlePosition.x = cell.position.x;
        titlePosition.y = cell.position.y + (RADIUS_DEFAULT / 0.9);
        
        CGRect titleFrame;
        titleFrame.origin = titlePosition;
        titleFrame.size = titleSize;
        
        UILabel *title = [[UILabel alloc] initWithFrame:titleFrame];
        title.font = [UIFont fontWithName:@"Futura-Bold" size:FONT_SIZE];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = [place.name uppercaseString];
        
        [self.scrollView addSubview:button];
        [self.scrollView addSubview:title];
        
    }];
    
}

- (NSArray *)cells {
    
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    
    for(NSInteger index = 0; index < [self.karneval.places count]; index++) {
        
        LKCell *cell = [[LKCell alloc] initWithRadius:RADIUS_DEFAULT];
        [cells addObject:cell];
        
    }
    
    return cells;
    
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

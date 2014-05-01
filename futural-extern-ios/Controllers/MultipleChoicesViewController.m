//
//  MultipleChoicesViewController.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-29.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "MultipleChoicesViewController.h"

#import "LKColor.h"

@implementation MultipleChoicesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //bluurrrrrrrr.
    [self.backgroundImage setImage:[LKLayout blurImage:self.desiredBackgroundImage withRadiusOf:3]];
    [self.backgroundImage setClipsToBounds:YES];
    
    self.title = self.parentName;
    
    [self renderGrid];
    
}

- (void)renderGrid {
    
    [self.scrollView setContentSize:[self.grid contentSize]];
    
    [self.grid.cells enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        
        LKCell *cell = (LKCell *)object;
        id information = [self.choices objectAtIndex:index];
        
        if([information class] == [LKPlace class]) {
            
            information = (LKPlace *)information;
            self.logotype = [information imageForPlace];
            
        } else if([information class] == [LKEvent class]) {
            
            information = (LKEvent *)information;
            self.logotype = [information imageForEvent];
            
        }
        
        LKButton *button = [LKLayout buttonForCell:cell
                                   withStrokeColor:self.strokeColor
                                          andImage:self.logotype];
        button.tag = index; //identifier
        [button addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *title = [LKLayout titleLabelForCell:cell
                                           withTitle:[information name]];
        
        [self.scrollView addSubview:button];
        [self.scrollView addSubview:title];
        
    }];
    
}

- (void)cellClick:(id)sender {
    
    
    
}

- (LKGrid *)grid {
    
    if(!_grid) {
        
        _grid = [[LKGrid alloc] initWithFrame:self.scrollView.frame andGridCells:[LKGrid cellsFromArray:self.choices]];
        
    }
    
    return _grid;
    
}

@end

//
//  MultipleChoicesViewController.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-04-29.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "MultipleChoicesViewController.h"
#import "MapViewController.h"
#import "DetailViewController.h"

#import "LKColor.h"
#import "LKMapView.h"
#import "LKAnnotation.h"

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
        
//        LKMapView *map = [[LKMapView alloc] init];
//        LKAnnotation *annotation = [[LKAnnotation alloc] initWithPlace:information];
//        map.frame = button.frame;
//        [map addAndCenterAnnotation:annotation];
//        [map renderOverlay];
//        
//        [button addSubview:map];
        
        UILabel *title = [LKLayout titleLabelForCell:cell
                                           withTitle:[information name]];
        
        [self.scrollView addSubview:button];
        [self.scrollView addSubview:title];
        
    }];
    
}

- (void)cellClick:(id)sender {

    LKButton *button = sender;
    LKPlace *place = [self.choices objectAtIndex:button.tag];
    
    if(!place) {
        
        place = [[self.choices objectAtIndex:button.tag] place]; //event scene
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"choiceClick" object:self userInfo:@{@"place" : place}];
    
    
    
}

- (LKGrid *)grid {
    
    if(!_grid) {
        
        _grid = [[LKGrid alloc] initWithFrame:self.scrollView.frame andGridCells:[LKGrid cellsFromArray:self.choices]];
        
    }
    
    return _grid;
    
}

@end

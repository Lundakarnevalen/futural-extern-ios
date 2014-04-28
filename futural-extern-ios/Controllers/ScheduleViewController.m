//
//  ScheduleViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "ScheduleViewController.h"

#import "LKImage.h"
#import "LKLayout.h"

#define CELL_IDENTIFIER "event"

#define TAG_HEADER_NAME 1
#define TAG_HEADER_PLACE 2
#define TAG_IMAGE 3
#define TAG_TIME_START 4
#define TAG_TIME_END 5
#define TAG_FAVORITE 6

@implementation ScheduleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (NSArray *)events {
    
    //add a property to filter this relative to day.
    return [self.karneval upcomingEvents];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self events] count];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [tableView setBackgroundColor:[UIColor clearColor]];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    LKEvent *event = [[self events] objectAtIndex:row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@CELL_IDENTIFIER];
    
    UILabel *headerName = (UILabel *)[[cell contentView] viewWithTag:TAG_HEADER_NAME];
    UILabel *headerPlace = (UILabel *)[[cell contentView] viewWithTag:TAG_HEADER_PLACE];
    UILabel *timeStart = (UILabel *)[[cell contentView] viewWithTag:TAG_TIME_START];
    UILabel *timeEnd = (UILabel *)[[cell contentView] viewWithTag:TAG_TIME_END];
    LKImage *image = (LKImage *)[[cell contentView] viewWithTag:TAG_IMAGE];
    UIButton *favorite = (UIButton *)[[cell contentView] viewWithTag:TAG_FAVORITE];
    
    headerName.text = [NSString stringWithFormat:@"%@", [event.name uppercaseString]];
    headerPlace.text = [NSString stringWithFormat:@"%@", [event.place.name uppercaseString]];
    
    timeStart.text = [NSString stringWithFormat:@"%@", [event formattedStartTime]];
    timeEnd.text = [NSString stringWithFormat:@"%@", [event formattedEndTime]];

    [image setImage:[event imageForEvent]];
    [image drawCircularImage:[UIColor whiteColor]];
    
    [favorite setSelected:event.favorite];
    [favorite addTarget:self action:@selector(favoriteEventAtRow:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
    
}

- (void)favoriteEventAtRow:(UIButton *)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    LKEvent *event = [[self events] objectAtIndex:indexPath.row];
    
    event.favorite = ![event isFavorite];
    [sender setSelected:[event isFavorite]];
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

@end

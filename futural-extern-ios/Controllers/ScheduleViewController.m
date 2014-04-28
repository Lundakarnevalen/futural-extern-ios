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
    
    LKEvent *event = [[self events] objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@CELL_IDENTIFIER];
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@CELL_IDENTIFIER];
        
    }
    
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
    [favorite setTag:TAG_FAVORITE * indexPath.row]; //to solve the equation of which object that was favorited. (ugly, but working, solved by dividing the tag with 6 a.k.a TAG_FAVORITE).
    [favorite addTarget:self action:@selector(favoriteEventAtRow:) forControlEvents:UIControlEventTouchDown];
    
    NSLog(@"Current row: %d", indexPath.row);
    
    return cell;
    
}

- (void)favoriteEventAtRow:(UIButton *)sender {
    
    NSInteger row = sender.tag / TAG_FAVORITE;
    LKEvent *event = [[self events] objectAtIndex:row];
    
    NSLog(@"%@-tag %d", event.name, sender.tag);
    
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

//
//  ScheduleViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "ScheduleViewController.h"

#define CELL_IDENTIFIER "event"

#define TAG_HEADER_NAME 1
#define TAG_HEADER_PLACE 2
#define TAG_IMAGE 3
#define TAG_TIME_START 4
#define TAG_TIME_END 5

@implementation ScheduleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return filtered and sorted array later (based on date, this should happen inside of the model).
    return [self.karneval.events count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LKEvent *event = [self.karneval.events objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@CELL_IDENTIFIER];
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@CELL_IDENTIFIER];
        
    }
    
    UILabel *headerName = (UILabel *)[[cell contentView] viewWithTag:TAG_HEADER_NAME];
    UILabel *headerPlace = (UILabel *)[[cell contentView] viewWithTag:TAG_HEADER_PLACE];
    UILabel *timeStart = (UILabel *)[[cell contentView] viewWithTag:TAG_TIME_START];
    UILabel *timeEnd = (UILabel *)[[cell contentView] viewWithTag:TAG_TIME_END];
    UIImageView *image = (UIImageView *)[[cell contentView] viewWithTag:TAG_IMAGE];
    
    headerName.text = [NSString stringWithFormat:@"%@", event.name];
    headerPlace.text = [NSString stringWithFormat:@"%@", [event.place.name uppercaseString]];
    
    timeStart.text = [NSString stringWithFormat:@"%@", [event formattedStartTime]];
    timeEnd.text = [NSString stringWithFormat:@"%@", [event formattedEndTime]];
    
    [image setImage:[event imageForEvent]];
    
    return cell;
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

@end

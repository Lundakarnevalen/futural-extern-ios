//
//  ScheduleViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "ScheduleViewController.h"
#import "DetailViewController.h"

#import "LKImage.h"
#import "LKLayout.h"

#define CELL_IDENTIFIER "event"

#define TAG_HEADER_NAME 1
#define TAG_HEADER_PLACE 2
#define TAG_IMAGE 3
#define TAG_TIME_START 4
#define TAG_TIME_END 5
#define TAG_FAVORITE 6
#define TAG_FAVORITE_IMAGE 7

//the category view.
#define TAG_HEAD_LABEL 1
#define TAG_HEAD_VIEW 2

#define TAG_TOP_CIRCLE 20
#define TAG_BOTTOM_CIRCLE 21

@implementation ScheduleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [LKLayout customizeSegment:self.sectionButton];
    
}

- (NSArray *)events {
    
    //add a property to filter this relative to day.
    NSInteger selectedSection = [self.sectionButton selectedSegmentIndex];
    
    switch(selectedSection) {
    
        case 0:
            return [self.karneval upcomingEvents];
            
            break;
            
        case 1:
            
            return [self.karneval favoriteEvents];
            
            break;
            
        case 2:
            
            return [self.karneval allEvents];
            
            break;
            
        default:
            return nil;
            break;
            
            
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dates = [LKarneval datesFromEvents:[self events]];
    NSString *dateString = [self convertIndexToDateString:section];
    
    return [dates[dateString] count];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *dateString = [self convertIndexToDateString:section];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-2014", dateString]];
    [dateFormatter setDateFormat:@"EEEE (dd/MM)"];
    
    
    UIView *header = [[[NSBundle mainBundle] loadNibNamed:@"scheduleTableHeader" owner:self options:nil] firstObject];
    UILabel *informationLabel = (UILabel *)[header viewWithTag:TAG_HEAD_LABEL];
    UIView *backgroundView = [header viewWithTag:TAG_HEAD_VIEW];
    
    [LKLayout addShadowToView:backgroundView ofSize:3];
    
    informationLabel.text = [[dateFormatter stringFromDate:date] uppercaseString];
    informationLabel.font = [LKLayout fontForTableHeader];
    
    return header;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [tableView setBackgroundColor:[UIColor clearColor]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSDictionary *dates = [LKarneval datesFromEvents:[self events]];
    
    return [dates count];
    
}

- (IBAction)sectionChanged:(id)sender {
    
    [self.tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [self.class rowIndexFromIndexPath:indexPath inTableView:self.tableView];
    
    LKEvent *event = [[self events] objectAtIndex:row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@CELL_IDENTIFIER];
    NSString *dateString = [self convertIndexToDateString:indexPath.section];
    NSDictionary *dates = [LKarneval datesFromEvents:[self events]];
    
    UILabel *headerName = (UILabel *)[[cell contentView] viewWithTag:TAG_HEADER_NAME];
    UILabel *headerPlace = (UILabel *)[[cell contentView] viewWithTag:TAG_HEADER_PLACE];
    UILabel *timeStart = (UILabel *)[[cell contentView] viewWithTag:TAG_TIME_START];
    UILabel *timeEnd = (UILabel *)[[cell contentView] viewWithTag:TAG_TIME_END];
    LKImage *image = (LKImage *)[[cell contentView] viewWithTag:TAG_IMAGE];
    UIButton *favorite = (UIButton *)[[cell contentView] viewWithTag:TAG_FAVORITE];
    UIImageView *favoriteImage = (UIImageView *)[[cell contentView] viewWithTag:TAG_FAVORITE_IMAGE];
    UIView *topCircle = (UIView *)[[cell contentView] viewWithTag:TAG_TOP_CIRCLE];
    UIView *bottomCircle = (UIView *)[[cell contentView] viewWithTag:TAG_BOTTOM_CIRCLE];
    
    [LKLayout addShadowToLabel:headerName withSizeOf:1];
    [LKLayout addShadowToLabel:headerPlace withSizeOf:1];
    [LKLayout addShadowToLabel:timeStart withSizeOf:1];
    [LKLayout addShadowToLabel:timeEnd withSizeOf:1];
    
    topCircle.hidden = (indexPath.row != 0);
    bottomCircle.hidden = (indexPath.row != [dates[dateString] count] - 1);
    
    topCircle.layer.cornerRadius = topCircle.frame.size.height / 2;
    bottomCircle.layer.cornerRadius = bottomCircle.frame.size.height / 2;
    
    headerName.text = [NSString stringWithFormat:@"%@", [event.name uppercaseString]];
    headerPlace.text = [NSString stringWithFormat:@"%@", [event.place.name uppercaseString]];
    
    NSString *startTime =[NSString stringWithFormat:@"%@", [event formattedStartTime]];
    NSString *endTime = [NSString stringWithFormat:@"%@", [event formattedEndTime]];
    
    if(![startTime isEqualToString:@"13:37"] && ![endTime isEqualToString:@"13:37"]) {
        
        timeStart.text = startTime;
        timeEnd.text = endTime;
        
    } else {
        
        timeStart.text = @"";
        timeEnd.text = @"";
        
    }

    [image setImage:[event imageForEvent]];
    [image drawCircularImage:[UIColor whiteColor]];
    
    [favoriteImage setImage:[UIImage imageNamed:[[self class] imageNameForHeartWithStatusOf:[event isFavorite]]]];
    [favorite addTarget:self action:@selector(favoriteEventAtRow:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    NSInteger row = [self.class rowIndexFromIndexPath:indexPath inTableView:self.tableView];
    
    LKEvent *event = [[self events] objectAtIndex:row];
    
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.event = event;
    detailVC.segueIdentifier = segue.identifier;
    
}

- (void)favoriteEventAtRow:(UIButton *)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    NSInteger row = [self.class rowIndexFromIndexPath:indexPath inTableView:self.tableView];
    
    LKEvent *event = [[self events] objectAtIndex:row];
    
    event.favorite = ![event isFavorite];
    
    UIImageView *heartImage = (UIImageView *)[[sender superview] viewWithTag:TAG_FAVORITE_IMAGE];
    NSString *imageName = [[self class] imageNameForHeartWithStatusOf:[event isFavorite]];
    [heartImage setImage:[UIImage imageNamed:imageName]];
    
    [self.tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 75; //or the first header will be hidden. :(
}


- (void) viewWillAppear:(BOOL)animated {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    [super viewWillAppear:animated];
}

- (NSString *)convertIndexToDateString:(NSInteger)dateIndex {
    
    NSDictionary *dates = [LKarneval datesFromEvents:[self events]];
    
    NSArray *allDates = [dates allKeys];
    NSArray *sortedDates = [allDates sortedArrayUsingSelector:@selector(compare:)];
    
    return sortedDates[dateIndex];
    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

+ (NSString *)imageNameForHeartWithStatusOf:(BOOL)isFavorite {
    
    return isFavorite ? @"heart-filled" : @"heart";
    
}

+ (NSInteger)rowIndexFromIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView {
    
    NSInteger row = 0;
    
    for (NSInteger i = 0; i < indexPath.section; i++) {
        
        row += [tableView numberOfRowsInSection:i];
        
    }
    
    row += indexPath.row;
    
    return row;
    
}

@end

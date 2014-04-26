//
//  MapFilterViewController.m
//  Lundakarnevalen
//
//  Created by Richard Luong on 2014-04-17.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "MapFilterViewController.h"

#define TAG_LABEL 1001
#define TAG_IMG 1002

NSString *const FilterMapTableViewRowDidSelect             = @"FilterMapTableViewRowDidSelect";

@interface MapFilterViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *filter;

@end

@implementation MapFilterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.filter = [[NSUserDefaults standardUserDefaults] objectForKey:@"filter"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return NumberOfFilters+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    UILabel *label = nil;
    switch (indexPath.row) {
        case 0:
            if (!cell) cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
            label = (UILabel *)[[cell contentView] viewWithTag:TAG_LABEL];
            label.text = @"MAT";
            label.textColor = ([self.filter[@"food"] boolValue]) ? [UIColor whiteColor] : [[UIColor blackColor] colorWithAlphaComponent:0.4];
            break;
        case 1:
            if (!cell) cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
            label = (UILabel *)[[cell contentView] viewWithTag:TAG_LABEL];
            label.text = @"NÖJEN";
            label.textColor = ([self.filter[@"entertainment"] boolValue]) ? [UIColor whiteColor] : [[UIColor blackColor] colorWithAlphaComponent:0.4];
            break;
        case 2:
            if (!cell) cell = [tableView dequeueReusableCellWithIdentifier:@"ShowEverythingCell" forIndexPath:indexPath];
            break;
        default:
            
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            [self.filter setObject:[NSNumber numberWithBool:![self.filter[@"food"] boolValue]] forKey:@"food"];
            break;
        case 1:
            [self.filter setObject:[NSNumber numberWithBool:![self.filter[@"entertainment"] boolValue]] forKey:@"entertainment"];
            break;
        case 2:
            [self.filter setValue:[NSNumber numberWithBool:YES] forKey:@"food"];
            [self.filter setValue:[NSNumber numberWithBool:YES] forKey:@"entertainment"];
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.filter forKey:@"filter"];
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:FilterMapTableViewRowDidSelect object:self userInfo:nil];
    [self.tableView reloadData];
    //NSLog(@"Du klickade på rad %d.", (int) indexPath.row);
}

@end

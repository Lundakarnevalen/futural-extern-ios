//
//  EntertainmentViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "EntertainmentViewController.h"
#import "EntertainmentDetailViewController.h"

#define CELL_IDENTIFIER "entertainment"
#define TAG_HEADER 1

@implementation EntertainmentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.karneval.places count];
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LKPlace *place = [self.karneval.places objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@CELL_IDENTIFIER];
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@CELL_IDENTIFIER];
        
    }
    
    UILabel *header = (UILabel *)[[cell contentView] viewWithTag:TAG_HEADER];
    
    header.text = [NSString stringWithFormat:@"%@", place.name];
    
    return cell;
    
}

#pragma mark Lazy instantiations

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

#pragma mark Table delegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:sender];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    
    EntertainmentDetailViewController *detailView = (EntertainmentDetailViewController *)segue.destinationViewController;
    detailView.place = self.karneval.places[rowOfTheCell];
    
}

@end

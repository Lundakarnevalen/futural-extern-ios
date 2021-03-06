//
//  ScheduleViewController.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) LKarneval *karneval;

@property (nonatomic) LKEvent *visitEvent;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sectionButton;

@end

//
//  EntertainmentViewController.h
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-16.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntertainmentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) LKarneval *karneval;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

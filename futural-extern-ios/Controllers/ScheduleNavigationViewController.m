//
//  ScheduleNavigationViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-18.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "ScheduleNavigationViewController.h"

#import "LKColor.h"

@implementation ScheduleNavigationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [LKColor customizeNavigationBar:self.navigationBar];
    
}

@end

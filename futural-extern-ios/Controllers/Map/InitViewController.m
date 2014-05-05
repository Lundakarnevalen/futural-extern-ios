//
//  InitViewController.m
//  Test3
//
//  Created by Richard Luong on 2014-04-15.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import "InitViewController.h"

@implementation InitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Karta"];

}

@end

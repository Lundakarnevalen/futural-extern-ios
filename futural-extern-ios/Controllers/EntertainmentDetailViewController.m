//
//  EntertainmentDetailViewController.m
//  Lundakarnevalen
//
//  Created by Victor Ingman on 2014-04-17.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "EntertainmentDetailViewController.h"

@implementation EntertainmentDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = self.place.name;

    
}

- (LKarneval *)karneval {
    
    if(!_karneval) {
        
        _karneval = [LKarneval sharedLKarneval];
        
    }
    
    return _karneval;
    
}

@end

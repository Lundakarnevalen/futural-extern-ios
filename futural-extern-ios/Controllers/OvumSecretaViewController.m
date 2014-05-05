//
//  OvumSecretaViewController.m
//  Lundakarneval
//
//  Created by Victor Ingman on 2014-05-05.
//  Copyright (c) 2014 Lundakarnevalen. All rights reserved.
//

#import "OvumSecretaViewController.h"

#import "LKLayout.h"

@interface OvumSecretaViewController ()

@end

@implementation OvumSecretaViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.headerLabel setText:[self.headerLabel.text uppercaseString]];
    [self.headerLabel setFont:[LKLayout ovumSecretaHeader]];
    
    for(UIView *block in self.blockViews) {
        
        [block setAlpha:0.9];
        [LKLayout addShadowToView:block ofSize:3];
        
    }
    
}

@end

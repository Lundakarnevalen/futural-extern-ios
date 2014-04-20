//
//  CreateAnnotationsViewController.m
//  Test3
//
//  Created by Richard Luong on 2014-04-14.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import "CreateAnnotationsViewController.h"
#import "SkaneAnnotation.h"

@interface CreateAnnotationsViewController ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UITextField *latTextField;
@property (weak, nonatomic) IBOutlet UITextField *lngTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *subtitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageTextField;

@end

@implementation CreateAnnotationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)doneButtonPressed:(id)sender {
    NSDictionary *coord = [[NSDictionary alloc] initWithObjectsAndKeys:self.latTextField.text, @"lat", self.lngTextField.text, @"lng", nil];
    NSDictionary *anno = [[NSDictionary alloc] initWithObjectsAndKeys:
                          self.titleTextField.text, @"title",
                          self.subtitleTextField.text, @"subtitle",
                          self.imageTextField.text, @"image",
                          coord, @"coordinates",
                          nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"annotations" ofType:@"plist"];
    NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSMutableArray *array = nil;
    NSString *docsPath = [docsFolder stringByAppendingString:@"/annotations.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:docsPath]) {
        array = [NSMutableArray arrayWithContentsOfFile:docsPath];
    } else {
        array = [NSMutableArray arrayWithContentsOfFile:path];
    }
    
    [array addObject:anno];
    
    NSLog(@"%d", [array writeToFile:docsPath atomically:YES]);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.latTextField.text = [NSString stringWithFormat:@"%f", self.lat];
    self.lngTextField.text = [NSString stringWithFormat:@"%f", self.lng];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

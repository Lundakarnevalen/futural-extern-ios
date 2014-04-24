//
//  CreateAnnotationsViewController.m
//  Test3
//
//  Created by Richard Luong on 2014-04-14.
//  Copyright (c) 2014 Richard Luong. All rights reserved.
//

#import "CreateAnnotationsViewController.h"
#import "LKAnnotation.h"

@interface CreateAnnotationsViewController ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UITextField *latTextField;
@property (weak, nonatomic) IBOutlet UITextField *lngTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageTextField;
@property (weak, nonatomic) IBOutlet UITextField *aimgTextField;
@property (weak, nonatomic) IBOutlet UITextField *descTextField;
@property (weak, nonatomic) IBOutlet UITextField *catTextField;
@property (weak, nonatomic) IBOutlet UITextField *alcoholTextField;


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
    NSDictionary *position = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:[self.latTextField.text floatValue]], @"latitude", [NSNumber numberWithFloat:[self.lngTextField.text floatValue]], @"longitude", nil];
    NSString *title = self.titleTextField.text;
    NSString *image = self.imageTextField.text;
    NSString *aimg = self.aimgTextField.text;
    NSString *desc = self.descTextField.text;
    NSNumber *category = [NSNumber numberWithInt:[self.catTextField.text integerValue]];
    NSNumber *alcohol = [NSNumber numberWithBool:[self.alcoholTextField.text boolValue]];
    NSArray *pay = [[NSArray alloc] init];
    
    NSDictionary *place = [[NSDictionary alloc] initWithObjectsAndKeys:
                           title, @"name",
                           image, @"image",
                           aimg, @"annotation_image",
                           desc, @"description",
                           category, @"category",
                           pay, @"payment_options",
                           alcohol, @"alcohol",
                           position, @"position",
                          nil];
    
    for (id key in place) {
        NSLog(@"key: %@, value: %@ \n", key, [place objectForKey:key]);
    }

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Places" ofType:@"plist"];
    NSString *docsFolder = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSMutableDictionary *array = nil;
    NSString *docsPath = [docsFolder stringByAppendingString:@"/Places.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:docsPath]) {
        array = [NSMutableDictionary dictionaryWithContentsOfFile:docsPath];
    } else {
        array = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    }
    
    [array setObject:place forKey:[title lowercaseString]];
    
    NSLog(@"%d", [array writeToFile:docsPath atomically:YES]);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.latTextField.text = [NSString stringWithFormat:@"%.20f", self.lat];
    self.lngTextField.text = [NSString stringWithFormat:@"%.20f", self.lng];
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

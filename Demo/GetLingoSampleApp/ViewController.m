//
//  ViewController.m
//  GetLingoSampleApp
//
//  Created by Sebastian Ljungberg on 15/02/16.
//  Copyright © 2016 Xeppen Productions. All rights reserved.
//

#import "ViewController.h"
#import "GLLingoManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.apiLabel1.text = GLLocalizedString(@"SAMPLE_APP_DATE", @"December, 2015");
    self.apiLabel2.text = [NSString stringWithFormat:GLLocalizedString(@"SAMPLE_APP_DEEDS", @"%i deeds completed"), 4];
    self.apiLabel3.text = GLLocalizedString(@"SAMPLE_APP_REACH_GOLD", @"You're on course to reach your goal for this month.");
    self.apiLabel4.text = GLLocalizedString(@"SAMPLE_APP_HIGH_FIVE", @"Error key");
    self.apiLabel5.text = GLLocalizedString(@"SAMPLE_APP_LOCAL_STRING", @"Using local string file since ");
    self.apiLabel6.text = GLLocalizedString(@"SAMPLE_APP_UNKNOWN_KEY", @"This is an example when there are no key and default value is used.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

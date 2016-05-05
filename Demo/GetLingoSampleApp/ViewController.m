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
    
    self.testLabel1.text = GLLocalizationString(@"PARKING_RULE_PARKING_VERDICT_ALLOWED", @"Default parkering tillåten");
    self.testLabel2.text = GLLocalizationString(@"PARKING_RULE_PARKING_VERDICT_RESTRICTED", @"Error key");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  QHSpeechSynthesizerQueue
//
//  Created by Quentin Hayot on 27/04/2015.
//  Copyright (c) 2015 Quentin Hayot. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.speechSynthesizerQueue = [[QHSpeechSynthesizerQueue alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readLast:(id)sender {
    [self.speechSynthesizerQueue readLast:[[self textField] text] withLanguage:@"en-EN" andRate:0.2f];
}

- (IBAction)readNext:(id)sender {
    [self.speechSynthesizerQueue readNext:[[self textField] text] withLanguage:@"en-EN" andRate:0.2f andClearQueue:[self.clearQueueSwitch isOn]];
}

- (IBAction)readImmediately:(id)sender {
    [self.speechSynthesizerQueue readImmediately:[[self textField] text] withLanguage:@"en-EN" andRate:0.2f andClearQueue:[self.clearQueueSwitch isOn]];
}
@end

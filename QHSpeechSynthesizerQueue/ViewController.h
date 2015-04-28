//
//  ViewController.h
//  QHSpeechSynthesizerQueue
//
//  Created by Quentin Hayot on 27/04/2015.
//  Copyright (c) 2015 Quentin Hayot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHSpeechSynthesizerQueue.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) QHSpeechSynthesizerQueue *speechSynthesizerQueue;

@property (strong, nonatomic) IBOutlet UISwitch *clearQueueSwitch;

- (IBAction)readLast:(id)sender;
- (IBAction)readNext:(id)sender;
- (IBAction)readImmediately:(id)sender;
@end


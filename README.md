# QHSpeechSynthesizerQueue
[![Build Status](https://travis-ci.org/quentinhayot/QHSpeechSynthesizerQueue.svg?branch=master)](https://travis-ci.org/quentinhayot/QHSpeechSynthesizerQueue)  
Queue management system for AVSpeechSynthesizer

## Installation
### Cocoapods
Add this to your Podfile:  
```objective-c
pod 'QHSpeechSynthesizerQueue'
```
Run a `pod install` and import the header where you need it:  
```objective-c
#import <QHSpeechSynthesizerQueue.h>
```
### Manually
Drop QHSpeechSynthesizerQueue.h and QHSpeechSynthesizerQueue.m in your project, then  
```objective-c
#import "QHSpeechSynthesizerQueue.h"
```

##Usage
#### Initialization
```objective-c
QHSpeechSynthesizerQueue *synthesizerQueue = [[QHSpeechSynthesizerQueue alloc] init];
```
#### Adding messages to the queue
##### Add a message at the end of the queue
```objective-c
[synthesizerQueue readLast:@"This message will be added to the end of the queue" 
                  withLanguage:@"en_US"
                  andRate:@"0.2"];
```
##### Insert a message to be read immediatly after the current message being read
```objective-c
[synthesizerQueue readNext:@"This message will be read next"
                  withLanguage:@"en_US"
                  andRate:@"0.2"
                  andClearQueue:NO];
```
If you set `andClearQueue:` to `YES`, the queue will be cleared and this will be the last message to be read.
##### Interrupt the current message and read this one immediately
```objective-c
[synthesizerQueue readImmediately:@"This message will be read next"
                  withLanguage:@"en_US"
                  andRate:@"0.2"
                  andClearQueue:NO];
```
If you set `andClearQueue:` to `YES`, the queue will be cleared and this will be the last message to be read.

#### Playback actions
##### Stop
Stop the queue's playback and clear the queue immediately.
```objective-c
[synthesizerQueue stop];
```
##### Stop after current
Stop the queue's playback and clear the queue. If something is currently being read, it will stop afterwards.
```objective-c
[synthesizerQueue stopAfterCurrent];
```
##### Pause
Pause the queue's playback immediately.
```objective-c
[synthesizerQueue pause];
```
##### Pause after current
Pause the queue's playback. If something is currently being read, it will pause afterwards.
```objective-c
[synthesizerQueue pauseAfterCurrent];
```
##### Resume
Resume the queue's playback.
```objective-c
[synthesizerQueue resume];
```
##### Clear queue
Clear the queue. If something is being read, it will not be interupted and future added messages will be read if not paused/stopped.
```objective-c
[synthesizerQueue clearQueue];
```

#### Properties
##### BOOL duckOthers
Set this to YES to duck all the device's audio sessions when a string is being read. Defaults to YES.
```objective-c
synthesizerQueue.duckOthers = YES;
```
##### NSTimeInterval preDelay
The delay before reading a message. Default is 0.0
```objective-c
synthesizerQueue.preDelay = 1.0;
```
##### NSTimeInterval postDelay
The delay after reading a message. Default is 0.0
```objective-c
synthesizerQueue.postDelay = 1.0;
```

#### Delegate
You can set a `QHSpeechSynthesizerQueueDelegate` to be notified of playback events.
```objective-c
@protocol QHSpeechSynthesizerQueueDelegate <NSObject>

@optional
- (void)speechSynthesizerQueueDidStartTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueDidFinishTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueDidPauseTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueDidContinueTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueDidCancelTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueWillStartTalking:(QHSpeechSynthesizerQueue *)queue;

@end
```

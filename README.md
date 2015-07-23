# QHSpeechSyntesizerQueue
[![Build Status](https://travis-ci.org/quentinhayot/QHSpeechSynthesizerQueue.svg?branch=1.1.0)](https://travis-ci.org/quentinhayot/QHSpeechSynthesizerQueue)  
Queue management system for AVSpeechSynthesizer

## Installation
### Cocoapods
Add this to your Podfile:  
```objective-c
pod 'QHSpeechSyntesizerQueue'
```
Run a `pod install` and import the header where you need it:  
```objective-c
#import <QHSpeechSyntesizerQueue.h>
```
### Manually
Drop QHSpeechSyntesizerQueue.h and QHSpeechSyntesizerQueue.m in your project, then  
```objective-c
#import "QHSpeechSyntesizerQueue.h"
```

##Usage
#### Initialization
```objective-c
QHSpeechSyntesizerQueue *syntesizerQueue = [[QHSpeechSyntesizerQueue alloc] init];
```
#### Adding messages to the queue
##### Add a message at the end of the queue
```objective-c
[syntesizerQueue readLast:@"This message will be added to the end of the queue" withLanguage:@"en_US" andRate:@"0.2"];
```
##### Insert a message to be read immediatly after the current message being read
```objective-c
[syntesizerQueue readNext:@"This message will be read next" withLanguage:@"en_US" andRate:@"0.2" andClearQueue:NO];
```
If you set `andClearQueue:` to `YES`, the queue will be cleared and this will be the last message to be read.
##### Interrupt the current message and read this one immediately
```objective-c
[syntesizerQueue readImmediately:@"This message will be read next" withLanguage:@"en_US" andRate:@"0.2" andClearQueue:NO];
```
If you set `andClearQueue:` to `YES`, the queue will be cleared and this will be the last message to be read.

#### Playback actions
##### Stop
Stop the queue's playback and clear the queue immediately.
```objective-c
[syntesizerQueue stop];
```
##### Stop after current
Stop the queue's playback and clear the queue. If something is currently being read, it will stop afterwards.
```objective-c
[syntesizerQueue stopAfterCurrent];
```
##### Pause
Pause the queue's playback immediately.
```objective-c
[syntesizerQueue pause];
```

//
//  TTSQueue.h
//  QHSpeechSynthesizerQueue
//
//  Created by Quentin Hayot on 27/04/2015.
//  Copyright (c) 2015 Quentin Hayot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@protocol QHSpeechSynthesizerQueueDelegate;

/*!
 @class SpeechSynthesizerQueue
 @abstract
 SpeechSynthesizerQueue provides a queue management system for AVSpeechSynthesizer.
 
 @discussion
 -
 */
@interface QHSpeechSynthesizerQueue : NSObject <AVSpeechSynthesizerDelegate>
{
@protected
    NSMutableArray *_queue;
    AVSpeechSynthesizer *_synthesizer;
    BOOL _play;
    AVAudioSession *_audioSession;
    
}

@property(nonatomic, assign) id<QHSpeechSynthesizerQueueDelegate> delegate;

/*!
 * @brief The delay before reading a message. Default is 0.0
 */
@property(nonatomic) NSTimeInterval preDelay;

/*!
 * @brief The delay after reading a message. Default is 0.0
 */
@property(nonatomic) NSTimeInterval postDelay;

/*!
 * @brief Set this to YES to duck all the device's audio sessions when a string is being read. Defaults to YES.
 */
@property(nonatomic) BOOL duckOthers;

/*!
 @abstract      Add a string to read at the end of the queue.
 @param			message
 The string to be read.
 @param			language
 Specifies the BCP-47 language tag that represents the voice.
 Passing nil will use the system's default region and language.
 Examples: en-US (U.S. English), fr-CA (French Canadian)
 @param			rate
 The rate at which the string will be spoken.
 @discussion
 -
 */
-(void)readLast:(NSString*)message withLanguage:(NSString*)language andRate:(float)rate;

/*!
 @abstract      Add a string to read right after the current one. If nothing is currently being read, this string will be read immediately.
 @param			message
 The string to be read.
 @param			language
 Specifies the BCP-47 language tag that represents the voice.
 Passing nil will use the system's default region and language.
 Examples: en-US (U.S. English), fr-CA (French Canadian)
 @param			rate
 The rate at which the string will be spoken.
 @param         clearQueue
 If set to YES, the queue will be cleared and this string will be the last to be read.
 @discussion
 -
 */
-(void)readNext:(NSString*)message withLanguage:(NSString*)language andRate:(float)rate andClearQueue:(BOOL)clearQueue;

/*!
 @abstract      Read a string immediately. If something is currently being read, it will be interrupted.
 @param			message
 The string to be read.
 @param			language
 Specifies the BCP-47 language tag that represents the voice.
 Passing nil will use the system's default region and language.
 Examples: en-US (U.S. English), fr-CA (French Canadian)
 @param			rate
 The rate at which the string will be spoken.
 @param         clearQueue
 If set to YES, the queue will be cleared and this string will be the last to be read.
 @discussion
 -
 */
-(void)readImmediately:(NSString*)message withLanguage:(NSString*)language andRate:(float)rate andClearQueue:(BOOL)clearQueue;

/*!
 @abstract      Resume the queue's playback.
 @discussion
 -
 */
-(void)resume;

/*!
 @abstract      Stop the queue's playback and clear the queue. If something is currently being read, it will stop afterwards.
 @discussion
 -
 */
-(void)stopAfterCurrent;

/*!
 @abstract      Pause the queue's playback. If something is currently being read, it will pause afterwards.
 @discussion
 -
 */
-(void)pauseAfterCurrent;

/*!
 @abstract      Stop the queue's playback and clear the queue immediately.
 @discussion
 -
 */
-(void)stop;

/*!
 @abstract      Pause the queue's playback immediately.
 @discussion
 -
 */
-(void)pause;

/*!
 @abstract      Clear the queue. If something is being read, it will not be interupted and future messages will be read if not paused/stopped.
 @discussion
 -
 */
-(void)clearQueue;

@end

@protocol QHSpeechSynthesizerQueueDelegate <NSObject>

@optional
- (void)speechSynthesizerQueueDidStartTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueDidFinishTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueDidPauseTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueDidContinueTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueDidCancelTalking:(QHSpeechSynthesizerQueue *)queue;
- (void)speechSynthesizerQueueWillStartTalking:(QHSpeechSynthesizerQueue *)queue;

@end

//
//  TTSQueue.m
//  QHSpeechSynthesizerQueue
//
//  Created by Quentin Hayot on 27/04/2015.
//  Copyright (c) 2015 Quentin Hayot. All rights reserved.
//

#import "QHSpeechSynthesizerQueue.h"

@implementation QHSpeechSynthesizerQueue


-(instancetype)init{
    QHSpeechSynthesizerQueue *queueInstance = [super init];
    if (queueInstance){
        queueInstance->queue = [[NSMutableArray alloc] init];
        queueInstance->synthesizer = [[AVSpeechSynthesizer alloc] init];
        [queueInstance->synthesizer setDelegate:self];
        play = true;
    }
    return queueInstance;
}

-(void)readLast:(NSString*)message withLanguage:(NSString*)language andRate:(float)rate{
    AVSpeechUtterance *utterance = [self createUtteranceWithString:message andLanguage:language andRate:rate];
    [queue addObject:utterance];
    [self next];
}

-(void)readNext:(NSString*)message withLanguage:(NSString*)language andRate:(float)rate andClearQueue:(BOOL)clearQueue{
    if (clearQueue)
        [self clearQueue];
    AVSpeechUtterance *utterance = [self createUtteranceWithString:message andLanguage:language andRate:rate];
    [queue insertObject:utterance atIndex:0];
    [self next];
}

-(void)readImmediately:(NSString*)message withLanguage:(NSString*)language andRate:(float)rate andClearQueue:(BOOL)clearQueue{
    if (clearQueue)
        [self clearQueue];
    [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    AVSpeechUtterance *utterance = [self createUtteranceWithString:message andLanguage:language andRate:rate];
    [queue insertObject:utterance atIndex:0];
    [self next];
    
}

#pragma mark Internal
-(void)next{
    if (play && [queue count] > 0 && ![synthesizer isSpeaking]){
        AVSpeechUtterance *utterance = [queue firstObject];
        [queue removeObjectAtIndex:0];
        [synthesizer speakUtterance:utterance];
    }
}

-(AVSpeechUtterance*)createUtteranceWithString:(NSString*)message andLanguage:(NSString*)language andRate:(float)rate{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:message];
    [utterance setRate:rate];
    [utterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:language]];
    [utterance setPreUtteranceDelay:[self preDelay]];
    [utterance setPostUtteranceDelay:[self postDelay]];
    return utterance;
}

#pragma mark Controls
-(void)resume{
    play = true;
    if (![synthesizer continueSpeaking])
        [self next];
}

-(void)pause{
    [synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    play = false;
}

-(void)pauseAfterCurrent{
    play = false;
}

-(void)stop{
    [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    play = false;
    [self clearQueue];
}

-(void)stopAfterCurrent{
    play = false;
    [self clearQueue];
}

-(void)clearQueue{
    [queue removeAllObjects];
}

#pragma mark AVSpeechSynthesizerDelegate Protocol
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self.delegate speechSynthesizerQueueDidStartTalking:self];
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self.delegate speechSynthesizerQueueDidPauseTalking:self];
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self.delegate speechSynthesizerQueueDidContinueTalking:self];
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self.delegate speechSynthesizerQueueDidCancelTalking:self];
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    [self.delegate speechSynthesizerQueueWillStartTalking:self];
    
}
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self.delegate speechSynthesizerQueueDidFinishTalking:self];
    [self next];
}

@end

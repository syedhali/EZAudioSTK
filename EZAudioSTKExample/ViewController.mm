//
//  ViewController.m
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import "ViewController.h"
#import <EZAudio.h>
#import <STK/SineWave.h>

float const SampleRate = 44100.0f;

using namespace stk;

@interface ViewController ()
@property (nonatomic, assign) SineWave *sineWave;
@end

@implementation ViewController

//------------------------------------------------------------------------------
#pragma mark - Status Bar
//------------------------------------------------------------------------------

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sineWave = new SineWave();
    self.sineWave->setFrequency(400.0f);
    self.sineWave->setSampleRate(SampleRate);
    
    AudioStreamBasicDescription inputFormat = [EZAudioUtilities monoFloatFormatWithSampleRate:SampleRate];
    self.output = [EZOutput outputWithDataSource:self inputFormat:inputFormat];
    self.output.delegate = self;
    
    [self.output startPlayback];
}

//------------------------------------------------------------------------------
#pragma mark - EZOutputDataSource
//------------------------------------------------------------------------------

- (OSStatus)        output:(EZOutput *)output
 shouldFillAudioBufferList:(AudioBufferList *)audioBufferList
        withNumberOfFrames:(UInt32)frames
                 timestamp:(const AudioTimeStamp *)timestamp
{
    float *buffer = (float *)audioBufferList->mBuffers[0].mData;
    for (UInt32 i = 0; i < frames; i++)
    {
        buffer[i] = self.sineWave->tick();
    }
    return noErr;
}

//------------------------------------------------------------------------------
#pragma mark - EZOutputDelegate
//------------------------------------------------------------------------------

- (void)output:(EZOutput *)output playedAudio:(float **)buffer withBufferSize:(UInt32)bufferSize withNumberOfChannels:(UInt32)numberOfChannels
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.plot updateBuffer:buffer[0] withBufferSize:bufferSize];
    });
}

@end

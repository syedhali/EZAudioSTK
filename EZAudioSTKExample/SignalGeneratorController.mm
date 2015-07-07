//
//  ViewController.m
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import "SignalGeneratorController.h"
#import <EZAudio.h>
#import <STK/SineWave.h>

float const SampleRate = 44100.0f;

using namespace stk;

@interface SignalGeneratorController ()
@property (nonatomic, assign) SineWave *sineWave;
@end

@implementation SignalGeneratorController

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
    
    float frequency = 200.0f;
    self.sineWave = new SineWave();
    self.sineWave->setFrequency(frequency);
    self.sineWave->setSampleRate(SampleRate);
    
    AudioStreamBasicDescription inputFormat = [EZAudioUtilities monoFloatFormatWithSampleRate:SampleRate];
    EZOutput *output = [EZOutput sharedOutput];
    [output setInputFormat:inputFormat];
    [output setDataSource:self];
    [output setDelegate: self];
    [output startPlayback];
    
    
    self.playButton.selected = output.isPlaying;
    self.frequencyLabel.text = @(frequency).stringValue;
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

- (void)output:(EZOutput *)output changedPlayingState:(BOOL)isPlaying
{
    [self.playButton setSelected:isPlaying];
}

//------------------------------------------------------------------------------

- (void)output:(EZOutput *)output playedAudio:(float **)buffer withBufferSize:(UInt32)bufferSize withNumberOfChannels:(UInt32)numberOfChannels
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.plot updateBuffer:buffer[0] withBufferSize:bufferSize];
    });
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (void)changedFrequency:(id)sender
{
    float value = [(UISlider *)sender value];
    self.sineWave->setFrequency(value);
    self.frequencyLabel.text = @(value).stringValue;
}

//------------------------------------------------------------------------------

- (void)changedPlayState:(id)sender
{
    EZOutput *output = [EZOutput sharedOutput];
    if ([output isPlaying])
    {
        [output stopPlayback];
    }
    else
    {
        [output startPlayback];
    }
}

@end

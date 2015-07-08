//
//  BaseController.m
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AudioStreamBasicDescription inputFormat = [EZAudioUtilities monoFloatFormatWithSampleRate:SampleRate];
    EZOutput *output = [EZOutput sharedOutput];
    [output setInputFormat:inputFormat];
    [output setDataSource:self];
    [output setDelegate: self];
    
    self.playButton.selected = output.isPlaying;
    self.frequencyLabel.text = @(DefaultFrequency).stringValue;
}

//------------------------------------------------------------------------------

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    EZOutput *output = [EZOutput sharedOutput];
    [output stopPlayback];
    [output setDataSource:nil];
    [output setDelegate:nil];    
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
    //
    // Override in subclass
    //
}

//------------------------------------------------------------------------------

- (void)changedPlayState:(id)sender
{
    EZOutput *output = [EZOutput sharedOutput];
    [output isPlaying] ? [output stopPlayback] : [output startPlayback];
}

//------------------------------------------------------------------------------

- (void)pluck:(id)sender
{
    //
    // Override in subclass
    //
}

@end

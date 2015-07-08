//
//  FMController.m
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import "FMController.h"
#import <STK/FMVoices.h>

using namespace stk;

@interface FMController ()
@property (assign, nonatomic) FMVoices *fm;
@end

@implementation FMController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.fm = new FMVoices();
    self.fm->setFrequency(DefaultFrequency);
    self.fm->noteOn(DefaultFrequency, 1.0f);
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
        buffer[i] = self.fm->tick();
    }
    return noErr;
}

//------------------------------------------------------------------------------
#pragma mark - Action
//------------------------------------------------------------------------------

- (void)changedFrequency:(id)sender
{
    float value = [(UISlider *)sender value];
    self.fm->setFrequency(value);
    self.frequencyLabel.text = @(value).stringValue;
}

//------------------------------------------------------------------------------

- (void)pluck:(id)sender
{
    self.fm->noteOn(self.frequencySlider.value, 1.0f);
}

@end

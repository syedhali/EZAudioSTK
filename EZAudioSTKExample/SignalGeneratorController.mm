//
//  ViewController.m
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import "SignalGeneratorController.h"
#import <STK/SineWave.h>
#import <STK/BlitSquare.h>
#import <STK/BlitSaw.h>

typedef NS_ENUM(NSInteger, SignalGeneratorWaveType)
{
    SignalGeneratorWaveTypeSine,
    SignalGeneratorWaveTypeSquare,
    SignalGeneratorWaveTypeSawtooth,
};

using namespace stk;

@interface SignalGeneratorController ()
@property (assign, nonatomic) BlitSaw *sawToothWave;
@property (assign, nonatomic) BlitSquare *squareWave;
@property (assign, nonatomic) SineWave *sineWave;
@property (assign, nonatomic) SignalGeneratorWaveType type;
@end

@implementation SignalGeneratorController

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sineWave = new SineWave();
    self.sineWave->setFrequency(DefaultFrequency);
    self.sineWave->setSampleRate(SampleRate);
    
    self.squareWave = new BlitSquare();
    self.squareWave->setFrequency(DefaultFrequency);
    self.squareWave->setSampleRate(SampleRate);
    
    self.sawToothWave = new BlitSaw();
    self.sawToothWave->setFrequency(DefaultFrequency);
    self.sawToothWave->setSampleRate(SampleRate);
    
    self.type = SignalGeneratorWaveTypeSine;
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
        switch (self.type)
        {
            case SignalGeneratorWaveTypeSine:
                buffer[i] = self.sineWave->tick();
                break;
                
            case SignalGeneratorWaveTypeSquare:
                buffer[i] = self.squareWave->tick();
                break;
                
            case SignalGeneratorWaveTypeSawtooth:
                buffer[i] = self.sawToothWave->tick();
                break;
                
            default:
                break;
        }
    }
    return noErr;
}

//------------------------------------------------------------------------------
#pragma mark - Actions
//------------------------------------------------------------------------------

- (void)changedFrequency:(id)sender
{
    float value = [(UISlider *)sender value];
    self.sineWave->setFrequency(value);
    self.squareWave->setFrequency(value);
    self.sawToothWave->setFrequency(value);
    self.frequencyLabel.text = @(value).stringValue;
}

//------------------------------------------------------------------------------

- (void)changedWaveshape:(id)sender
{
    SignalGeneratorWaveType type = (SignalGeneratorWaveType)[(UISegmentedControl *)sender selectedSegmentIndex];
    self.type = type;
}

@end

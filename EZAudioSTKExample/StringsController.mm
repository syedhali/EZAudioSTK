//
//  GuitarController.m
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import "StringsController.h"
#import <STK/Guitar.h>
#import <STK/Mandolin.h>
#import <STK/Sitar.h>

typedef NS_ENUM(NSInteger, StringsType)
{
    StringsTypeGuitar,
    StringsTypeMandolin,
    StringsTypeSitar,
};

using namespace stk;

@interface StringsController ()
@property (assign, nonatomic) Guitar *guitar;
@property (assign, nonatomic) Mandolin *mandolin;
@property (assign, nonatomic) Sitar *sitar;
@property (assign, nonatomic) StringsType type;
@end

@implementation StringsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.guitar = new Guitar();
    self.guitar->setFrequency(DefaultFrequency);
    self.guitar->setSampleRate(SampleRate);
    
    self.mandolin = new Mandolin(LowestFrequency);
    self.mandolin->setFrequency(DefaultFrequency);
    self.mandolin->setSampleRate(SampleRate);
    
    self.sitar = new Sitar();
    self.sitar->setFrequency(DefaultFrequency);
    self.sitar->setSampleRate(SampleRate);
    
    self.type = StringsTypeGuitar;
    
    [[EZOutput sharedOutput] startPlayback];
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
            case StringsTypeGuitar:
                buffer[i] = self.guitar->tick();
                break;
            case StringsTypeMandolin:
                buffer[i] = self.mandolin->tick();
                break;
            case StringsTypeSitar:
                buffer[i] = self.sitar->tick();
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
    self.guitar->setFrequency(value);
    self.mandolin->setFrequency(value);
    self.sitar->setFrequency(value);
    self.frequencyLabel.text = @(value).stringValue;
}

//------------------------------------------------------------------------------

- (void)changedStringInstrument:(id)sender
{
    StringsType type = (StringsType)[(UISegmentedControl *)sender selectedSegmentIndex];
    self.type = type;
}

//------------------------------------------------------------------------------

- (void)pluck:(id)sender
{
    self.guitar->noteOn(self.frequencySlider.value, 1.0f);
    self.mandolin->noteOn(self.frequencySlider.value, 1.0f);
    self.sitar->noteOn(self.frequencySlider.value, 1.0f);
}

@end

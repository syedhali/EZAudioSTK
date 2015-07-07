//
//  ViewController.h
//  SignalGeneratorController
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EZAudio.h>

@interface SignalGeneratorController : UIViewController <EZOutputDataSource,
                                                         EZOutputDelegate>

@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (weak, nonatomic) IBOutlet UISlider *frequencySlider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet EZAudioPlotGL *plot;

- (IBAction)changedFrequency:(id)sender;
- (IBAction)changedPlayState:(id)sender;

@end


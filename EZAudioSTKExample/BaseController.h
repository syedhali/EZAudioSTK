//
//  BaseController.h
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import <EZAudio.h>

@interface BaseController : UIViewController <EZOutputDataSource,
                                              EZOutputDelegate>

@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (weak, nonatomic) IBOutlet UISlider *frequencySlider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet EZAudioPlotGL *plot;
@property (weak, nonatomic) IBOutlet UIButton *pluckButton;

- (IBAction)changedFrequency:(id)sender;
- (IBAction)changedPlayState:(id)sender;
- (IBAction)pluck:(id)sender;

@end

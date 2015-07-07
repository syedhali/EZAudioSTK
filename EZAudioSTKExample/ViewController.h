//
//  ViewController.h
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EZAudio.h>

@interface ViewController : UIViewController <EZOutputDataSource,
                                              EZOutputDelegate>

@property (strong, nonatomic)          EZOutput      *output;
@property (weak,   nonatomic) IBOutlet EZAudioPlotGL *plot;

@end


//
//  AppController.m
//  EZAudioSTKExample
//
//  Created by Syed Haris Ali on 7/7/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

#import "AppController.h"
#import "Constants.h"
#import "FMController.h"
#import "StringsController.h"
#import "SignalGeneratorController.h"

NSString * const AppControllerCellIdentifier = @"AppControllerCellIdentifier";
NSString * const FMPushSegueIdentifier = @"FMPushSegueIdentifier";
NSString * const GuitarPushSegueIdentifier = @"StringsPushSegueIdentifier";
NSString * const SignalGeneratorPushSegueIdentifier = @"SignalGeneratorPushSegueIdentifier";

@interface AppControllerItem : NSObject
@property (assign, nonatomic) Class controllerClass;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *segueIdentifier;
@end

@implementation AppControllerItem
@end

@interface AppController ()
@property (strong, nonatomic) NSArray *controllers;
@end

@implementation AppController

- (NSString *)title
{
    return @"EZAudio + STK";
}

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppControllerItem *signalGeneratorItem = [[AppControllerItem alloc] init];
    signalGeneratorItem.name = @"Signal Generator";
    signalGeneratorItem.controllerClass = [SignalGeneratorController class];
    signalGeneratorItem.segueIdentifier = SignalGeneratorPushSegueIdentifier;
    
    AppControllerItem *guitarItem = [[AppControllerItem alloc] init];
    guitarItem.name = @"Strings (Plucked)";
    guitarItem.controllerClass = [StringsController class];
    guitarItem.segueIdentifier = GuitarPushSegueIdentifier;
    
    AppControllerItem *fmItem = [[AppControllerItem alloc] init];
    fmItem.name = @"FM";
    fmItem.controllerClass = [FMController class];
    fmItem.segueIdentifier = FMPushSegueIdentifier;
    
    self.controllers = @[signalGeneratorItem, guitarItem, fmItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.controllers count];
}

//------------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AppControllerCellIdentifier];
    AppControllerItem *item = self.controllers[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

//------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppControllerItem *item = self.controllers[indexPath.row];
    NSString *segueIdentifier = item.segueIdentifier;
    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

@end

//
//  DevicesVC.h
//  kit-iot-wearable-ios
//
//  Created by Ezequiel on 04/02/15.
//  Copyright (c) 2015 Ezequiel França. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SerialGATT.h"
#import "IOTArduino.h"

//@class DevicesVC;

@interface DevicesVC : UIViewController <BTSmartSensorDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) SerialGATT *sensor;
@property (nonatomic, retain) NSMutableArray *peripheralViewControllerArray;
@property (strong, nonatomic) IOTArduino *kitIoT;

- (IBAction)scanHMSoftDevices:(id)sender;

-(void) scanTimer:(NSTimer *)timer;

@property (weak, nonatomic) IBOutlet UITableView *btHMSoftTableView;
@property (weak, nonatomic) IBOutlet UIButton *Scan;

@end
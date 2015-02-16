//
//  ComandosVC.h
//  kit-iot-wearable-ios
//
//  Created by Ezequiel on 04/02/15.
//  Copyright (c) 2015 Ezequiel França. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SerialGATT.h"

#define RSSI_THRESHOLD -60
#define WARNING_MESSAGE @"z"

@class CBPeripheral;
@class SerialGATT;

@interface ComandosVC : UIViewController<BTSmartSensorDelegate>

@property (strong, nonatomic) CBPeripheral *peripheral;
@property (strong, nonatomic) SerialGATT *sensor;

//@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSMutableArray *rssi_container;

@property (weak, nonatomic) IBOutlet UILabel *HMSoftUUID;

- (IBAction)ledAzul:(id)sender;
- (IBAction)ledVermelho:(id)sender;
- (IBAction)ledVerde:(id)sender;
- (IBAction)marchaImperial:(id)sender;



@property (weak, nonatomic) IBOutlet UITextView *tvRecv;
@property (weak, nonatomic) IBOutlet UILabel *lbDevice;



@end
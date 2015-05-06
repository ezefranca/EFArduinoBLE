//
//  IOTArduino.h
//  kit-iot-example
//
//  Created by Ezequiel on 06/05/15.
//  Copyright (c) 2015 Ezequiel França. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SerialGATT.h"

#define RSSI_THRESHOLD -60
#define WARNING_MESSAGE @"z"

@class CBPeripheral;
@class SerialGATT;

@protocol IOTArduinoDelegate;

@interface IOTArduino : NSObject <BTSmartSensorDelegate>

@property (strong, nonatomic) CBPeripheral *peripheral;
@property (strong, nonatomic) SerialGATT *sensor;
//@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSMutableArray *rssi_container;
@property (strong) id <IOTArduinoDelegate> delegate;

-(void)sendCommandToArduino: (NSString *)command;

@end

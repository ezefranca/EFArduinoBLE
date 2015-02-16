//
//  SerialGATT.h
//  HMSoft
//
//  Created by HMSofts on 7/13/12.
//  Copyright (c) 2012 jnhuamao.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define SERVICE_UUID     0xFFE0
#define CHAR_UUID        0xFFE1

@protocol BTSmartSensorDelegate

@optional
- (void) peripheralFound:(CBPeripheral *)peripheral;
- (void) serialGATTCharValueUpdated: (NSString *)UUID value: (NSData *)data;
- (void) setConnect;
- (void) setDisconnect;
@end

@interface SerialGATT : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate> {
    
}

@property (nonatomic, assign) id <BTSmartSensorDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *peripherals;
@property (strong, nonatomic) CBCentralManager *manager;
@property (strong, nonatomic) CBPeripheral *activePeripheral;


#pragma mark - Methods for controlling the HMSoft Sensor
-(void) setup; //controller setup
-(void) stopScan;

-(int) findHMSoftPeripherals:(int)timeout;
-(void) scanTimer: (NSTimer *)timer;

-(void) connect: (CBPeripheral *)peripheral;
-(void) disconnect: (CBPeripheral *)peripheral;

-(void) write:(CBPeripheral *)peripheral data:(NSData *)data;
-(void) read:(CBPeripheral *)peripheral;
-(void) notify:(CBPeripheral *)peripheral on:(BOOL)on;


- (void) printPeripheralInfo:(CBPeripheral*)peripheral;

-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on;
-(UInt16) swap:(UInt16)s;

-(CBService *) findServiceFromUUIDEx:(CBUUID *)UUID p:(CBPeripheral *)p;
-(CBCharacteristic *) findCharacteristicFromUUIDEx:(CBUUID *)UUID service:(CBService*)service;
-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data;
-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p;

@end

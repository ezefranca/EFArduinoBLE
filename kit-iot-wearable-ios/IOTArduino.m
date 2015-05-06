//
//  IOTArduino.m
//  kit-iot-example
//
//  Created by Ezequiel on 06/05/15.
//  Copyright (c) 2015 Ezequiel França. All rights reserved.
//

#import "IOTArduino.h"

@implementation IOTArduino

@synthesize rssi_container;
//@synthesize timer;
@synthesize peripheral;
@synthesize sensor;

- (id) init
{
    if (self = [super init])
    {
        return self;
    }
    return self;
}

#pragma MARK - BLUETOOTH AND CONNECTION THINGS

//recv data
-(void) serialGATTCharValueUpdated:(NSString *)UUID value:(NSData *)data
{
    NSString *value = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"Valor Recebido %@", value);
}

//send data
-(void)sendCommandToArduino: (NSString *)command{    
    //adjust string to send
    command = [NSString stringWithFormat:@"%@\r\n", command];
    NSData *data = [command dataUsingEncoding:[NSString defaultCStringEncoding]];
    if(data.length > 20)
    {
        int i = 0;
        while ((i + 1) * 20 <= data.length) {
            NSData *dataSend = [data subdataWithRange:NSMakeRange(i * 20, 20)];
            [sensor write:sensor.activePeripheral data:dataSend];
            i++;
        }
        i = data.length % 20;
        if(i > 0)
        {
            NSData *dataSend = [data subdataWithRange:NSMakeRange(data.length - i, i)];
            [sensor write:sensor.activePeripheral data:dataSend];
        }
        
    }else
    {
        //NSData *data = [MsgToArduino.text dataUsingEncoding:[NSString defaultCStringEncoding]];
        [sensor write:sensor.activePeripheral data:data];
    }
    
}
@end

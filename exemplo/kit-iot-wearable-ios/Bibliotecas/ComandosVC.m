//
//  ComandosVC.m
//  kit-iot-wearable-ios
//
//  Created by Ezequiel on 04/02/15.
//  Copyright (c) 2015 Ezequiel França. All rights reserved.
//
#import "ComandosVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import "QuartzCore/QuartzCore.h"

@interface ComandosVC ()

@end

@implementation ComandosVC
@synthesize HMSoftUUID;
@synthesize tvRecv;
@synthesize lbDevice;

@synthesize rssi_container;


//@synthesize timer;

@synthesize peripheral;
@synthesize sensor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = self.sensor.activePeripheral.name;
    self.sensor.delegate = self;
    
    tvRecv.layer.borderWidth = 1;
    tvRecv.layer.borderColor = [[UIColor grayColor] CGColor];
    tvRecv.layer.cornerRadius = 8;
    tvRecv.layer.masksToBounds = YES;
    
    HMSoftUUID.layer.borderWidth = 1;
    HMSoftUUID.layer.borderColor = [[UIColor grayColor] CGColor];
    HMSoftUUID.layer.cornerRadius = 8;
    HMSoftUUID.layer.masksToBounds = YES;
    
    lbDevice.layer.borderWidth = 1;
    lbDevice.layer.borderColor = [[UIColor grayColor] CGColor];
    lbDevice.layer.cornerRadius = 8;
    lbDevice.layer.masksToBounds = YES;
}

- (void)viewDidUnload
{
    [self setHMSoftUUID:nil];
  //  [self setMsgToArduino:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//recv data
-(void) serialGATTCharValueUpdated:(NSString *)UUID value:(NSData *)data
{
    NSString *value = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    tvRecv.text= [tvRecv.text stringByAppendingString:value];
}


//send data
- (IBAction)ledAzul:(id)sender {
    [self sendToArduino:@"#LR0000"];
    [self sendToArduino:@"#LG0000"];
    [self sendToArduino:@"#LB0255"];
}

- (IBAction)ledVermelho:(id)sender {
    [self sendToArduino:@"#LB0000"];
    [self sendToArduino:@"#LG0000"];
    [self sendToArduino:@"#LR0255"];
}

- (IBAction)ledVerde:(id)sender {
    [self sendToArduino:@"#LR0000"];
    [self sendToArduino:@"#LB0000"];
    [self sendToArduino:@"#LG0255"];
}

- (IBAction)marchaImperial:(id)sender {
    [self sendToArduino:@"#PM456"];
}

-(void)sendToArduino: (NSString *)command{
    if (DEBUG) {
    NSLog(@"Enviar para arduino %@", command);
    }
    
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


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);
    NSTimeInterval anm = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:anm];
    if(offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([[[UIDevice currentDevice] systemVersion]floatValue] >= 7)
    {
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }else
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)setConnect
{
    CFStringRef s = CFUUIDCreateString(kCFAllocatorDefault, (__bridge CFUUIDRef )sensor.activePeripheral.identifier);
    HMSoftUUID.text = (__bridge NSString*)s;
    tvRecv.text = @"OK+CONN";
}

-(void)setDisconnect
{
    tvRecv.text= [tvRecv.text stringByAppendingString:@"OK+LOST"];
}


@end


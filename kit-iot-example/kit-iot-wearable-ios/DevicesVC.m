//
//  BLEDeviceViewController.h
//  HMSoft
//
//  Created by HMSofts on 7/13/12.
//  Copyright (c) 2012 jnhuamao.cn. All rights reserved.
//

#import "DevicesVC.h"

@interface DevicesVC ()

@end

@implementation DevicesVC

@synthesize btHMSoftTableView;
@synthesize Scan;
@synthesize sensor;
@synthesize peripheralViewControllerArray;
@synthesize kitIoT;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"kit-iot-wearable";
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    sensor = [[SerialGATT alloc] init];
    [sensor setup];
    sensor.delegate = self;
    
    peripheralViewControllerArray = [[NSMutableArray alloc] init];
    kitIoT = [[IOTArduino alloc]init];
}

- (void)viewDidUnload
{
    [self setBtHMSoftTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)scanHMSoftDevices:(id)sender {
    if ([sensor activePeripheral]) {
        if (sensor.activePeripheral.state == CBPeripheralStateConnected) {
            [sensor.manager cancelPeripheralConnection:sensor.activePeripheral];
            sensor.activePeripheral = nil;
        }
    }
    
    if ([sensor peripherals]) {
        sensor.peripherals = nil;
        [peripheralViewControllerArray removeAllObjects];
        [btHMSoftTableView reloadData];
    }
    
    sensor.delegate = self;
    printf("now we are searching device...\n");
    [Scan setTitle:@"Scaning" forState:UIControlStateNormal];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scanTimer:) userInfo:nil repeats:NO];
    
    [sensor findHMSoftPeripherals:5];
}

/*
 * scanTimer
 * when scanHMSoftDevices is timeout, this function will be called
 *
 */
-(void) scanTimer:(NSTimer *)timer
{
    [Scan setTitle:@"Scan" forState:UIControlStateNormal];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.peripheralViewControllerArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];

    kitIoT  = [peripheralViewControllerArray objectAtIndex:row];
    
    if (sensor.activePeripheral && sensor.activePeripheral != kitIoT.peripheral) {
        [sensor disconnect:sensor.activePeripheral];
    }
    
    sensor.activePeripheral = kitIoT.peripheral;
    [sensor connect:sensor.activePeripheral];
    [sensor stopScan];
    
    [Scan setTitle:@"Scan" forState:UIControlStateNormal];
   // [self.navigationController pushViewController:controller animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"peripheral";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    // Configure the cell
    NSUInteger row = [indexPath row];
    kitIoT = [peripheralViewControllerArray objectAtIndex:row];
    CBPeripheral *peripheral = [kitIoT peripheral];
    cell.textLabel.text = peripheral.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:<#(NSString *), ...#>
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}


#pragma mark - HMSoftSensorDelegate
-(void)sensorReady
{
    //TODO: it seems useless right now.
}

-(void)peripheralFound:(CBPeripheral *)peripheral
{
    IOTArduino *kitNew = [[IOTArduino alloc]init];
    kitNew.peripheral = peripheral;
    kitNew.sensor = sensor;
    [peripheralViewControllerArray addObject:kitNew];
    [btHMSoftTableView reloadData];
}

-(void)setConnect
{
    //CFStringRef s = CFUUIDCreateString(kCFAllocatorDefault, (__bridge CFUUIDRef )sensor.activePeripheral.identifier);
    NSLog(@"OK+CONN"); // %@", s);
}

-(void)setDisconnect
{
    NSLog(@"OK+LOST");
}

@end

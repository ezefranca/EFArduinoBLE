//
//  ViewController.m
//  kit-iot-example
//
//  Created by Ezequiel on 06/05/15.
//  Copyright (c) 2015 Ezequiel França. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize iotKit;


#pragma MARK - Custom initialization

- (id)initWithKit:(IOTArduino *) kit{

    self = [super init];
    if(self) {
        iotKit = kit;
        NSLog(@"_init: %@", self);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendToArduino:(id)sender {
    [iotKit sendCommandToArduino:@"#LR0000"];
    [iotKit sendCommandToArduino:@"#LG0000"];
    [iotKit sendCommandToArduino:@"#LB0255"];
}
@end

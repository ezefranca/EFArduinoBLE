//
//  ViewController.h
//  kit-iot-example
//
//  Created by Ezequiel on 06/05/15.
//  Copyright (c) 2015 Ezequiel França. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOTArduino.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IOTArduino *iotKit;
@property (strong, nonatomic) IBOutlet UITextField *commandLabel;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)sendToArduino:(id)sender;

@end


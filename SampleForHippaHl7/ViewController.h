//
//  ViewController.h
//  SampleForHippaHl7
//
//  Created by Sandeep on 12/6/13.
//  Copyright (c) 2013 Sandeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController<ServerManagerDelegate,UITextFieldDelegate>
{
    WebServices *webServerObj;
    AppDelegate *ObjAppDelegate;
}
@property (weak, nonatomic) IBOutlet UITextField *txtLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtpassword;
- (IBAction)ActionLogin:(id)sender;
@end

//
//  AppDelegate.h
//  SampleForHippaHl7
//
//  Created by Sandeep on 12/6/13.
//  Copyright (c) 2013 Sandeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityAlertViewForIOS7.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
ActivityAlertViewForIOS7 *AnimatedActivityalerttype;
}

@property (strong, nonatomic) UIWindow *window;
-(void)ShowLoader;
-(void)stopLoader;
@end

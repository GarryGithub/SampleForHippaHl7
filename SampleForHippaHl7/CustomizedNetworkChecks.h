//
//  CustomizedNetworkChecks.h
//  UbiCabs
//
//  Created by Gaurav Passi on 1/19/11.
//  Copyright 2011 seasia consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CustomizedNetworkChecks : NSObject {
	Reachability* hostReach;
    Reachability* internetReach;
	int  hostIsReachable;// 0 means not reachable  1 r by WWan  2r by Wifi
	int internatIsReachable;// 0 means not reachable  1 r by WWan  2r by Wifi
    NSString *hostURL;

}

@property 	int hostIsReachable;
@property int internatIsReachable;
-(void)startObtainingNetworkChangeNotificationWithHostName:(NSString *)parHostName;
- (void) updateInterfaceWithReachability: (Reachability*) curReach;

@end

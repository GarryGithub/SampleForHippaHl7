//
//  CustomizedNetworkChecks.m
//  UbiCabs
//
//  Created by Gaurav Passi on 1/19/11.
//  Copyright 2011 seasia consulting. All rights reserved.
//

#import "CustomizedNetworkChecks.h"
#define kGoogleUrl  @"www.apple.com" 
#import "Reachability.h"

@implementation CustomizedNetworkChecks

@synthesize hostIsReachable;
@synthesize internatIsReachable;

-(id)init
{
	if (self=[super init]) {
				
	}
	return self;
}

-(void)startObtainingNetworkChangeNotificationWithHostName:(NSString *)parHostName
{
	
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
	
	hostURL=parHostName;
	// internet reachability
	internetReach=[Reachability reachabilityForInternetConnection];
	[self updateInterfaceWithReachability: internetReach];
	
}
-(void)performInternetcheckInBackground
{
	// internet reachability
    internetReach = [[Reachability reachabilityWithHostName: kGoogleUrl] retain];
	[self updateInterfaceWithReachability: internetReach];
	
	//Change the host name here to change the server your monitoring
	
	hostReach = [[Reachability reachabilityWithHostName:hostURL] retain];
	[self updateInterfaceWithReachability: hostReach];
	
	
}
-(void)startObtainingNetworkChangeNotificationWithIpAddress:(NSString *)parIpAddress onPort:(NSString *)parPort
{
	
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
	
	
}
- (void) configurereachability: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    BOOL connectionRequired= [curReach connectionRequired];
    NSString* statusString= @"";
    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = @"Access Not Available";
            //Minor interface detail- connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
            connectionRequired= NO;  
			internatIsReachable=YES;
            break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = @"Reachable WWAN";
            break;
        }
        case ReachableViaWiFi:
        {
			statusString= @"Reachable WiFi";
            break;
		}
    }
    if(connectionRequired)
    {
        statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
		//NSLog(@"%@",statusString);
    }
	
   // textField.text= statusString;
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
		NSString* statusString= @"";
	if(curReach == internetReach)
	{	
		NetworkStatus netStatus = [curReach currentReachabilityStatus];

		switch (netStatus)
		{
			case NotReachable:
			{
				statusString = @"Access Not Available";
				//connectionRequired= NO;  
				internatIsReachable=0;
				break;
			}
				
			case ReachableViaWWAN:
			{
				statusString = @"Reachable WWAN";
				
				internatIsReachable=1;
				break;
			}
			case ReachableViaWiFi:
			{
				statusString= @"Reachable WiFi";
				internatIsReachable=2;
				
				break;
			}
		}
		//NSLog(@"Internet %@ %d",statusString,internatIsReachable);
	}
    if(curReach == hostReach)
	{
		NetworkStatus netStatus = [curReach currentReachabilityStatus];
		BOOL connectionRequired= [curReach connectionRequired];
	
		switch (netStatus)
		{
			case NotReachable:
			{
				statusString = @"Access Not Available";
				hostIsReachable=0;
				break;
			}
				
			case ReachableViaWWAN:
			{
				statusString = @"Reachable WWAN";
				hostIsReachable=1;
				
				break;
			}
			case ReachableViaWiFi:
			{
				statusString= @"Reachable WiFi";
				hostIsReachable=2;
				break;
			}
		}
		//[id networkReachabiltyUpdationClass];
       
        if(connectionRequired)
        {
            //NSLog(@"Cellular data network is available.\n  Internet traffic will be routed through it after a connection is established.");
        }
        else
        {
            //NSLog(@"Cellular data network is active.\n  Internet traffic will be routed through it.");
        }
		//NSLog(@"Internet %@ %d",statusString,internatIsReachable);

       // summaryLabel.text= baseLabel;
    }
	//NSLog(@"%@",statusString);
//	[[NSNotificationCenter defaultCenter] postNotificationName: kCustomizedReachabilityChangedNotification object:self];

}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}

@end

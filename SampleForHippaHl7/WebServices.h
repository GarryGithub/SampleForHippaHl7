//
//  WebServices.h

//
//  Copyright (c) 2012 yyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJsonParser.h"


@class WebServices;
@class Reachability;
Reachability* internetReach;
SBJsonParser *_JSONParser;

// Protocols methods of webService class
@protocol ServerManagerDelegate
@optional

//*************************** Delegates Methods ***************************
-(void)loginUser:(WebServices*)invocation withResponse:(NSDictionary*)serviceResponse;


-(void)serverError:(NSString*)str;
@end


@interface WebServices : NSObject

@property(nonatomic,retain)id <ServerManagerDelegate>delegate;

- (void)LoginService:(NSMutableDictionary *)dict;

-(BOOL)isInternetAvailable;
-(void)internetNotAvailble;

@end
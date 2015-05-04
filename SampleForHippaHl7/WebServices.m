                                //
//  WebServices.m
//  RealEstate
//
//  Created by Abhishek Gangdeb on 12/27/12.
//  Copyright (c) 2012 yyy. All rights reserved.
//

#import "WebServices.h"
#import "Reachability.h"
#import "SBJsonWriter.h"
#import "SBJSON.h"

typedef enum {
    LoginService,
    
} serviceCheck;

NSMutableData *webData;

@interface WebServices()
{
    NSMutableData *receivedData;
    int checkServiceType;
}
@end

@implementation WebServices
@synthesize delegate;

-(id)init
{
    self = [super init];
    if (self) {
        [self initializeGlobalControllers];
        
    }
    return self;
}

#pragma mark - Login Service
- (void)LoginService:(NSMutableDictionary *)dict{
    
    checkServiceType = LoginService;
    /*
     *  If internet is available
     */
    if([self isInternetAvailable])
    {
        //NSLog(@"Yes internet is there.");
        NSString *urlString = [NSString stringWithFormat:@"http://72.167.54.109/RealEstate/UserLogin.svc/Login"];
        [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; // remove white spaces from url
        NSURL *url = [NSURL URLWithString:urlString];
        //NSLog(@"url: %@",url);
        
        NSMutableDictionary *requestDict = [[NSMutableDictionary alloc] init];
        requestDict =dict;
        NSString *jsonRequest=@"";
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        if (!jsonData)
        { //NSLog(@"%@",error.description);
        }
        else
        {
            jsonRequest = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]; }
        
        //NSLog(@"jsonRequest is %@", requestDict);
        
        NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: requestData];
        
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if(connection)
        {
            if(webData==nil)
            {
                webData = [[NSMutableData data] retain];
            }
            else
            {
                webData=nil;
                webData = [[NSMutableData data] retain];
                
            }
            
            //NSLog(@"server connection made");
        }
        
        else
        {
            //NSLog(@"connection is NULL");
        }
    }
    /*
     *  If internet is not available
     */
    
    else
    {
        
        [self internetNotAvailble];
        
    }
}

#pragma mark - Response and Error Methods
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
	
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
	
	//[Appdelegate stopLoader];
    
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Check your network settings" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	
	
	[connection release];
    
    if(webData!=nil)
        [webData release];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    //NSLog(@"DONE. Received Bytes: %d", [webData length]);
    
	NSString *temp=[[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"Response:%@",temp);
	
    SBJSON *json = [[SBJSON alloc]init];
    NSDictionary *dict = (NSDictionary*)[json objectWithString:temp error:nil];
    
    //NSLog(@"dict: %@",dict);
    
        if (checkServiceType == LoginService){
        [self.delegate loginUser:self withResponse:dict];
        //[Appdelegate stopLoader];
    }
}

#pragma mark - Internet Check
-(void)internetNotAvailble
{
    //[Appdelegate stopLoader];
    //NSLog(@"Internet is not there.");
    
    
}



#pragma mark ----Reachibility Check
-(BOOL)isInternetAvailable
{
    internetReach = [Reachability reachabilityForInternetConnection];
    
    return ([self updateInterfaceWithReachability:internetReach]);
}

-(BOOL) updateInterfaceWithReachability: (Reachability*) curReach
{
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
    //    BOOL connectionRequired= [curReach connectionRequired];
	BOOL connectionStatus = NO;
	
    switch (netStatus)
    {
        case NotReachable:
        {
            //   connectionRequired = NO;
			connectionStatus = NO;
            break;
        }
            
        case ReachableViaWWAN:
        {
			connectionStatus = YES;
			break;
        }
        case ReachableViaWiFi:
        {
			connectionStatus = YES;
			break;
		}
    }
	return connectionStatus;
}

-(void)initializeGlobalControllers
{
	if(!_JSONParser)
		_JSONParser = [[SBJsonParser alloc]init];
}

@end
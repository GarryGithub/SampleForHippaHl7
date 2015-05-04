//
//  ViewController.m
//  SampleForHippaHl7
//
//  Created by Sandeep on 12/6/13.
//  Copyright (c) 2013 Sandeep. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    webServerObj=[[WebServices alloc]init];
    webServerObj.delegate=self;
    
    ObjAppDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    _txtLogin.text=@"vpandit@seasiaconsulting.com";
    _txtpassword.text=@"123456";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ActionLogin:(id)sender {
    
    [_txtLogin resignFirstResponder];
    [_txtpassword resignFirstResponder];
    webServerObj = [[WebServices alloc]init];
    webServerObj.delegate = self;
    
    // app.loginnamestringgloble=_txtLogin.text;
    //app.passwordglobal=_txtpassword.text;
    
    _txtLogin.text=[_txtLogin.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    _txtpassword.text=[_txtpassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if([_txtLogin.text length]==0 && [_txtpassword.text length]==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Login" message:@"Please Enter Email And Password." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        // [AnimatedActivityalerttype close];
        
    }
    else if([_txtLogin.text length]==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Login" message:@"Please Enter Username." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        //[AnimatedActivityalerttype close];
        
    }
    else if([_txtpassword.text length]==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Login" message:@"Please Enter Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        //[AnimatedActivityalerttype close];
        
    }
    //        else if(![Appdelegate validateEmail:_txtLogin.text]){
    //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Real Estate"
    //                                                           message:validEmailId
    //                                                          delegate:self
    //                                                 cancelButtonTitle:@"OK"
    //                                                 otherButtonTitles: nil];
    //            // alert.tag = emailIdIsNotValid;
    //            [alert show];
    //            [alert release];
    //            [email_txt becomeFirstResponder];
    //
    //        }
    
    
    else
    {
        NSMutableDictionary * LoginDetails= [[NSMutableDictionary alloc] init];
        
        [ObjAppDelegate  ShowLoader];
        
        [LoginDetails setObject:_txtLogin.text forKey:@"UserName"];
        [LoginDetails setObject:_txtpassword.text forKey:@"Password"];
        if([webServerObj isInternetAvailable])
        {
            [webServerObj LoginService:LoginDetails];
        }
        else
        {
            [ObjAppDelegate stopLoader];
            UIAlertView *alert_view1=[[UIAlertView alloc]initWithTitle:@"Real Estate" message:@"Internet Not Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert_view1.tag=495;
            [alert_view1 show];
            
            
            
            //[self performSelector:@selector(GetLoginTableData)];
        }
        
    }
}

-(void)loginUser:(WebServices *)invocation withResponse:(NSDictionary *)serviceResponse{
    
    [ObjAppDelegate stopLoader];
    
    if ([serviceResponse count]>0 && ![serviceResponse isKindOfClass:[NSNull class]]) {
        if ([[serviceResponse objectForKey:@"LoginResult"]count]>0 &&![serviceResponse isKindOfClass:[NSNull class]]) {
            if ([[[[serviceResponse objectForKey:@"LoginResult"]objectAtIndex:0]objectForKey:@"Status"]intValue]==1) {
                
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Login" message:@"Login Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                [ObjAppDelegate stopLoader];
                
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Login" message:@"The Login user or password supplied is incorrect,please try again" delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles:@"Email Password",@"Signup",nil];
                
                [alert show];
                
            }
            
            
            
            
        }
    }
}
#pragma UItextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

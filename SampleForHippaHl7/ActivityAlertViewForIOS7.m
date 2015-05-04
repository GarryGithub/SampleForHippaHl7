//
//  ActivityAlertViewForIOS7.m
//  GetBodyBeautiful
//
//  Created by Pooja Rana on 21/10/13.
//  Copyright (c) 2013 skumar. All rights reserved.
//

#import "ActivityAlertViewForIOS7.h"


@implementation ActivityAlertViewForIOS7


+ (ActivityAlertViewForIOS7 *)instance {
    static ActivityAlertViewForIOS7 *instance = nil;
    
    if (instance == nil) {
        
        
         instance = [[ActivityAlertViewForIOS7 alloc] initWithFrame:CGRectMake(50,234, 220,100)];
        }
    
    return instance;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *msgLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,10,190,50)];
        msgLabel.backgroundColor=[UIColor clearColor];
        msgLabel.text=@"Processing Please Wait..";
        [self addSubview:msgLabel];
        
        
        UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(90,60,30,30)];
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activityIndicator startAnimating];
        [self addSubview:activityIndicator];
        
        // First, we style the dialog to match the iOS7 UIAlertView >>>
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0f] CGColor],
                           (id)[[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0f] CGColor],
                           (id)[[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0f] CGColor],
                           nil];
        
        gradient.cornerRadius = 7;
        [self.layer insertSublayer:gradient atIndex:0];
        
        self.layer.cornerRadius = 7;
        self.layer.borderColor = [[UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f] CGColor];
        self.layer.borderWidth = 1;
        self.layer.shadowRadius = 12;
        self.layer.shadowOpacity = 0.1f;
        self.layer.shadowOffset = CGSizeMake(- 6,- 6);
        
        
        self.layer.opacity = 0.5f;
        self.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];

    }
    return self;
}

-(void)show
{
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         self.layer.opacity = 1.0f;
                         self.layer.transform = CATransform3DMakeScale(1, 1, 1);
					 }
					 completion:NULL
     ];
}

- (void)close
{
    self.layer.transform = CATransform3DMakeScale(1, 1, 1);
    self.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
					 animations:^{
						 self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.layer.transform = CATransform3DMakeScale(0.6f, 0.6f, 1.0);
                         self.layer.opacity = 0.0f;
					 }
					 completion:^(BOOL finished) {
                         [self removeFromSuperview];
					 }
	 ];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

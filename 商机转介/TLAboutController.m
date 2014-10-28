//
//  TLAboutController.m
//  TongLian
//
//  Created by mac on 13-11-7.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLAboutController.h"

@interface TLAboutController ()

@end

@implementation TLAboutController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *ss = [[[NSBundle mainBundle]infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    //NSLog(@"bundlepath==%@",[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]);
    NSString *s = [NSString stringWithFormat:@"%@",ss];
    [self.version setText:s];
	// Do any additional setup after loading the view.
}
-(IBAction)discribe:(id)sender{
    UIStoryboard *storyboard = nil;
    storyboard = [UIStoryboard storyboardWithName:@"IPhone4MainStoryboard" bundle:nil ];
    TLAdvertisementViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"advertisement"];
    [viewcontroller setAdvertiseID: @"9"];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
-(IBAction)about:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"版权所有：互动助手开发组" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
-(IBAction)phone:(id)sender{
    NSString *phone = @"55199806";
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

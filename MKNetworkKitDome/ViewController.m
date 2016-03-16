//
//  ViewController.m
//  MKNetworkKitDome
//
//  Created by ttlgz-0022 on 16/3/16.
//  Copyright © 2016年 Transaction Technologies Limited. All rights reserved.
//

#import "ViewController.h"
#import "MKNetworkKit.h"
@interface ViewController ()
{
    MKNetworkHost * engine;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 30);
    button.center = self.view.center;
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 20, 50, 50);
    [button2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(logoutButton:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)buttonAction:(UIButton *)button{
    NSLog(@"buttonAction");
    NSMutableDictionary *loginParams = [[NSMutableDictionary alloc] init];
    [loginParams setObject:@"123456" forKey:@"password"];
    [loginParams setObject:@"yy@163.com" forKey:@"username"];
    [loginParams setObject:@"user" forKey:@"app"];
    
    engine = [[MKNetworkHost alloc] initWithHostName:@"192.168.3.88:9988" ];
    
    NSString * path = @"/api/1.0/user/login.json";
    [engine.defaultHeaders setValue:@"application/json" forKey:@"Content-Type"];
    
    MKNetworkRequest * op = [engine requestWithPath:path params:loginParams httpMethod:@"POST" body:nil ssl:NO];
    [op addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        NSLog(@"response2:%@",completedRequest.responseAsJSON);
        NSLog(@"%@",completedRequest.response);
        
        if (completedRequest.state == MKNKRequestStateCompleted) {
            NSLog(@"MKNKRequestStateCompleted");
            [[NSUserDefaults standardUserDefaults] setObject:[[completedRequest.responseAsJSON objectForKey:@"result"] objectForKey:@"token"] forKey:@"kToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else if(completedRequest.state == MKNKRequestStateError){
            NSLog(@"MKNKRequestStateError");
        }else if(completedRequest.state == MKNKRequestStateCancelled){
            NSLog(@"MKNKRequestStateCancelled");
        }
    }];
    [engine startRequest:op];
}

- (void)logoutButton:(UIButton *)button{
    engine = [[MKNetworkHost alloc] initWithHostName:@"192.168.3.88:9988" ];
    
    NSString * path = @"/api/1.0/user/logout.json";
    
    MKNetworkRequest * op = [engine requestWithPath:path params:nil httpMethod:@"POST" body:nil ssl:NO];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"]) {
        NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"];
        [op addHeaders:@{@"X-CSRF-Token":str}];
    }
    
    
    [op addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        NSLog(@"response2:%@",completedRequest.responseAsJSON);
        if (completedRequest.state == MKNKRequestStateCompleted) {
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"MKNKRequestStateCompleted");
        }else if(completedRequest.state == MKNKRequestStateError){
            NSLog(@"MKNKRequestStateError");
        }else if(completedRequest.state == MKNKRequestStateCancelled){
            NSLog(@"MKNKRequestStateCancelled");
        }
    }];
    [engine startRequest:op];
}

@end

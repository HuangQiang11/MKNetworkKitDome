//
//  ViewController.m
//  MKNetworkKitDome
//
//  Created by ttlgz-0022 on 16/3/16.
//  Copyright © 2016年 Transaction Technologies Limited. All rights reserved.
//

#import "ViewController.h"
#import "MKTool.h"
@interface ViewController ()<MKNetworkToolDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}


- (void)PostAction:(UIButton *)button{
    [[MKTool shareMKNetworkHost] loadDataWithParams:nil url:@"" delegage:self httpMethod:@"POST"];
}

- (void)GetAction:(UIButton *)button{
    [[MKTool shareMKNetworkHost] loadDataWithParams:nil url:@"" delegage:self httpMethod:@"GET"];
}

- (void)MKNetworkRequested:(MKNetworkRequest *)completedRequest{

}

- (void)MKNetworkRequestFiled:(MKNetworkRequest *)completeRequest{

}

@end

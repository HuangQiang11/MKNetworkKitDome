//
//  MKTool.m
//  MKNetworkKitDome
//
//  Created by ttlgz-0022 on 16/3/16.
//  Copyright © 2016年 Transaction Technologies Limited. All rights reserved.
//

#import "MKTool.h"
#define kHostName @""
@implementation MKTool
+ (MKNetworkHost*)shareMKNetworkHost{
    static dispatch_once_t once;
    static MKNetworkHost * tool;
    dispatch_once(&once, ^{
        tool = [[MKNetworkHost alloc] init];
    });
    return tool;
}

- (instancetype)init{
    if (self = [super init]) {
        self.hostName = kHostName;
    }
    return self;
}
@end

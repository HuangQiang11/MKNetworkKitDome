//
//  MKTool.m
//  MKNetworkKitDome
//
//  Created by ttlgz-0022 on 16/3/16.
//  Copyright © 2016年 Transaction Technologies Limited. All rights reserved.
//

#import "MKTool.h"

// without http://
#define kHostName @""

@implementation MKTool
static MKTool * tool;

+ (MKTool*)shareMKNetworkHost{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[MKTool alloc] init];
    });
    return tool;
}

- (instancetype)init{
    if (self = [super init]) {
        self.hostName = kHostName;
    }
    return self;
}

- (void)loadDataWithParams:(NSMutableDictionary *)params url:(NSString *)url delegage:(id<MKNetworkToolDelegate>)delegate httpMethod:(NSString *)mehtod{
    //*  The ssl option when true changes the URL to https.
    //*  The ssl option when false changes the URL to http.
    MKNetworkRequest * request = [tool requestWithPath:url params:params httpMethod:mehtod body:nil ssl:NO];
    //add http header if need
    // request addHeaders:<#(NSDictionary *)#>
    [request addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        if (completedRequest.state == MKNKRequestStateCompleted) {
            [self requestWith:completedRequest delegate:delegate];
        }else if(completedRequest.state == MKNKRequestStateError){
            [self requestFailWith:completedRequest delegate:delegate];
        }
    }];
    [tool startRequest:request];
}

- (void)requestWith:(MKNetworkRequest *)completedRequest delegate:(id<MKNetworkToolDelegate>)delegate{
    NSLog(@"%@ %@ %@",completedRequest.response.URL.absoluteString,[delegate class],completedRequest.responseAsJSON);
    [delegate MKNetworkRequested:completedRequest];
}

- (void)requestFailWith:(MKNetworkRequest *)completedRequest delegate:(id<MKNetworkToolDelegate>)delegate{
    NSLog(@"%@ %@ %@ %@",completedRequest.response.URL.absoluteString,[delegate class],completedRequest.error,completedRequest.responseAsJSON);
    [delegate MKNetworkRequestFiled:completedRequest];
}

@end

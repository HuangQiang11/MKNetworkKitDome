//
//  MKTool.h
//  MKNetworkKitDome
//
//  Created by ttlgz-0022 on 16/3/16.
//  Copyright © 2016年 Transaction Technologies Limited. All rights reserved.
//

#import "MKNetworkHost.h"

@protocol MKNetworkToolDelegate <NSObject>

- (void)MKNetworkRequested:(MKNetworkRequest*)completedRequest;
- (void)MKNetworkRequestFiled:(MKNetworkRequest *)completeRequest;

@end
@interface MKTool : MKNetworkHost
+ (MKTool*)shareMKNetworkHost;
- (void)loadDataWithParams:(NSMutableDictionary *)params url:(NSString *)url delegage:(id<MKNetworkToolDelegate>)delegate httpMethod:(NSString *)mehtod;
@end

//
//  MKTool.h
//  MKNetworkKitDome
//
//  Created by ttlgz-0022 on 16/3/16.
//  Copyright © 2016年 Transaction Technologies Limited. All rights reserved.
//

#import "MKNetworkHost.h"

@interface MKTool : MKNetworkHost
+ (MKNetworkHost*)shareMKNetworkHost;
@end

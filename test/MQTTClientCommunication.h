//
//  MQTTClientCommunication.h
//  test
//
//  Created by AOYA-CZJ on 2018/3/26.
//  Copyright © 2018年 AOYA-CZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MQTTSessionManager.h>

#define MQTTHost @"128.25.45.69"
#define MQTTPort 1883
#define MQTTUserName @"admin"
#define MQTTPassWord @"password"
@interface MQTTClientCommunication : NSObject <MQTTSessionManagerDelegate>
@property(nonatomic,strong)MQTTSessionManager* sessionManager;

+(id)sharedInstanceClient;
-(void)connectMQTTClient;
@end

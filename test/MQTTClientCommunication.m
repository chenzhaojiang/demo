//
//  MQTTClientCommunication.m
//  test
//
//  Created by AOYA-CZJ on 2018/3/26.
//  Copyright © 2018年 AOYA-CZJ. All rights reserved.
//

#import "MQTTClientCommunication.h"

static MQTTClientCommunication* client = nil;

@implementation MQTTClientCommunication
+(id)sharedInstanceClient{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        client = [[MQTTClientCommunication alloc]init];
    });
    return client;
}

-(void)connectMQTTClient{
    /**
     host: 服务器地址
     port: 服务器端口
     tls:  是否使用tls协议，mosca是支持tls的，如果使用了要设置成true
     keepalive: 心跳时间，单位秒，每隔固定时间发送心跳包, 心跳间隔不得大于120s
     clean: session是否清除，这个需要注意，如果是false，代表保持登录，如果客户端离线了再次登录就可以接收到离线消息
     auth: 是否使用登录验证
     user: 用户名
     pass: 密码
     willTopic: 订阅主题
     willMsg: 自定义的离线消息
     willQos: 接收离线消息的级别
     willRetainFlag 会话表示标志表示，代理和客户端之间自从前面的交互以来是否是持久会话。值为0，服务器必须在客户端断开之后继续存储/保持客户端的订阅状态。
     clientId: 客户端id，需要特别指出的是这个id需要全局唯一，因为服务端是根据这个来区分不同的客户端的，默认情况下一个id登录后，假如有另外的连接以这个id登录，上一个连接会被踢下线, 我使用的设备UUID
     */
    // IDFV (通过BundleID的反转的前两部分进行匹配)
    //    NSString *clientId = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
    /*
     * MQTTClient: create an instance of MQTTSessionManager once and connect
     * will is set to let the broker indicate to other subscribers if the connection is lost
     */
    if (!self.sessionManager) {
        self.sessionManager = [[MQTTSessionManager alloc] init];
        self.sessionManager.delegate = self;
        //离线遗嘱
        NSString* willTopic = [NSString stringWithFormat:@"%@/%@",@"MQTT",[UIDevice currentDevice].name];
        NSData* willMessage = [@"offline" dataUsingEncoding:NSUTF8StringEncoding];
        
        [self.sessionManager connectTo:MQTTHost
                                  port:MQTTPort
                                   tls:false
                             keepalive:60
                                 clean:false
                                  auth:true
                                  user:MQTTUserName
                                  pass:MQTTPassWord
                                  will:true
                             willTopic:willTopic
                               willMsg:willMessage
                               willQos:MQTTQosLevelExactlyOnce
                        willRetainFlag:false
                          withClientId:nil
                        securityPolicy:MQTTSSLPinningModeNone
                          certificates:nil];
    } else {
        [self.sessionManager connectToLast];
    }
    
    //关闭连接
    //    [self.sessionManager sendData:[@"leaves chat" dataUsingEncoding:NSUTF8StringEncoding]
    //                            topic:[NSString stringWithFormat:@"%@/%@",
    //                                   @"MQTT",
    //                                   [UIDevice currentDevice].name]
    //                              qos:MQTTQosLevelExactlyOnce
    //                           retain:FALSE];
    //从当前时间到你指定的时间间隔内阻塞
    //    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    //    [self.sessionManager disconnect];
    
    //MQTTCLient:观察MQTTSessionManager的状态来显示连接状态
//    [self.sessionManager addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
    
    /*
    // 订阅主题    NSDictionary类型，Object 为 QoS，key 为 Topic
    self.sessionManager.subscriptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:MQTTQosLevelExactlyOnce] forKey:@"hello"];
    
    // 发送消息   返回值msgid大于0代表发送成功
    NSString *msg = @"hahaha";
    NSDictionary* dict = @{@"key":@"value"};
//    NSError *err;
//    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    UInt16 msgid = [self.sessionManager sendData:[msg dataUsingEncoding:NSUTF8StringEncoding] //要发送的消息体
                                           topic:@"hello" //要往哪个topic发送消息
                                             qos:0 //消息级别
                                          retain:false];
    NSLog(@"------msgid=%d",msgid);
     */
}

#pragma mark - MQTTSessionManageDelegate
// 获取服务器返回数据
- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    NSLog(@"------------->>%@",topic);
//    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",dataString);
    
    // 进行消息处理
    id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"dict = %@",dict);
    if(dict){
        NSRange r=[topic rangeOfString:@"myhome/groundfloor/livingroom"];
        if (r.location != NSNotFound) {
            NSLog(@"找到主题topic1！");
            //通过通知中心贴通知
            NSDictionary* data=[NSDictionary dictionaryWithObject:@"WebSocketClosed" forKey:@"WebSocketClosed"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"webSocketStateNotification" object:nil userInfo:data];
        }
    }
}

- (void)messageDelivered:(UInt16)msgID{
    NSLog(@"masgID=%d",msgID);
}


- (void)sessionManager:(MQTTSessionManager *)sessonManager didChangeState:(MQTTSessionManagerState)newState{
//    MQTTSessionManagerState state = self.sessionManager.state;
    switch (newState) {
        case MQTTSessionManagerStateClosed:
            NSLog(@"连接已经关闭");
            
            break;
        case MQTTSessionManagerStateClosing:
            NSLog(@"连接正在关闭");
            
            break;
        case MQTTSessionManagerStateConnected:
            NSLog(@"已经连接");
            [self sendOnlineMessage];
            
            break;
        case MQTTSessionManagerStateConnecting:
            NSLog(@"正在连接中");
            
            break;
        case MQTTSessionManagerStateError: {
            NSString *errorCode = self.sessionManager.lastErrorCode.localizedDescription;
            NSLog(@"连接异常 ----- %@",errorCode);
        }
            
            break;
        case MQTTSessionManagerStateStarting:
            NSLog(@"开始连接");
            break;
        default:
            break;
    }
}

-(void)sendOnlineMessage{
    //上线通知
    NSString* topic = [NSString stringWithFormat:@"%@/%@",@"MQTT",[UIDevice currentDevice].name];
    NSData* message = [@"online" dataUsingEncoding:NSUTF8StringEncoding];
    [self.sessionManager sendData:message
                            topic:topic
                              qos:MQTTQosLevelExactlyOnce
                           retain:false];
}
@end

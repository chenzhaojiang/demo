//
//  AppDelegate.m
//  test
//
//  Created by AOYA-CZJ on 2017/6/9.
//  Copyright © 2017年 AOYA-CZJ. All rights reserved.
//

#import "AppDelegate.h"
#import <MQTTClient/MQTTClient.h>
#import <MQTTSessionManager.h>
#import "ViewController.h"

#define MQTTHost @"10.1.45.69"
#define MQTTPort 1883
#define MQTTUserName @"admin"
#define MQTTPassWord @"password"
@interface AppDelegate ()<MQTTSessionManagerDelegate>
//@property(nonatomic,strong)MQTTSession *mySession;
@property(nonatomic,strong)MQTTSessionManager* sessionManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self makeMQTT];
    
    ViewController* firstVC = [[ViewController alloc]init];
    NSLog(@"age = %d",firstVC.age);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//-(MQTTSession*)mySession{
//    if (!_mySession) {
//        MQTTCFSocketTransport* transport = [[MQTTCFSocketTransport alloc]init];
//        transport.host = MQTTHost;
//        transport.port = MQTTPort;
//        _mySession = [[MQTTSession alloc]init];
//        _mySession.transport = transport;
//        _mySession.delegate = self;
//        [_mySession setUserName:MQTTUserName];
//        [_mySession setPassword:MQTTPassWord];
//    }
//    return _mySession;
//}

-(void)makeMQTT{
//    MQTTCFSocketTransport* transport = [[MQTTCFSocketTransport alloc]init];
//    transport.host = MQTTHost;
//    transport.port = MQTTPort;
//
//    self.mySession = [[MQTTSession alloc]init];
//    self.mySession.transport = transport;
//    self.mySession.delegate = self;
//    [self.mySession setUserName:MQTTUserName];
//    [self.mySession setPassword:MQTTPassWord];
//    [self.mySession connectAndWaitTimeout:3];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 会话链接并设置超时时间
//        [self.mySession connectAndWaitTimeout:3];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 订阅主题, qosLevel是一个枚举值,指的是消息的发布质量
//            // 注意:订阅主题不能放到子线程进行,否则block不会回调
//                [self.mySession subscribeToTopic:@"myhome/groundfloor/livingroom11" atLevel:MQTTQosLevelAtMostOnce subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
//                    NSLog(@"error = %@",error);
//                    if (error) {
//                        NSLog(@"连接失败:%@",error.localizedDescription);
//                    }else{
//                        NSLog(@"连接成功！%@",gQoss);
//                    }
//                }];
//
//                NSData* data = [@"testData" dataUsingEncoding:NSUTF8StringEncoding];
//                [self.mySession publishData:data onTopic:@"myhome/groundfloor/livingroom"];
//        });
//    });

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
//    NSString *clientId = [UIDevice currentDevice].identifierForVendor.UUIDString;
//    self.sessionManager=[[MQTTSessionManager alloc]init];
//    [self.sessionManager connectTo:MQTTHost port:MQTTPort tls:false keepalive:60 clean:false auth:true user:MQTTUserName pass:MQTTPassWord willTopic:nil will:nil willQos:0 willRetainFlag:false withClientId:clientId];
//    self.sessionManager.delegate = self;
    
    /*
     * MQTTClient: create an instance of MQTTSessionManager once and connect
     * will is set to let the broker indicate to other subscribers if the connection is lost
     */
    if (!self.sessionManager) {
        self.sessionManager = [[MQTTSessionManager alloc] init];
        self.sessionManager.delegate = self;

        self.sessionManager.subscriptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:MQTTQosLevelExactlyOnce] forKey:[NSString stringWithFormat:@"%@/#", @"MQTT"]];
        [self.sessionManager connectTo:MQTTHost
                                  port:MQTTPort
                                   tls:false
                             keepalive:60
                                 clean:true
                                  auth:true
                                  user:MQTTUserName
                                  pass:MQTTPassWord
                                  will:true
                             willTopic:[NSString stringWithFormat:@"%@/%@",@"MQTT",[UIDevice currentDevice].name]
                               willMsg:[@"offline" dataUsingEncoding:NSUTF8StringEncoding]
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
    /*
     * MQTTCLient: observe the MQTTSessionManager's state to display the connection status
     */
    
//    [self.sessionManager addObserver:self
//                   forKeyPath:@"state"
//                      options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
//                      context:nil];
    
//    // 订阅主题    NSDictionary类型，Object 为 QoS，key 为 Topic
//    self.sessionManager.subscriptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:MQTTQosLevelExactlyOnce] forKey:@"hello"];
//
//    // 发送消息   返回值msgid大于0代表发送成功
//    NSString *msg = @"hahaha";
//    UInt16 msgid = [self.sessionManager sendData:[msg dataUsingEncoding:NSUTF8StringEncoding] //要发送的消息体
//                                           topic:@"hello" //要往哪个topic发送消息
//                                             qos:0 //消息级别
//                                          retain:false];
//    NSLog(@"------msgid=%d",msgid);
    
//    NSDictionary* dict = @{@"key":@"value"};
//    NSError *err;
//    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    
    

}

#pragma mark - MQTTSessionManageDelegate
// 获取服务器返回数据
- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    NSLog(@"------------->>%@",topic);
//    id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",dataString);
    
    // 进行消息处理
}

- (void)messageDelivered:(UInt16)msgID{
    NSLog(@"111111-masgID=%d",msgID);
}


- (void)sessionManager:(MQTTSessionManager *)sessonManager didChangeState:(MQTTSessionManagerState)newState{
    MQTTSessionManagerState state = self.sessionManager.state;
    
    switch (newState) {
        case MQTTSessionManagerStateClosed:
            NSLog(@"连接已经关闭");
        
            
            break;
        case MQTTSessionManagerStateClosing:
            NSLog(@"连接正在关闭");
            
            break;
        case MQTTSessionManagerStateConnected:
            NSLog(@"已经连接");
            
//            [self.sessionManager sendData:[@"message" dataUsingEncoding:NSUTF8StringEncoding]
//                                    topic:[NSString stringWithFormat:@"%@/%@",
//                                           @"MQTT",
//                                           [UIDevice currentDevice].name]
//                               qos:MQTTQosLevelExactlyOnce
//                            retain:FALSE];
            
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

//#pragma mark - MQTTSessionDelegate
//-(void)connected:(MQTTSession *)session{
//
//    NSLog(@"连接成功回调");
//
//}
//
//-(void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error{
//    NSLog(@"处理连接状态回调");
//    NSDictionary *events = @{
//                             @(MQTTSessionEventConnected): @"connected",
//                             @(MQTTSessionEventConnectionRefused): @"connection refused",
//                             @(MQTTSessionEventConnectionClosed): @"connection closed",
//                             @(MQTTSessionEventConnectionError): @"connection error",
//                             @(MQTTSessionEventProtocolError): @"protocoll error",
//                             @(MQTTSessionEventConnectionClosedByBroker): @"connection closed by broker"
//                             };
//
//    NSLog(@"-----------------MQTT连接状态%@-----------------",[events objectForKey:@(eventCode)]);
////    if (eventCode == MQTTSessionEventConnectionClosed) {
////        [session connectAndWaitTimeout:3];
////    }
//}
//
//-(void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid{
//    NSLog(@"接收到一个新消息时候回调");
////    id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    id dict = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"dict = %@",dict);
//    if (dict) {
//        NSRange r=[topic rangeOfString:@"myhome/groundfloor/livingroom"];
//
//        if (r.location != NSNotFound) {
//            NSLog(@"找到主题topic1！");
//        }
//    }
//}
@end

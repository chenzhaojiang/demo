//
//  UIImage+JKRImage.h
//  SystemMaintenance
//
//  Created by AOYA-CZJ on 2017/8/2.
//  Copyright © 2017年 AOYA-CZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>

typedef void (^compress)(NSData* data);
@interface UIImage (JKRImage)
// 将图片在子线程中压缩，block在主线层回调，保证压缩到指定文件大小，尽量减少失真
- (void)jkr_compressToDataLength:(NSInteger)length withBlock :(compress)block;
// 尽量将图片压缩到指定大小，不一定满足条件
- (void)jkr_tryCompressToDataLength:(NSInteger)length withBlock:(void (^)(NSData *))block;
// 快速将图片压缩到指定大小，失真严重
- (void)jkr_fastCompressToDataLength:(NSInteger)length withBlock:(void (^)(NSData *))block;
@end

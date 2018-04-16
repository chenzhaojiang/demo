//
//  MonitorinEquipmentMode.h
//  IntelligentMobileRoom
//
//  Created by AOYA-CZJ on 2017/5/3.
//  Copyright © 2017年 AOYA-CZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResultViewController.h"
#import <MBProgressHUD.h>

@interface MyToolsMode : NSObject
//MyToolsMode单例
+(id)sharedInstanceMyToolsMode;
//封装创建新的ImageView
+(UIImageView*)creatImageView:(UIImage*)image withInteraction:(BOOL)interaction withBorderColor:(UIColor*)borderColor withBorderWidth:(CGFloat)borderWidth withCornerRadiu:(CGFloat)cornerRadiu withCutOff:(BOOL)isCutOff;
//封装创建新的Label
+(UILabel*)creatLabel:(NSString*)textLabel withBackgroundColor:(UIColor*)backgroundColor withTextColor:(UIColor*)textColor withFontOfSize:(CGFloat)size withIsBoldFont:(BOOL)isBoldFont withInteraction:(BOOL)interaction withTextAlignment:(NSTextAlignment)textAlignment;
//封装创建新的TextField
+(UITextField*)creatTextField:(UITextBorderStyle)borderStyle withBackgroundColor:(UIColor*)backgroundColor withTextColor:(UIColor*)textColor withFontOfSize:(CGFloat)size withIsBoldFont:(BOOL)isBoldFont withInteraction:(BOOL)interaction withTextAlignment:(NSTextAlignment)textAlignment withPlaceholder:(NSString*)placeholder;
//封装创建新的Button
+(UIButton*)creatButton:(UIColor*)backgroundColor withImage:(UIImage*)image withTitle:(NSString*)title withTitleColor:(UIColor*)titleColor withHightLightedImage:(UIImage*)hightLightedImage withHightLightedTitle:(NSString*)hightLightedTitle withHightLightedTitleColor:(UIColor*)hightLightedTitleColor;
//封装创建新的TextView
+(UITextView*)creatTextView:(NSString*)text withBackgroundColor:(UIColor*)backgroundColor withTextColor:(UIColor*)textColor withTextAlignment:(NSTextAlignment)textAlignment withTextFont:(CGFloat)size withIsBoldFont:(BOOL)isBoldFont withIsEditable:(BOOL)isEditable;
//获取一个NSString类型的数组，返回可变字典类型即多个字符串拼音首字母：字符串键值对形式
+(NSMutableDictionary*)addCapitalizedDataDict:(NSMutableArray*)dataArray;
//获取拼音：字符串形式可变字典，返回通过拼音首字母排序完的可变字典的值的可变数组
+(NSMutableArray*)sortedDataArray:(NSMutableDictionary*)capitalizedDataDict;

+(UISearchController*)makeSearchVC:(UIViewController*)viewController withPlaceHolder:(NSString*)placeHolder;

+(MBProgressHUD*)makeProgressHUD:(UIViewController*)viewController withLabelText:(NSString*)labelText;

+(void)showAlert:(UIViewController*)viewController withMessage:(NSString*)message;
//点击跳转根视图控制器
+(void)showJumpAlert:(UIViewController*)viewController withMessage:(NSString*)message;
//把NSString类型的字符串按照“\”截取并存入数组，再把数组内元素依次按照“ ”截取为字典类型
+(NSMutableDictionary*)interceptDatadesc:(NSString*)datadesc;
//自定义导航条返回item
+(void)makeBackItem:(UIViewController*)viewController;
//过滤字符串，取汉字并连接
+(NSString*)makeOnlyChinese:(NSString*)str;
//对图片尺寸进行压缩--
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
//图片转字符串
+(NSString *)UIImageToBase64Str:(UIImage *)image;
//字符串转图片
+(UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr;
//Json字符串转数组或字典
+(id)objectWithJsonString:(NSString*)jsonString;
//数组或字典转JSon字符串
+(NSString*)jsonStringWithObject:(id)object;
//判断错误类型，并弹出警告框通知
+(NSString*)makeErrorMessageForRequestDataFail:(NSError*)error;
//是否是纯字母
+(BOOL)isLetters:(NSString*)str;
//判断是否是纯汉字
+(BOOL)isChinese:(NSString *)str;
//判断是否含有汉字
+(BOOL)isIncludeChinese:(NSString *)str;
//判断是否是纯数字
+(BOOL)isDigital:(NSString*)str;
//1970年至今毫秒数转化为YYYY-MM-dd HH:mm:ss日期格式
-(NSString *)timeOfMillisecondsToTime:(NSString *)timeStr;
@end

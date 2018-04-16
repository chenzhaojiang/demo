//
//  MonitorinEquipmentMode.m
//  IntelligentMobileRoom
//
//  Created by AOYA-CZJ on 2017/5/3.
//  Copyright © 2017年 AOYA-CZJ. All rights reserved.
//

#import "MyToolsMode.h"

static MyToolsMode* myToolsMode = nil;

@interface MyToolsMode ()
@property(nonatomic,strong)NSDateFormatter *formatter;

@end

@implementation MyToolsMode
+(id)sharedInstanceMyToolsMode{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        myToolsMode = [[MyToolsMode alloc]init];
    });
    return myToolsMode;
}

+(UIImageView*)creatImageView:(UIImage*)image withInteraction:(BOOL)interaction withBorderColor:(UIColor*)borderColor withBorderWidth:(CGFloat)borderWidth withCornerRadiu:(CGFloat)cornerRadiu withCutOff:(BOOL)isCutOff{
    UIImageView* imageView=[[UIImageView alloc]init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setImage:image];
    [imageView setUserInteractionEnabled:interaction];
    if (isCutOff) {
        //设置图层的边框，圆角等
        imageView.layer.borderColor=borderColor.CGColor;
        imageView.layer.borderWidth=borderWidth;
        imageView.layer.cornerRadius=cornerRadiu;
        //超过子图层的部分裁剪掉,会裁剪掉阴影部分
        imageView.layer.masksToBounds=YES;
    }
    return imageView;
}

+(UILabel*)creatLabel:(NSString*)textLabel withBackgroundColor:(UIColor*)backgroundColor withTextColor:(UIColor*)textColor withFontOfSize:(CGFloat)size withIsBoldFont:(BOOL)isBoldFont withInteraction:(BOOL)interaction withTextAlignment:(NSTextAlignment)textAlignment{
    UILabel* label=[[UILabel alloc]init];
    [label setBackgroundColor:backgroundColor];
    [label setText:textLabel];
    [label setTextColor:textColor];
    if (isBoldFont) {
        [label setFont:[UIFont boldSystemFontOfSize:size]];
    }else{
        [label setFont:[UIFont systemFontOfSize:size]];
    }
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setTextAlignment:textAlignment];
    [label setUserInteractionEnabled:interaction];
    return label;
}

+(UITextField*)creatTextField:(UITextBorderStyle)borderStyle withBackgroundColor:(UIColor*)backgroundColor withTextColor:(UIColor*)textColor withFontOfSize:(CGFloat)size withIsBoldFont:(BOOL)isBoldFont withInteraction:(BOOL)interaction withTextAlignment:(NSTextAlignment)textAlignment withPlaceholder:(NSString*)placeholder{
    UITextField* textField=[[UITextField alloc]init];
    [textField setBackgroundColor:backgroundColor];
    if (isBoldFont) {
        [textField setFont:[UIFont boldSystemFontOfSize:size]];
    }else{
        [textField setFont:[UIFont systemFontOfSize:size]];
    }
    [textField setPlaceholder:placeholder];
    [textField setTextColor:textColor];
    [textField setTextAlignment:textAlignment];
    [textField setBorderStyle:borderStyle];
    [textField setUserInteractionEnabled:interaction];
    return textField;
}

+(UIButton*)creatButton:(UIColor*)backgroundColor withImage:(UIImage*)image withTitle:(NSString*)title withTitleColor:(UIColor*)titleColor withHightLightedImage:(UIImage*)hightLightedImage withHightLightedTitle:(NSString*)hightLightedTitle withHightLightedTitleColor:(UIColor*)hightLightedTitleColor{
    UIButton* btn=[[UIButton alloc]init];
    //设置边框颜色
    btn.layer.borderColor = [backgroundColor CGColor];
    //设置边框宽度
    btn.layer.borderWidth = 1.0f;
    //给按钮设置角的弧度
    btn.layer.cornerRadius = 7.0f;
    //设置背景颜色
    btn.layer.masksToBounds = YES;
    // 设置背景色和透明度
    [btn setBackgroundColor:backgroundColor];
    // 设置未按下和按下的图片和文字切换
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [btn setBackgroundImage:hightLightedImage forState:UIControlStateHighlighted];
    [btn setTitle:hightLightedTitle forState:UIControlStateHighlighted];
    [btn setTitleColor:hightLightedTitleColor forState:UIControlStateHighlighted];
    return btn;
}

+(UITextView*)creatTextView:(NSString*)text withBackgroundColor:(UIColor*)backgroundColor withTextColor:(UIColor*)textColor withTextAlignment:(NSTextAlignment)textAlignment withTextFont:(CGFloat)size withIsBoldFont:(BOOL)isBoldFont withIsEditable:(BOOL)isEditable{
    UITextView* textView=[[UITextView alloc]init];
    [textView setBackgroundColor:backgroundColor];
    //设置边框
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    [textView setText:text];
    [textView setTextAlignment:textAlignment];
    [textView setTextColor:textColor];
    if (isBoldFont) {
        [textView setFont:[UIFont boldSystemFontOfSize:size]];
    }else{
        [textView setFont:[UIFont systemFontOfSize:size]];
    }
    [textView setEditable:isEditable];
    return textView;
}

+(NSMutableDictionary*)addCapitalizedDataDict:(NSMutableArray*)dataArray{
    NSMutableDictionary* capitalizedDataDict=[NSMutableDictionary dictionary];
    for (int i=0; i<dataArray.count; i++) {
        NSString* str = [dataArray[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([self isLetters:dataArray[i]] || [self isDigital:dataArray[i]]) {
            [capitalizedDataDict setObject:dataArray[i] forKey:str];
        }else{
            NSMutableString* dataStr=[NSMutableString stringWithString:str];
            
            NSString* newData=[self chineseChangeToPinyin:dataStr];
            
            NSArray* chineseArr=[newData componentsSeparatedByString:@" "];
            
            NSMutableString* mutableStr=[NSMutableString string];
            
            for (int j=0; j<chineseArr.count; j++) {
                NSString* capitalizedStr=chineseArr[j];
                if (capitalizedStr.length==0) {
                    continue;
                }
                unichar capitalizedChar=[capitalizedStr characterAtIndex:0];
                
                NSString* unicharStr=[NSString stringWithFormat:@"%C",capitalizedChar];
                
                [mutableStr appendString:unicharStr];
                
            }
            [mutableStr appendString:[NSString stringWithFormat:@"%d",i]];
            [capitalizedDataDict setObject:dataArray[i] forKey:mutableStr];
        }
    }
//    NSLog(@"captitalizedDataDict=%@",capitalizedDataDict);
    return capitalizedDataDict;
}

+(NSMutableArray*)sortedDataArray:(NSMutableDictionary*)capitalizedDataDict{
    NSMutableArray* dataArray=[NSMutableArray array];
    NSMutableArray* dictArray=[NSMutableArray arrayWithArray:[capitalizedDataDict allKeys]];
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch |NSNumericSearch |NSWidthInsensitiveSearch |NSForcedOrderingSearch;
    // 给数组排序
    [dictArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return (NSComparisonResult)[obj1 compare:obj2 options:comparisonOptions];
    }];
    [dataArray removeAllObjects];
    for (int i=0; i<dictArray.count; i++) {
        NSString* dictArrayStr=dictArray[i];
        
        [dataArray addObject:[capitalizedDataDict objectForKey:dictArrayStr]];
    }
    return dataArray;
}

+(UISearchController*)makeSearchVC:(UIViewController*)viewController withPlaceHolder:(NSString*)placeHolder{
    SearchResultViewController* searchResultViewController=[[SearchResultViewController alloc]init];
    UISearchController* searchVC=[[UISearchController alloc]initWithSearchResultsController:searchResultViewController];
    searchVC.searchBar.barTintColor=[UIColor whiteColor];
    searchVC.searchBar.searchBarStyle=UISearchBarStyleDefault;
    //搜索结果更新器
    searchVC.searchResultsUpdater=searchResultViewController;
    searchVC.searchBar.delegate=searchResultViewController;
    searchVC.searchBar.placeholder=placeHolder;
    searchVC.searchBar.backgroundColor=[UIColor grayColor];
    // 设置为NO,可以点击搜索出来的内容
    searchVC.dimsBackgroundDuringPresentation = NO;
    //搜索框激活的时候，会直接从searchController中偏移不见，解决代码
    searchVC.hidesNavigationBarDuringPresentation=NO;
    //UISearchController在激活状态下用户push到下一个viewController之后search bar不会仍留在界面上
    viewController.definesPresentationContext=YES;
    [searchVC.searchBar sizeToFit];
    return searchVC;
}

+(MBProgressHUD*)makeProgressHUD:(UIViewController*)viewController withLabelText:(NSString*)labelText{
    MBProgressHUD* progressHUD=[[MBProgressHUD alloc]initWithView:viewController.view];
    [viewController.view addSubview:progressHUD];
    progressHUD.backgroundView.color=[UIColor colorWithWhite:0.1f alpha:0.2f];
    progressHUD.contentColor=[UIColor blackColor];
    progressHUD.bezelView.backgroundColor=[UIColor colorWithRed:0.163 green:0.148 blue:0.128 alpha:0.2];
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.label.text=labelText;
    progressHUD.animationType = MBProgressHUDAnimationZoomOut; //和上一个相反，前近，最后淡化消失
    return progressHUD;
}

+(void)showAlert:(UIViewController*)viewController withMessage:(NSString*)message{
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [viewController presentViewController:alert animated:YES completion:nil];
}

+(void)showJumpAlert:(UIViewController*)viewController withMessage:(NSString*)message{
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [viewController.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addAction:action];
    [viewController presentViewController:alert animated:YES completion:nil];
}

+(NSMutableDictionary*)interceptDatadesc:(NSString*)datadesc{
    NSArray* datadescArr;
    NSMutableDictionary* datadescDict=[NSMutableDictionary dictionary];
    if ([datadesc containsString:@"\\"]) {
        datadescArr=[datadesc componentsSeparatedByString:@"\\"];
    }
    for (int i=0; i<[datadescArr count]; i++) {
        NSRange r=[datadescArr[i] rangeOfString:@" "];
        NSLog(@"r=%@",NSStringFromRange(r));
        
        if (r.location!=NSNotFound) {
            NSString* kStr=[datadescArr[i] substringToIndex:r.location];
//            NSLog(@"kStr=%@",kStr);
            
            NSString* vStr=[datadescArr[i] substringFromIndex:r.location+1];
//            NSLog(@"vStr=%@",vStr);
            
            [datadescDict setObject:vStr forKey:kStr];
        }
    }
//    NSLog(@"datadescDict=%@",datadescDict);
    return datadescDict;
}

+(void)makeBackItem:(UIViewController*)viewController{
    UIBarButtonItem* backItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    viewController.navigationItem.backBarButtonItem=backItem;
}

//只取汉字
+(NSString*)makeOnlyChinese:(NSString*)str{
    NSMutableString* chineseStr = [NSMutableString string];
    for (int i=0; i<[str length]; i++) {
        unichar c = [str characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF){
            //            printf("汉字");
            [chineseStr appendString:[NSString stringWithFormat:@"%C",c]];
        }
    }
    return chineseStr;
}

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

//图片转字符串
+(NSString *)UIImageToBase64Str:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

//字符串转图片
+(UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr{
    NSData *decodedImageData=[[NSData alloc]initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

+(id)objectWithJsonString:(NSString*)jsonString{
    if (!jsonString || [jsonString isKindOfClass:[NSNull class]]){
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return object;
}

+(NSString*)jsonStringWithObject:(id)object{
    if (!object || [object isKindOfClass:[NSNull class]]){
        return nil;
    }
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&err];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if(err){
        NSLog(@"封装Json失败：%@",err);
        return nil;
    }
    return jsonString;
}

+(NSString*)makeErrorMessageForRequestDataFail:(NSError *)error{
    switch (error.code) {
        case NSURLErrorUnknown:
            return @"无效的URL地址";
        case NSURLErrorCancelled:
            return @"无效的URL地址";
        case NSURLErrorBadURL:
            return @"无效的URL地址";
        case NSURLErrorTimedOut:
            return @"网络不给力，请稍后再试";
        case NSURLErrorUnsupportedURL:
            return @"不支持的URL地址";
        case NSURLErrorCannotConnectToHost:
            return @"连接不上服务器";
        case NSURLErrorDataLengthExceedsMaximum:
            return @"请求数据长度超出最大限度";
        case NSURLErrorNetworkConnectionLost:
            return @"网络连接异常";
        case NSURLErrorDNSLookupFailed:
            return @"DNS查询失败";
        case NSURLErrorHTTPTooManyRedirects:
            return @"HTTP请求重定向";
        case NSURLErrorResourceUnavailable:
            return @"资源不可用";
        case NSURLErrorNotConnectedToInternet:
            return @"无网络连接";
        case NSURLErrorRedirectToNonExistentLocation:
            return @"重定向到不存在的位置";
        case NSURLErrorBadServerResponse:
            return @"服务器响应异常";
        case NSURLErrorUserCancelledAuthentication:
            return @"用户取消授权";
        case NSURLErrorUserAuthenticationRequired:
            return @"需要用户授权";
        case NSURLErrorZeroByteResource:
            return @"零字节资源";
        case NSURLErrorCannotDecodeRawData:
            return @"无法解码原始数据";
        case NSURLErrorCannotDecodeContentData:
            return @"无法解码内容数据";
        case NSURLErrorCannotParseResponse:
            return @"无法解析响应";
        case NSURLErrorInternationalRoamingOff:
            return @"国际漫游关闭";
        case NSURLErrorCallIsActive:
            return @"被叫激活";
        case NSURLErrorDataNotAllowed:
            return @"数据不被允许";
        case NSURLErrorRequestBodyStreamExhausted:
            return @"请求体";
        case NSURLErrorFileDoesNotExist:
            return @"文件不存在";
        case NSURLErrorFileIsDirectory:
            return @"文件是个目录";
        case NSURLErrorNoPermissionsToReadFile:
            return @"无读取文件权限";
        case NSURLErrorSecureConnectionFailed:
            return @"安全连接失败";
        case NSURLErrorServerCertificateHasBadDate:
            return @"服务器证书失效";
        case NSURLErrorServerCertificateUntrusted:
            return @"不被信任的服务器证书";
        case NSURLErrorServerCertificateHasUnknownRoot:
            return @"未知Root的服务器证书";
        case NSURLErrorServerCertificateNotYetValid:
            return @"服务器证书未生效";
        case NSURLErrorClientCertificateRejected:
            return @"客户端证书被拒";
        case NSURLErrorClientCertificateRequired:
            return @"需要客户端证书";
        case NSURLErrorCannotLoadFromNetwork:
            return @"无法从网络获取";
        case NSURLErrorCannotCreateFile:
            return @"无法创建文件";
        case NSURLErrorCannotOpenFile:
            return @"无法打开文件";
        case NSURLErrorCannotCloseFile:
            return @"无法关闭文件";
        case NSURLErrorCannotWriteToFile:
            return @"无法写入文件";
        case NSURLErrorCannotRemoveFile:
            return @"无法删除文件";
        case NSURLErrorCannotMoveFile:
            return @"无法移动文件";
        case NSURLErrorDownloadDecodingFailedMidStream:
            return @"下载解码数据失败";
        case NSURLErrorDownloadDecodingFailedToComplete:
            return @"下载解码数据失败";
        default:
            return @"未知错误";
    }
}

+(id)chineseChangeToPinyin:(NSMutableString*)str{
    //将数组的汉子转变为拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformToLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    return str;
}

+(BOOL)isLetters:(NSString*)str{
    for(int i=0;i<[str length];i++){
        unichar c=[str characterAtIndex:i];
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))return NO;
    }
    return YES;
}

+(BOOL)isChinese:(NSString *)str{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

+(BOOL)isIncludeChinese:(NSString *)str{
    for(int i=0; i< str.length;i++){
        int a =[str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

+(BOOL)isDigital:(NSString*)str{
    for (int i=0; i<[str length]; i++) {
        unichar a = [str characterAtIndex:i];
        if (a>=48&&a<=57){
            continue;
        } else {
            return NO;
        }
    }
    return YES;
}

-(NSString *)timeOfMillisecondsToTime:(NSString *)timeStr{
    if (!timeStr) {
        return @"";
    }
    long long time=[timeStr longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    NSString* timeString=[self.formatter stringFromDate:d];
    return timeString;
}

-(NSDateFormatter*)formatter{
    if(!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    return _formatter;
}
@end

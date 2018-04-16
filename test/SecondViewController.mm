//
//  SecondViewController.m
//  test
//
//  Created by AOYA-CZJ on 2018/2/28.
//  Copyright © 2018年 AOYA-CZJ. All rights reserved.
//

#import "SecondViewController.h"
#import <TesseractOCR/TesseractOCR.h>
#import "UIImage+JKRImage.h"

@interface SecondViewController ()<G8TesseractDelegate>
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建一个队列来执行确认操作
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 400, 600)];
    self.imageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.imageView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(20, 220, 40, 40)];
    self.activityIndicator.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.activityIndicator];
    
    UIImage* image = [UIImage imageNamed:@"111.jpg"];
  
//    NSData *imageData;
//    if (UIImagePNGRepresentation(image)) {
//        imageData = UIImagePNGRepresentation(image);
//    } else {
//        imageData = UIImageJPEGRepresentation(image, 1.0);
//    }

    CGFloat scale = 0.9;
    NSData *jpgData = UIImageJPEGRepresentation(image, scale);
    NSLog(@"jpglength = %zd", jpgData.length);
    
    if (jpgData.length > 512*512) {
        //对图片大小进行压缩--
        __weak typeof(self) weakSelf = self;
        [image jkr_compressToDataLength:512*512 withBlock:^(NSData *data) {
            NSLog(@"data.length=%lu",(unsigned long)data.length);
            UIImage* imageNew = [UIImage imageWithData:data];
            [weakSelf recognizeImageWithTesseract:imageNew];
        }];
    }else{
        [self recognizeImageWithTesseract:image];
    }
    
    
    //GCD模版
//   dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // switch back to the main thread to update your UI
//        });
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)recognizeImageWithTesseract:(UIImage *)image{
    //转圈圈
    [self.activityIndicator startAnimating];
    /*
    //初始化G8Tesseract类，为文字识别做准备
    G8Tesseract *CardTesseract = [[G8Tesseract alloc] initWithLanguage:@"eng+chi_sim"];
    CardTesseract.delegate = self;
  
    //识别模式
    CardTesseract.engineMode = G8OCREngineModeTesseractOnly;
    //页面分割模式
    CardTesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    //一个白名单超正方体的字符识别列表 only respected when using the `G8OCREngineModeTesseractOnly` mode for `engineMode`
//    CardTesseract.charWhitelist = @"Foreign";
    //黑色超正方体的字符列表不应该认识。
//    CardTesseract.charBlacklist = @"Foreign";
    
    //限制超正方体执行识别一个矩形区域(没起作用)
    CardTesseract.rect = CGRectMake(100, 0, 100, 100);
    //限制执行时间（没起作用）
    CardTesseract.maximumRecognitionTime = 1.0;
    //tessdata 绝对路径
    NSString* dataPath = CardTesseract.absoluteDataPath;
    NSLog(@"dataPath = %@",dataPath);
    //版本号
    NSString* version = [G8Tesseract version];
    NSLog(@"version = %@",version);
    
    NSLog(@"progress = %lu,rerecognizedText = %@",(unsigned long)CardTesseract.progress,CardTesseract.recognizedText);
    CardTesseract.image = [image g8_blackAndWhite];
    //超正方体应该执行识别的图像
    CardTesseract.image = image;
    //开始识别
    [CardTesseract recognize];
    */

    //初始化
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"chi_sim+eng"];
    //识别模式（最快）
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;

    // 页面分割模式
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    
    //限制执行时间
//    operation.tesseract.maximumRecognitionTime = 1.0;
    
    //设置G8Tesseract代理
    operation.tesseract.delegate = self;
    
    // 选择限制超正方体识别以下白名单和黑名单的字符
//    operation.tesseract.charWhitelist = @"01234";
//    operation.tesseract.charBlacklist = @"56789";
    
    //对图片简单处理（黑白化对中文识别不理想）
//    UIImage* imageN = [image g8_blackAndWhite];
    UIImage* imageN = [image g8_grayScale];
    
    // 设置超正方体应该执行的识别的图像
    operation.tesseract.image = imageN;
    
    // 限制超正方体执行识别一个矩形区域(根据待识别图像的尺寸大小设置)
    operation.tesseract.rect = CGRectMake(210, 150, 140, 50);
    
    // 完成执行识别图像
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        // Fetch the recognized text
        NSString *recognizedText = tesseract.recognizedText;
        
        NSLog(@"text = %@", recognizedText);
        
        [self.activityIndicator stopAnimating];
        
        // 警告框显示识别文本
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OCR Result"
                                                        message:recognizedText
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    };
    
    // 在视图中显示处理后的图像（黑化）
    self.imageView.image = operation.tesseract.thresholdedImage;
    
    // 识别操作添加到队列中
    [self.operationQueue addOperation:operation];

    //清缓存
//    [G8Tesseract clearCache];
     
}

#pragma mark - G8TesseractDelegate
// 对sourceImage源的用户界面图像进行预处理
-(UIImage*)preprocessedImageForTesseract:(G8Tesseract *)tesseract sourceImage:(UIImage *)sourceImage{
//    NSString* text = tesseract.recognizedText;
//    if (text) {
//        NSLog(@"text111 = %@",text);
//    }
    return nil;
}
@end

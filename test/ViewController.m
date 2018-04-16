//
//  ViewController.m
//  test
//
//  Created by AOYA-CZJ on 2017/6/9.
//  Copyright © 2017年 AOYA-CZJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "UUDatePicker.h"
#import <UIImageView+WebCache.h>
#import <UIImage+GIF.h>
#import "SecondViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray* serverArray;
@property(nonatomic,strong)NSString* str;
@property(nonatomic,assign)NSInteger* intStr;
@property(nonatomic,strong)UUDatePicker* datePicker;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,copy)NSString* object;

@end

@implementation ViewController
{
    NSString *selectTime;
//    NSString* _object;
}
//@synthesize object = _objectfff;
@synthesize object = _object;
-(int)gAge{
    return 199;
}

-(NSString*)object{
    return _object;
}

-(void)setObject:(NSString *)object{
    _object = [object copy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _objectfff = @"fff";
    // Do any additional setup after loading the view, typically from a nib.
    //  读取plist文件


    NSString* path=[[NSBundle mainBundle]pathForResource:@"server" ofType:@"plist"];
    self.serverArray=[[NSArray alloc]initWithContentsOfFile:path];
    
    NSDate *nowDate = [NSDate date];
    NSLog(@"%@",nowDate);
    
    self.label.text = @"dgagalksjdljgagjklsjdbgjlkdsfnknald根深蒂固阿斯顿撒啊 阿斯顿个啊啥的啊阿嘎啊萨嘎sk";
    [self.label setNumberOfLines:0];
    self.label.lineBreakMode = NSLineBreakByWordWrapping;
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1929354940,3549861327&fm=117&gp=0.jpg"] placeholderImage:[UIImage imageNamed:@"sliderbackview.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503555021950&di=17c2df6a4e00eb9cd903ca4b242420e6&imgtype=0&src=http%3A%2F%2Fpic.92to.com%2Fanv%2F201606%2F27%2Feo5n02tvqa5.gif"]];
    
    UIImage* image = [UIImage sd_animatedGIFWithData:nil];
    
    NSCache* cache = [[NSCache alloc]init];
    //限制缓存条数
    cache.countLimit = 30;
    [cache setObject:@"aaaa" forKey:@"a"];
    
    NSString* s = [cache objectForKey:@"a"];
    NSLog(@"s=%@",s);
    
}
- (IBAction)click:(id)sender {
//    [ZJBLStoreShopTypeAlert showWithTitle:@"sheng" titles:self.serverArray selectIndex:^(NSInteger selectIndex) {
//
//    } selectValue:^(NSString *selectValue) {
//        self.str=selectValue;
//        NSLog(@"%@",self.str);
//    } showCloseButton:YES];
//    NSDate *now = [NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    selectTime=[dateformatter stringFromDate:now];
//    _datePicker= [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, self.view.frame.size.width, 216) PickerStyle:0 didSelected:^(NSString *year,
//                                                      NSString *month,
//                                                      NSString *day,
//                                                      NSString *hour,
//                                                      NSString *minute,
//                                                      NSString *weekDay) {
//                                            selectTime=[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
//                                        }];
//    _datePicker.backgroundColor=[UIColor redColor];
//    _datePicker.ScrollToDate = now;
////    _datePicker.backgroundColor=[UIColor clearColor];
//    [self.view addSubview:_datePicker];
    
    SecondViewController* secondVC = [[SecondViewController alloc]init];
    [self presentViewController:secondVC animated:YES completion:^{
        NSLog(@"secondVC!");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

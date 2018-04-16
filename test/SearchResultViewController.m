//
//  SearchResultViewController.m
//  IntelligentMobileRoom
//
//  Created by AOYA-CZJ on 2017/5/4.
//  Copyright © 2017年 AOYA-CZJ. All rights reserved.
//

#import "SearchResultViewController.h"
#import "Header.h"

@interface SearchResultViewController ()
@property(nonatomic,strong)NSDictionary* dictTmp;
@property(nonatomic,strong)NSMutableArray* searchArray;
@end

@implementation SearchResultViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.searchArray=[NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
    
    if ([USER_DEFAULT objectForKey:@"capitalizedDataDict"]) {
        self.dictTmp=[USER_DEFAULT objectForKey:@"capitalizedDataDict"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    NSLog(@"searchResult--------------------");
}

#pragma mark - searchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    self.view.hidden=YES;
    //搜索文本
    NSString * searchString = searchController.searchBar.text;
    
    [self.searchArray removeAllObjects];
    
    if ([searchString length] > 0) {
        NSPredicate * blockPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSString* str=evaluatedObject;
            
            NSRange range = [str rangeOfString:searchString options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
            
        }];
        
        NSArray* values=[self.dictTmp allValues];
        NSArray* matches=[values filteredArrayUsingPredicate:blockPredicate];
        
//        NSArray* matches;
//        if ([self isLetters:searchString]) {
//            NSArray* keys=[self.dictTmp allKeys];
//            NSArray* matchesTmp=[keys filteredArrayUsingPredicate:blockPredicate];
//            NSMutableArray* matchesMutable=[NSMutableArray array];
//            
//            for (int i=0; i<[matchesTmp count]; i++) {
//                NSString* searchTemp=[self.dictTmp objectForKey:matchesTmp[i]];
//                [matchesMutable addObject:searchTemp];
//                
//            }
//            matches=matchesMutable;
//        }else{
//            NSArray* values=[self.dictTmp allValues];
//            matches=[values filteredArrayUsingPredicate:blockPredicate];
//        }
        [self.searchArray addObjectsFromArray:matches];
    }
    //通过通知中心贴通知
    NSDictionary* data=[NSDictionary dictionaryWithObject:self.searchArray forKey:@"searchArray"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"completionNotification" object:nil userInfo:data];
    
}

//是否是纯字母
-(BOOL)isLetters:(NSString*)str{
    for(int i=0;i<[str length];i++){
        unichar c=[str characterAtIndex:i];
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))return NO;
    }
    return YES;
}

-(BOOL)isChinese:(NSString *)str{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

//直接调用这个方法就行
-(int)checkIsHaveNumAndLetter:(NSString*)values{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:values options:NSMatchingReportProgress range:NSMakeRange(0, values.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:values options:NSMatchingReportProgress range:NSMakeRange(0, values.length)];
    
    if (tNumMatchCount == values.length) {
        //全部符合数字，表示沒有英文
        return 1;
    } else if (tLetterMatchCount == values.length) {
        //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == values.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return 3;
    } else {
        return 0;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
    
}

#pragma mark - searchController delegate

// 搜索界面将要消失
-(void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"将要取消搜索时触发的方法");
}

-(void)didDismissSearchController:(UISearchController *)searchController
{
    
}

@end

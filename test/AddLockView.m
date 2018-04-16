//
//  AddLockView.m
//  test
//
//  Created by AOYA-CZJ on 2018/1/2.
//  Copyright © 2018年 AOYA-CZJ. All rights reserved.
//

#import "AddLockView.h"
#import "Header.h"
#import <Masonry.h>

@interface AddLockView ()

@end

@implementation AddLockView
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
//        UIView* firstLine = [[UIView alloc]init];
//        firstLine setBackgroundColor:[UIColor grayColor];
//        [self addSubview:firstLine];
//
//        UIImageView* lockNameImageView = [[UIImageView alloc]init];
        
    }
    return self;
    
}

-(void)buttonFirstClicked:(id)sender{
    NSLog(@"first button clicked!");
}

//-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //将point坐标由self（view）的坐标系统，转到self.buttonFirst的坐标系统
//    CGPoint btnPointFirst=[self.buttonFirst convertPoint:point fromView:self];
//    //btnPointFirst这个点在不在self.buttonFirst上面
//    if ([self.buttonFirst pointInside:btnPointFirst withEvent:event]) {
//        return self.buttonFirst;
//    }
//    return [super hitTest:point withEvent:event];
//}

@end

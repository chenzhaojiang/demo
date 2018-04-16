//
//  SearchForLockTableViewCell.m
//  test
//
//  Created by AOYA-CZJ on 2018/1/2.
//  Copyright © 2018年 AOYA-CZJ. All rights reserved.
//

#import "SearchForLockTableViewCell.h"
#import "MyToolsMode.h"
#import <Masonry.h>
#import "Header.h"

@implementation SearchForLockTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lockImageView = [MyToolsMode creatImageView:nil withInteraction:NO withBorderColor:nil withBorderWidth:0 withCornerRadiu:0 withCutOff:NO];
        
        [self.contentView addSubview:_lockImageView];
        
        _lockLabel = [MyToolsMode creatLabel:nil withBackgroundColor:[UIColor clearColor] withTextColor:[UIColor blackColor] withFontOfSize:18 withIsBoldFont:YES withInteraction:NO withTextAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:_lockLabel];
        
        _lockTextField = [MyToolsMode creatTextField:UITextBorderStyleRoundedRect withBackgroundColor:[UIColor whiteColor] withTextColor:[UIColor blackColor] withFontOfSize:18 withIsBoldFont:NO withInteraction:YES withTextAlignment:NSTextAlignmentLeft withPlaceholder:nil];
        
        [self.contentView addSubview:_lockTextField];
        
        _btnSearchForLock = [MyToolsMode creatButton:[UIColor blueColor] withImage:nil withTitle:@"搜索锁" withTitleColor:[UIColor whiteColor] withHightLightedImage:nil withHightLightedTitle:nil withHightLightedTitleColor:nil];
        
        [self.contentView addSubview:_btnSearchForLock];
        
        [_lockImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(CellHeight/5);
            make.left.equalTo(self.contentView.mas_left).with.offset(self.contentView.frame.size.width/20);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-CellHeight/5);
            make.width.mas_equalTo(_lockImageView.mas_height);
        }];
        
        [_lockLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(CellHeight/5);
            make.left.equalTo(_lockImageView.mas_right).with.offset(self.contentView.frame.size.width/80);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-CellHeight/5);
            make.width.mas_equalTo(self.contentView.frame.size.width*0.3);
        }];
        
        [_lockTextField  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(CellHeight/5);
            make.left.equalTo(_lockLabel.mas_right).with.offset(self.contentView.frame.size.width/80);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-CellHeight/5);
            make.width.mas_equalTo(self.contentView.frame.size.width*0.4);
        }];
        
        [_btnSearchForLock  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(CellHeight/5);
            make.left.equalTo(_lockTextField.mas_right).with.offset(self.contentView.frame.size.width/80);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-CellHeight/5);
            make.right.equalTo(self.contentView.mas_right).with.offset(-self.contentView.frame.size.width/20);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

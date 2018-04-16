//
//  CustomerInformationTableViewCell.m
//  SystemMaintenance
//
//  Created by AOYA-CZJ on 2017/7/19.
//  Copyright © 2017年 AOYA-CZJ. All rights reserved.
//

#import "CustomerInformationTableViewCell.h"
#import "MyToolsMode.h"
#import <Masonry.h>
#import "Header.h"

@implementation CustomerInformationTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _customerImageView=[MyToolsMode creatImageView:nil withInteraction:NO withBorderColor:nil withBorderWidth:0 withCornerRadiu:0 withCutOff:NO];
        
        [self.contentView addSubview:_customerImageView];
        
        _customerLabel=[MyToolsMode creatLabel:nil withBackgroundColor:[UIColor clearColor] withTextColor:[UIColor blackColor] withFontOfSize:18 withIsBoldFont:YES withInteraction:NO withTextAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:_customerLabel];
        
        _customerTextField=[MyToolsMode creatTextField:UITextBorderStyleRoundedRect withBackgroundColor:[UIColor whiteColor] withTextColor:[UIColor blackColor] withFontOfSize:18 withIsBoldFont:NO withInteraction:YES withTextAlignment:NSTextAlignmentLeft withPlaceholder:nil];
        
        [self.contentView addSubview:_customerTextField];
        
        [_customerImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(CellHeight/5);
            make.left.equalTo(self.contentView.mas_left).with.offset(self.contentView.frame.size.width/20);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-CellHeight/5);
            make.width.mas_equalTo(_customerImageView.mas_height);
        }];
        
        [_customerLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(CellHeight/5);
            make.left.equalTo(_customerImageView.mas_right).with.offset(self.contentView.frame.size.width/80);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-CellHeight/5);
            make.width.mas_equalTo(self.contentView.frame.size.width*0.3);
        }];
        
        [_customerTextField  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(CellHeight/5);
            make.left.equalTo(_customerLabel.mas_right).with.offset(self.contentView.frame.size.width/80);
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

//
//  Header.h
//  test
//
//  Created by AOYA-CZJ on 2018/1/2.
//  Copyright © 2018年 AOYA-CZJ. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define TableViewHeaderView @"HeaderView"
#define TableViewFooterView @"FooterView"
#define TableViewCellIdentifier @"TableViewCell"
#define ATableViewCellIdentifier @"ATableViewCell"
#define BTableViewCellIdentifier @"BTableViewCell"
#define CTableViewCellIdentifier @"CTableViewCell"
#define DTableViewCellIdentifier @"DTableViewCell"
#define CollectionViewCellIdentifier @"CollectionViewCell"

#define _height self.view.frame.size.height
#define _width self.view.frame.size.width
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define BeigeColor [UIColor colorWithRed:0.163 green:0.148 blue:0.128 alpha:0.1]
#define LightBlueColor [UIColor colorWithRed:0.135 green:0.206 blue:0.235 alpha:1]

#define CellHeight 60
#define MinCellHeight 40
#define MaxCellHeight 120
#define PersonalHeight 88
#define HeaderFooderViewHeight 10
#define TabBarHeight 49
//自动计算导航条和状态栏高度
#define NavigationAndStateHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)

#endif /* Header_h */

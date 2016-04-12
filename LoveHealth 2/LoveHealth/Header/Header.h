//
//  Header.h
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#ifndef Header_h
#define Header_h
/*
 一共定义四种字体：
 （1）顶部导航栏标题为18号字
 （2）正文详情页标题16号字
 （3）正文标题15号字
 （4）其他12号字
*/

/*
 颜色
 （1）顶部导航颜色 RGB（0，210，210）  ，导航字体颜色白色
 （2）底部导航颜色 RGB（242，242，242） ，导航字体颜色 RGB（177，177，177）
 （3）正文颜色 RGB（51，51，51）
 （4）评论、收藏、分享、时间等颜色 RGB（194，195，197）
 （5）cell分割线颜色 RGB（228，228，228）//这个先用系统自带的
 （6）登陆页面背景色 RGB（242，242，242）
*/

//第三方分享
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#define UMAPPKEY @"56ea9b9267e58eadc5001ead"
#define UMQQAPPID   @"1105298878"
#define UMQQAPPKEY  @"VLnznqZtTNwpSqUj"

//短信验证
#import <SMS_SDK/SMSSDK.h>
#define APPKEY @"1069831ba9d45"
#define APPSECRET @"b0ed9fe1032f098f0e2801746496e1e5"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH5S(x) x/320.0*[UIScreen mainScreen].bounds.size.width
#define HEIGHT5S(y) y/568.0*[UIScreen mainScreen].bounds.size.height
#define COLOR(r, g, b,i) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:i]
#define FONT(f) [UIFont systemFontOfSize:f]
#define IMAGE(name) [UIImage imageNamed:name]

#define TEXT_RECT(x,y,width,height) [[UITextField alloc]initWithFrame:CGRectMake(x, y, width, height)]
#define LABEL_RECT(x,y,width,height) [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)]
#define BUTTON_RECT(x,y,width,height) [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)]
#define IMAGE_RECT(x,y,width,height) [[UIIMageView alloc]initWithFrame:CGRectMake(x, y, width, height)]
#define VIEW_RECT(x,y,width,height) [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)]
#define TABLE_RECT(x,y,width,height) [[UITableView alloc]initWithFrame:CGRectMake(x, y, width, height)]
//#define APPKEY @"41801ee08ae0867389dcd7d455363123"

#endif /* Header_h */

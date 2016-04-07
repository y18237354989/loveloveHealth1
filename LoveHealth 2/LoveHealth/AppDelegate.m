//
//  AppDelegate.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "AppDelegate.h"

#import "NewsListViewController.h"
#import "GoodsListViewController.h"
#import "PostListViewController.h"
#import "MyPageListViewController.h"
#import "Header.h"
#import <RongIMKit/RongIMKit.h>

@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource,QQApiInterfaceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[RCIM sharedRCIM] initWithAppKey:@"m7ua80gbu9qtm"];
    
     
     NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];//改变导航title颜色
    [[RCIM sharedRCIM] connectWithToken:@"0NKs8JVttGQTlzB2BxPrAkdgYSCySnwZLT6ZxjVdZVWMZhln//o7COLS1c3MyAeNfsUQhzHeU9o/zD7wQ1VyFQ==" success:^(NSString *userId) {
        [[RCIM sharedRCIM]setUserInfoDataSource:self];
        [[RCIM sharedRCIM]setGroupInfoDataSource:self];

        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
   
     
     
     //分享代码
     //设置微信AppId、appSecret，分享url
     [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
     
     //第一个参数为新浪appkey,第二个参数为新浪secret，第三个参数是新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
     [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                               secret:@"04b48b094faeb16683c32669824ebdad"
                                          RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
     
     //设置分享到QQ/Qzone的应用Id，和分享url 链接
     [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
     
    
    
     self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
     
     NewsListViewController *nv = [[NewsListViewController alloc]init];
     nv.title = @"首页";
     nv.navigationItem.title = @"首页";
     nv.tabBarItem.image = [UIImage imageNamed:@"one@2x"];
     nv.tabBarItem.selectedImage = [UIImage imageNamed:@"oneselect@2x"];
     
     GoodsListViewController *gv = [[GoodsListViewController alloc]init];
     gv.title = @"逛一逛";
     gv.tabBarItem.title = @"逛一逛";
     gv.tabBarItem.image = [UIImage imageNamed:@"find@2x"];
     gv.tabBarItem.selectedImage = [UIImage imageNamed:@"findHL@2x"];
     
     PostListViewController *pv = [[PostListViewController alloc]init];
     pv.title = @"热帖";
     pv.tabBarItem.title = @"热帖";
     pv.tabBarItem.image = [UIImage imageNamed:@"post@2x"];
     pv.tabBarItem.selectedImage = [UIImage imageNamed:@"postSelect@2x"];
     
     MyPageListViewController *mv = [[MyPageListViewController alloc]init];
     mv.title = @"我的";
     mv.tabBarItem.title = @"我的";
     mv.tabBarItem.image = [UIImage imageNamed:@"me@2x"];
     mv.tabBarItem.selectedImage = [UIImage imageNamed:@"myHL@2x"];
     
     UINavigationController *unv1 = [[UINavigationController alloc]initWithRootViewController:nv];
//     unv1.navigationBar.hidden = YES;
     unv1.navigationBar.barTintColor = COLOR(0, 210, 210, 1);
     unv1.navigationBar.titleTextAttributes = dic;
     
     UINavigationController *unv2 = [[UINavigationController alloc]initWithRootViewController:gv];
     unv2.navigationBar.barTintColor = COLOR(0, 210, 210, 1);
     unv2.navigationBar.titleTextAttributes = dic;
     
     UINavigationController *unv3 = [[UINavigationController alloc]initWithRootViewController:pv];
     unv3.navigationBar.barTintColor = COLOR(0, 210, 210, 1);
     unv3.navigationBar.titleTextAttributes = dic;
    
    UINavigationController *unv4 = [[UINavigationController alloc]initWithRootViewController:mv];
    unv4.navigationBar.barTintColor = COLOR(0, 210, 210, 1);
    unv4.navigationBar.titleTextAttributes = dic;

    
     
//     UINavigationController *unv4 = [[UINavigationController alloc]initWithRootViewController:mv];
//     unv4.navigationBar.barTintColor = COLOR(0, 210, 210, 1);
//     unv4.navigationBar.titleTextAttributes = dic;
     
     UITabBarController *tabBar = [[UITabBarController alloc]init];
     
     tabBar.tabBar.tintColor = COLOR(0, 210, 210, 1);
     tabBar.tabBar.barTintColor = COLOR(242, 242, 242, 1);
     
     [tabBar addChildViewController:unv1];
     
     [tabBar addChildViewController:unv2];
     
     [tabBar addChildViewController:unv3];
     
     [tabBar addChildViewController:unv4];
     
     self.window.rootViewController = tabBar;
     
     [self.window makeKeyAndVisible];
     
     //改变顶部时间颜色(状态栏)(1.改info.plist 2.添加下面两行代码)
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
     
     return YES;
}
-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    if ([userId isEqualToString:@"123456"]) {
        RCUserInfo *user=[[RCUserInfo alloc]init];
        user.userId=userId;
        user.name=@"小凯";
        user.portraitUri=@"http://banbao.chazidian.com/uploadfile/2016-01-25/s145368924044608.jpg";
        
        return completion(user);
    }
    RCUserInfo *user1=[[RCUserInfo alloc]init];
    user1.userId=userId;
    user1.name=@"小凯";
    user1.portraitUri=@"http://banbao.chazidian.com/uploadfile/2016-01-25/s145368924044608.jpg";
    
    return completion(user1);
    
}


//分享回调方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
     BOOL result = [UMSocialSnsService handleOpenURL:url];
     if (result == FALSE) {
          //调用其他SDK，例如支付宝SDK等
     }
     return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
     
     return [QQApiInterface handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
     // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
     // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
     // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  PostCommentServerceViewController.h
//  LoveHealth
//
//  Created by administrator on 16/4/9.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCommentServerceViewController : UIViewController

//获取评论
+ (void)postCommentRequerst:(NSString *)postId and:(void(^)(NSMutableDictionary *postCommentDic))success;
//发评论
+(void)sendCommentWithDic:(NSDictionary *)dic andWith:(void (^)(NSDictionary *dic))success;
//发回复
+(void)postRecomm:(NSDictionary *)reCommData and:(void(^)(NSDictionary *dic))success;
//获取评论回复
+(void)getReCommData:(NSString *)commentId and:(void(^)(NSDictionary *dic))success;

@end

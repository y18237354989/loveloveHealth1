//
//  PostServerce.h
//  LoveHealth
//
//  Created by administrator on 16/4/7.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostServerce : NSObject

+(void)sendPostWithDic:(NSDictionary *)dic andWith:(void(^)(NSDictionary *dics))success;


+(void)getPostWithDic:(NSDictionary *)dic andWith:(void(^)(NSDictionary *dics))success;

+(void)getPostContentWithDic:(NSDictionary *)dic andWith:(void(^)(NSDictionary *dics))success;


@end

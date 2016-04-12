//
//  collectServerce.h
//  LoveHealth
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface collectServerce : NSObject
+ (void)newscollect:(NSString *)str and:(void(^)(NSMutableDictionary *dic))success;
+ (void)shopcollect:(NSString *)str and:(void(^)(NSMutableDictionary *dic))success;
+ (void)postcollect:(NSString *)str and:(void(^)(NSMutableDictionary *dic))success;
@end

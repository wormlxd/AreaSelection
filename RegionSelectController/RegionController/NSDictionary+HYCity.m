//
//  NSArray+HYCity.m
//  MobilePartySchool
//
//  Created by linxiaodong on 15/10/21.
//  Copyright © 2015年 com.nd.hy. All rights reserved.
//

#import "NSDictionary+HYCity.h"

@implementation NSDictionary(HYCity)

+ (NSDictionary *)getCityJson
{
    NSDictionary *jsonDic = [[NSDictionary alloc]init];
    NSData *fileData = [[NSData alloc]init];
    NSUserDefaults *cityJson = [NSUserDefaults standardUserDefaults];
    if ([cityJson objectForKey:@"city"] == nil) {
        NSString *path = nil;
        path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
        fileData = [NSData dataWithContentsOfFile:path];
        [cityJson setObject:fileData forKey:@"city"];
        [cityJson synchronize];
    }
    else {
        fileData = [cityJson objectForKey:@"city"];
    }
    jsonDic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    return jsonDic;
}
@end

//
//  ProvInfoViewController.h
//  MobilePartySchool
//
//  Created by linxiaodong on 15/10/19.
//  Copyright © 2015年 com.nd.hy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CityInfoViewController.h"
#import "DistInfoViewController.h"

@interface ProvInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *cityName;                        //省名
@property (nonatomic, strong) NSString *cityId;                          //省Id


@property (nonatomic) NSInteger	ProjectFiledType;                //字段类型 手机 = 1,固定电话 = 2,QQ = 3,所在地 = 4,
                                                                 //地址 = 7,邮编 = 8,户籍地 = 9,民族 = 10,政治面貌 = 11,出生日期 = 12,性别 = 13,
                                                                 //婚姻状况 = 14,文化程度 = 15,单位 = 16,职称 = 17,所学专业 = 18,
                                                                 //就读/毕业学校 = 19,毕业时间 = 20
@end

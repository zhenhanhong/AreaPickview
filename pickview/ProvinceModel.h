//
//  ProvinceModel.h
//  全国省市区镇
//
//  Created by 甄翰宏 on 16/3/13.
//  Copyright © 2016年 甄翰宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
@property(nonatomic, strong)NSString *code;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSArray *city_arr;

+(instancetype)setModelWithDic:(NSDictionary *)dic;
@end

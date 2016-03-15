//
//  CityModel.m
//  全国省市区镇
//
//  Created by 甄翰宏 on 16/3/13.
//  Copyright © 2016年 甄翰宏. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"-code"]) {
        _code = value;
    }
    if ([key isEqualToString:@"-name"]) {
        _name = value;
    }
    if ([key isEqualToString:@"district"]) {
        _district_arr = value;
    }
    
}
+(instancetype)setModelWithDic:(NSDictionary *)dic{
    CityModel *model = [[CityModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

@end

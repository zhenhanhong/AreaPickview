//
//  ProvinceModel.m
//  全国省市区镇
//
//  Created by 甄翰宏 on 16/3/13.
//  Copyright © 2016年 甄翰宏. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"-code"]) {
        _code = value;
    }
    if ([key isEqualToString:@"-name"]) {
        _name = value;
    }
    if ([key isEqualToString:@"city"]) {
        _city_arr = value;
    }

}
+(instancetype)setModelWithDic:(NSDictionary *)dic{
    ProvinceModel *model = [[ProvinceModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end

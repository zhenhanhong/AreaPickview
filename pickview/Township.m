//
//  Township.m
//  全国省市区镇
//
//  Created by 甄翰宏 on 16/3/13.
//  Copyright © 2016年 甄翰宏. All rights reserved.
//

#import "Township.h"

@implementation Township
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"-code"]) {
        _code = value;
    }
    if ([key isEqualToString:@"-name"]) {
        _name = value;
    }
    
}
+(instancetype)setModelWithDic:(NSDictionary *)dic{
    Township *model = [[Township alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

@end

//
//  AreaPickview.m
//  pickview
//
//  Created by 甄翰宏 on 16/3/14.
//  Copyright © 2016年 甄翰宏. All rights reserved.
//

#import "AreaPickview.h"
@interface AreaPickview()

@property(nonatomic, strong)NSMutableArray *provinceArr;
@property(nonatomic, strong)NSMutableArray *CityArr;
@property(nonatomic, strong)NSMutableArray *DistrictsArr;
@property(nonatomic, strong)NSMutableArray *TownshipArr;
@end

@implementation AreaPickview
-(NSMutableArray *)provinceArr{
    if (_provinceArr == nil) {
        _provinceArr = [NSMutableArray array];
    }
        return _provinceArr;
    
}
-(NSMutableArray *)CityArr{
    if (_CityArr == nil) {
        _CityArr = [NSMutableArray array];
    }
    return _CityArr;
}
-(NSMutableArray *)DistrictsArr{
    if (_DistrictsArr == nil) {
        _DistrictsArr = [NSMutableArray array];
    }
    return _DistrictsArr;
}
-(NSMutableArray *)TownshipArr{
    if (_TownshipArr == nil) {
        _TownshipArr = [NSMutableArray array];
    }
    return _TownshipArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Width, Height);
        self.backgroundColor = [UIColor clearColor];
        currentWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];;
        UIColor *color = [UIColor blackColor];
        currentWindow.backgroundColor = [color colorWithAlphaComponent:0.3];
        resignWindow = [[UIApplication sharedApplication] keyWindow];
        [self getdata];
        [self creatPickview];
        


  
    }
    return self;
}
#pragma makr - create pickview
-(void)creatPickview{
    [currentWindow makeKeyAndVisible];
    bottomView = [UIView new];
    bottomView.frame = CGRectMake(0, Height - 200, Width, 200);
    [currentWindow addSubview:bottomView];
    
    naviView = [UIView new];
    naviView.frame = CGRectMake(0, 0, Width, 44);
    naviView.backgroundColor = [UIColor redColor];
    [bottomView addSubview:naviView];
    
    //cancel
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cancelButton.frame = CGRectMake(10, 0, 100, 44);
    [cancelButton addTarget:self action:@selector(dismissPickview) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelButton];
    
    
    //confirm
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"confirm" forState:UIControlStateNormal];
    confirmButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    confirmButton.frame = CGRectMake(Width - 10 - 100, 0, 100, 44);
    [confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:confirmButton];
    
    //create pickview
    pickview = [UIPickerView new];
    pickview.backgroundColor = [UIColor cyanColor];
    pickview.frame = CGRectMake(0, 44, Width, 200 - 44);
    pickview.dataSource = self;
    pickview.delegate =self;
    [bottomView addSubview:pickview];
    
}
-(void)confirmAction{
    [currentWindow resignFirstResponder];
    [resignWindow makeKeyAndVisible];
    [self removeFromSuperview];
    NSString *province = [[self.provinceArr objectAtIndex:[pickview selectedRowInComponent:0]] name];
    NSString *city = [[self.CityArr objectAtIndex:[pickview selectedRowInComponent:1]] name];
    NSString *district = [[self.DistrictsArr objectAtIndex:[pickview selectedRowInComponent:2]] name];
    NSString *town = [[self.TownshipArr objectAtIndex:[pickview selectedRowInComponent:3]] name];
    
    _block(province, city, district, town);
}
-(void)dismissPickview{
    [currentWindow resignKeyWindow];
    [resignWindow makeKeyAndVisible];
    [self removeFromSuperview];
}
#pragma mark - 获取数据
-(void)getdata{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:[NSString stringWithFormat:@"%d", row] forKey:@"rowindex"];
    NSString *rowIndex = [defaults stringForKey:@"rowindex"];
    NSLog(@"%@", rowIndex);
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic = result;
    //    NSLog(@"%@", dic);
    NSDictionary *temp = [dic objectForKey:@"root"];
    NSArray *provinceArr = [temp objectForKey:@"province"];
    self.provinceArr = [NSMutableArray array];
    for (NSDictionary *dic in provinceArr) {
        ProvinceModel *model = [ProvinceModel setModelWithDic:dic];
#pragma mark - 获取省
        [self.provinceArr addObject:model];
    }
    int provinceIndex = 0;
    if (provinceIndex == 0) {
#pragma mark - 通过省数组下标获取市
        NSArray *tempArr = [_provinceArr[0] city_arr]
        ;
        self.CityArr = [NSMutableArray array];
        for (NSDictionary *dic in tempArr) {
            CityModel *city = [CityModel setModelWithDic:dic];
            [self.CityArr addObject:city];
        }
        
    }
#pragma mark -通过市数组下标获取区
    NSArray *temparr = [_CityArr[0] district_arr];
    _DistrictsArr = [NSMutableArray array];
    for (NSDictionary *dic in temparr) {
        DistrictModel *district = [DistrictModel setModelWithDic:dic];
        [_DistrictsArr addObject:district];
    }
#pragma makr -通过区数组下标获取街道（镇）
    NSArray *temparrr = [_DistrictsArr[0] street_arr];
    _TownshipArr = [NSMutableArray array];
    for (NSDictionary *dic in temparrr) {
        Township *town = [Township setModelWithDic:dic];
        [_TownshipArr addObject:town];
    }

    
}
#pragma makr- pickview delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _provinceArr.count;
    }
   else if (component == 1) {
        return _CityArr.count;
    } else if (component == 2) {
        return _DistrictsArr.count;
    } else {
        return _TownshipArr.count;
    }

}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:11];
    if (component == 0) {
        lable.text=[[self.provinceArr objectAtIndex:row] name];
    }
   else if (component == 1) {
        lable.text=[[self.CityArr objectAtIndex:row] name];
    } else if (component == 2) {
        lable.text=[[self.DistrictsArr objectAtIndex:row] name];
    } else {
        lable.text=[[self.TownshipArr objectAtIndex:row] name];
    }
    return lable;

}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return Width / 4;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {

        if (self.provinceArr.count > 0) {
            NSArray *tempArr = [_provinceArr[row] city_arr]
            ;
            self.CityArr = [NSMutableArray array];
            for (NSDictionary *dic in tempArr) {
                CityModel *city = [CityModel setModelWithDic:dic];
                [self.CityArr addObject:city];
            }

        }

    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:1];
    if (component == 1) {
        if (self.CityArr.count > 0) {
            NSArray *tempArr = [_CityArr[row] district_arr]
            ;
            self.DistrictsArr = [NSMutableArray array];
            for (NSDictionary *dic in tempArr) {
                DistrictModel *disct = [DistrictModel setModelWithDic:dic];
                [self.DistrictsArr addObject:disct];
            }
            
        }
        
    }
    [pickerView selectedRowInComponent:2];
    [pickerView reloadComponent:2];
    [pickerView selectedRowInComponent:2];
    if (component == 2) {
        if (self.DistrictsArr.count > 0) {
            NSArray *tempArr = [_DistrictsArr[row] street_arr]
            ;
            self.TownshipArr = [NSMutableArray array];
            for (NSDictionary *dic in tempArr) {
                Township *town = [Township setModelWithDic:dic];
                [self.TownshipArr addObject:town];
            }
            
        }
        
    }
    [pickerView selectedRowInComponent:3];
    [pickerView reloadComponent:3];
    [pickerView selectedRowInComponent:3];

    
}






















@end

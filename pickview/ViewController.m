//
//  ViewController.m
//  pickview
//
//  Created by 甄翰宏 on 16/3/14.
//  Copyright © 2016年 甄翰宏. All rights reserved.
//

#import "ViewController.h"
#import "AreaPickview.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *button;
@property (strong, nonatomic) IBOutlet UIButton *click;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showPickview:(UIButton *)sender {
    
    AreaPickview *pickview = [[AreaPickview alloc]init];
    [self.view addSubview:pickview];
    pickview.block = ^(NSString *province, NSString *city, NSString *distric, NSString *town){
        NSString *temp = [NSString stringWithFormat:@"%@%@%@%@",province, city, distric, town];
        [self.click setTitle:temp forState:UIControlStateNormal];
//        [self.click setTitle:[NSString stringWithFormat:@"%@ %@ %@ %@",province, city, distric, town] forState:UIControlStateNormal];
        
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

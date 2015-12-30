//
//  ViewController.m
//  SinaWeiboActionSheet
//
//  Created by zhongdong on 15/12/28.
//  Copyright © 2015年 zhongdong. All rights reserved.
//

#import "ViewController.h"
#import "ZDSinaWeiboActionSheet.h"

@interface ViewController ()<SinaWeiboActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"弹出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)goNext {
    

//    ZDSinaWeiboActionSheet *actionSheet = [[ZDSinaWeiboActionSheet alloc]initWihtTitlesArr:@[@"内容1",@"内容2",@"内容3",@"内容4"] isNeedCancleBtn:YES];
    ZDSinaWeiboActionSheet *actionSheet = [ZDSinaWeiboActionSheet actionSheetWihtTitlesArr:@[@"内容1",@"内容2",@"内容3",@"内容4"] isNeedCancleBtn:YES];
    actionSheet.deldegat = self;
    [actionSheet show];

}

-(void)sinaWeiboActionSheetDidClick:(ZDSinaWeiboActionSheet *)actionSheet selectedItem:(NSInteger)selectedLine{
    NSLog(@"%ld",(long)selectedLine);
}

@end

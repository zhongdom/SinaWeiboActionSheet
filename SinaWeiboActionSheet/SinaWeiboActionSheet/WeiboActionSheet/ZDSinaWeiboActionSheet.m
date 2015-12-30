//
//  ZDSinaWeiboActionSheet.m
//  SinaWeiboActionSheet
//
//  Created by zhongdong on 15/12/28.
//  Copyright © 2015年 zhongdong. All rights reserved.
//

#import "ZDSinaWeiboActionSheet.h"
#import "ZDSheetCell.h"

/**
 *  定义一些
 */

//行高
#define ZDLINEHEIGHT 49
//取消按钮的间隙
#define ZDMARGIN 10
//动画时间
#define ZDANIMATIONTIME 0.3
//字体大小
#define ZDFONT [UIFont systemFontOfSize:18.0];
//字体颜色
#define ZDCOLOR [UIColor blackColor]

#define ZDWIDTH [UIScreen mainScreen].bounds.size.width
#define ZDHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZDSinaWeiboActionSheet () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *titlesArr;

@property (nonatomic,assign) BOOL isNeedCancleBtn;

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) UIWindow *actionWindow;

@end

@implementation ZDSinaWeiboActionSheet

+(instancetype)actionSheetWihtTitlesArr:(NSArray *)titlesArr
                        isNeedCancleBtn:(BOOL)isNeedCancleBtn{
    return [[self alloc]initWihtTitlesArr:titlesArr isNeedCancleBtn:isNeedCancleBtn];
}

-(instancetype)initWihtTitlesArr:(NSArray *)titlesArr isNeedCancleBtn:(BOOL)isNeedCancleBtn{
    self = [super init];
    if (self) {
        
        self.isNeedCancleBtn = isNeedCancleBtn;
        self.titlesArr = titlesArr;
        
        [self setupViewWitCancleBtn:isNeedCancleBtn];
        
        
    }
    return  self;
}

-(void)setupViewWitCancleBtn:(BOOL)isNeedCancleBtn{
    
    self.backgroundColor = [UIColor clearColor];
    
    //初始化tableview
    UITableView *tableView = [[UITableView alloc]init];
    tableView.dataSource = self;
    tableView.delegate =self;
    tableView.rowHeight = ZDLINEHEIGHT;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"ZDSheetCell" bundle:nil] forCellReuseIdentifier:@"ZDSheetCell"];
    [self addSubview:tableView];
    self.tableView = tableView;
    
    //取消按钮
    if (isNeedCancleBtn) {
        
        UIView *footerView = [[UIView alloc]init];
        footerView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
        footerView.frame = CGRectMake(0, 0, ZDWIDTH, ZDLINEHEIGHT + ZDMARGIN);
        
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:ZDCOLOR forState:UIControlStateNormal];
        btn.titleLabel.font = ZDFONT;
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, ZDMARGIN, ZDWIDTH, ZDLINEHEIGHT);
        [btn addTarget:self action:@selector(dismissFromeSuperView) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
        
        tableView.tableFooterView = footerView;
    }
    
    
}

//设置tableview坐标
-(void)layoutSubviews{
    [super layoutSubviews];

    CGFloat talbeViewHeigt = ZDLINEHEIGHT * self.titlesArr.count;
    if (self.isNeedCancleBtn) {
        talbeViewHeigt = talbeViewHeigt + ZDLINEHEIGHT + ZDMARGIN;
    }
    
    self.tableView.frame = CGRectMake(0, ZDHEIGHT - talbeViewHeigt, ZDWIDTH, talbeViewHeigt);
    
    
}

//懒加载window，新建window之后会被自动添加到已有window上，只要设置windowLevel和hidden属性即可显示
-(UIWindow *)actionWindow{
    if (!_actionWindow) {
        
        _actionWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _actionWindow.windowLevel = UIWindowLevelAlert;
        _actionWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
    }
    return _actionWindow;
}

//显示
-(void)show{
    
    //设置self初始位置
    self.frame = CGRectMake(0, ZDHEIGHT, ZDWIDTH, ZDHEIGHT);
    
    //添加本身到新建window
    [self.actionWindow addSubview:self];
    
    self.actionWindow.hidden = NO;
    [UIView animateWithDuration:ZDANIMATIONTIME animations:^{
        self.frame = CGRectMake(0, 0, ZDWIDTH, ZDHEIGHT);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissFromeSuperView];
    
}

//移除
-(void)dismissFromeSuperView {
    
    [UIView animateWithDuration:ZDANIMATIONTIME animations:^{
        self.frame = CGRectMake(0, ZDHEIGHT, ZDWIDTH, ZDHEIGHT);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        self.actionWindow.hidden = YES;
        self.actionWindow = nil;
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDSheetCell"];
    cell.contentLabel.text = self.titlesArr[indexPath.row];
    cell.contentLabel.font = ZDFONT;
    cell.contentLabel.textColor = ZDCOLOR;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.deldegat respondsToSelector:@selector(sinaWeiboActionSheetDidClick:selectedItem:)]) {
        [self.deldegat sinaWeiboActionSheetDidClick:self selectedItem:indexPath.row];
    }
    
    [self dismissFromeSuperView];
}

@end

//
//  ZDSinaWeiboActionSheet.h
//  SinaWeiboActionSheet
//
//  Created by zhongdong on 15/12/28.
//  Copyright © 2015年 zhongdong. All rights reserved.
//新浪微博样式ActionSheet

#import <UIKit/UIKit.h>

@class ZDSinaWeiboActionSheet;

@protocol SinaWeiboActionSheetDelegate <NSObject>

@optional
-(void)sinaWeiboActionSheetDidClick:(ZDSinaWeiboActionSheet*)actionSheet
                          selectedItem:(NSInteger)selectedLine;

@end


@interface ZDSinaWeiboActionSheet : UIView
/**
 *  初始化
 *
 *  @param titlesArr       要显示的按钮标题
 *  @param isNeedCancleBtn 是否显示取消按钮
 *
 *  @return ActionSheet
 */
-(instancetype)initWihtTitlesArr:(NSArray *)titlesArr
                 isNeedCancleBtn:(BOOL)isNeedCancleBtn;

/**
 *  初始化
 *
 *  @param titlesArr       要显示的按钮标题
 *  @param isNeedCancleBtn 是否显示取消按钮
 *
 *  @return ActionSheet
 */

+(instancetype)actionSheetWihtTitlesArr:(NSArray *)titlesArr
                        isNeedCancleBtn:(BOOL)isNeedCancleBtn;

/**
 *  代理
 */
@property (nonatomic,weak) id<SinaWeiboActionSheetDelegate> deldegat;


-(void)show;

@end

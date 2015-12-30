//
//  ZDSheetCell.h
//  SinaWeiboActionSheet
//
//  Created by zhongdong on 15/12/29.
//  Copyright © 2015年 zhongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDSheetCell : UITableViewCell
/**
 *  暴露cell里面的Label，方便设置
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

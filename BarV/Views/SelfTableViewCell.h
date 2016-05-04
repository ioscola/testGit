//
//  SelfTableViewCell.h
//  BarV
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yttt.h"


@interface SelfTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *pic;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
-(void)setValuesForCell:(Model *)model;
@end

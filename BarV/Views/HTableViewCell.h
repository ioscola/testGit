//
//  HTableViewCell.h
//  BarV
//
//  Created by lanouhn on 15/9/15.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface HTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *singerL;

-(void)setCellWithModel:(Model *)model;

@end

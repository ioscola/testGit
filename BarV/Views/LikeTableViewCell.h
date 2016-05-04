//
//  LikeTableViewCell.h
//  BarV
//
//  Created by lanouhn on 15/9/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Yttt.h"

@interface LikeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numL;

@property (weak, nonatomic) IBOutlet UIImageView *pic;


@property (weak, nonatomic) IBOutlet UILabel *nameL;


@property (weak, nonatomic) IBOutlet UILabel *singerL;

-(void)setCellWithModel:(Model *)model;

@end

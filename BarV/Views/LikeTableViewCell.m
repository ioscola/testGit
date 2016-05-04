//
//  LikeTableViewCell.m
//  BarV
//
//  Created by lanouhn on 15/9/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "LikeTableViewCell.h"

@implementation LikeTableViewCell




-(void)setCellWithModel:(Model *)model{
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic1]placeholderImage:[UIImage imageNamed:@"uu"]];
    self.nameL.text = model.musicname;
    self.singerL.text = model.singer;
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

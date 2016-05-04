//
//  HTableViewCell.m
//  BarV
//
//  Created by lanouhn on 15/9/15.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "HTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HTableViewCell

-(void)setCellWithModel:(Model *)model{
    
        self.nameL.text = model.musicname;
        self.singerL.text = model.singer;
    
    
    
    
    NSString *str = [NSString stringWithFormat:@"http://img.9ku.com/%@",model.pic];
    [self.picture sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"uu"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

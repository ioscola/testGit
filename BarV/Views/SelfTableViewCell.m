//
//  SelfTableViewCell.m
//  BarV
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SelfTableViewCell.h"


@implementation SelfTableViewCell

-(UILabel *)label1{
    if (!_label1) {
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(70, 4, 200, 20)];
        self.label1.font = [UIFont systemFontOfSize:16];
        
    }
    return _label1;
}


-(UILabel *)label2{
    if (!_label2) {
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(70, 24, 200, 20)];
        self.label2.textColor = [UIColor lightGrayColor];
        self.label2.font = [UIFont systemFontOfSize:13];
        
    }
    return _label2;
    
    
}

-(UIImageView *)pic{
    if (!_pic) {
        self.pic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 38, 38)];
        
    }
    return _pic;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.pic];
        UIView *Sview = [[UIView alloc]initWithFrame:CGRectMake(10, self.pic.frame.origin.y+self.pic.frame.size.height+3, WIDTH-10, 0.7)];
        Sview.backgroundColor = [UIColor lightGrayColor];
        Sview.alpha = 0.6;
        [self.contentView addSubview:Sview];
        
    }
    return self;
}

-(void)setValuesForCell:(Model *)model{
    self.label1.text = model.musicname;
    self.label2.text = model.singer;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.zjpic] placeholderImage:[UIImage imageNamed:@"uu"]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

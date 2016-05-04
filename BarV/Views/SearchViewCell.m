//
//  SearchViewCell.m
//  BarV
//
//  Created by lanouhn on 15/9/11.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SearchViewCell.h"
#import "Yttt.h"

@implementation SearchViewCell

-(void)setValueForCell:(Model *)model{
    self.nameL.text = model.NClass;
    
    NSString *url = [NSString stringWithFormat:@"http://img.9ku.com/%@",model.pic];
    [self.picc sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"uu"]];
    
}



    
    
    

    
    



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

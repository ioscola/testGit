//
//  CollectionViewCell.m
//  BarV
//
//  Created by lanouhn on 15/9/12.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "CollectionViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@implementation CollectionViewCell


-(UIImageView *)picture{
    if (!_picture) {
        self.picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH-30)/3.0, (WIDTH-30)/3.0)];
        _picture.image = [UIImage imageNamed:@"uu"];
       
    }
    return _picture;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.picture];
    }
    return self;
}




- (void)awakeFromNib {
    // Initialization code
}

@end

//
//  ScrolView.m
//  BarV
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ScrolView.h"

@implementation ScrolView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrolView = [[UIScrollView alloc]init];
        self.scrolView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.scrolView.pagingEnabled = YES;
        self.scrolView.showsVerticalScrollIndicator = NO;
        self.scrolView.showsHorizontalScrollIndicator = NO;
        self.scrolView.tag = 301;
        [self addSubview:self.scrolView];
        
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

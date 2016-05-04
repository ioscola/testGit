//
//  SearchViewCell.h
//  BarV
//
//  Created by lanouhn on 15/9/11.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;

@interface SearchViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *num;

@property (weak, nonatomic) IBOutlet UILabel *nameL;



@property (weak, nonatomic) IBOutlet UIImageView *picc;



-(void)setValueForCell:(Model *)model;

@end

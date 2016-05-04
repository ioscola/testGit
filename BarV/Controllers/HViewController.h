//
//  HViewController.h
//  BarV
//
//  Created by lanouhn on 15/9/15.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
typedef enum {
    
    fromHeader = 1,
    fromItem = 2,
    fromSearch = 3
    
}ComeFromTable;

@interface HViewController : UITableViewController


@property (nonatomic,strong)Model *model;
@property ComeFromTable  fromWhat;
@end

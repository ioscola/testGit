
//
//  ShowViewController.h
//  BarV
//
//  Created by lanouhn on 15/9/12.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    singleMusicMode = 1,
    randomMusicMode = 2,
    rangMusicMode = 3
    
}playMode;


@interface ShowViewController : UIViewController
@property (nonatomic,strong)NSString *imageLink;
@property (nonatomic,strong)NSString *name;
@property (weak, nonatomic) IBOutlet UIImageView *imageP;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property playMode playmode;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *rangB;

@property (weak, nonatomic) IBOutlet UIButton *randomB;
@property (weak, nonatomic) IBOutlet UIButton *loveB;

@property (weak, nonatomic) IBOutlet UIButton *singleB;



@property (nonatomic,strong)NSMutableArray *musicSoure;
@property (nonatomic,strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timeL1;
@property (nonatomic)NSInteger number;
@property (weak, nonatomic) IBOutlet UILabel *timeL2;
@property (nonatomic,strong)NSString *time;
+(ShowViewController *)shareWithShowViewController;





@end

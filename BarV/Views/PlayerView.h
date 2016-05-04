//
//  PlayerView.h
//  BarV
//
//  Created by lanouhn on 15/9/11.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioButton.h"
#import "AudioPlayer.h"

@class PlayerView;
@protocol PlayerViewDelegate <NSObject>
@optional
-(void)showPlayingView:(PlayerView *)player;

-(void)btnPlayNextMusic;

@end

@interface PlayerView : UIView

@property (nonatomic,strong)UIImageView *picc;
@property (nonatomic,strong)UILabel *nameL;
@property (nonatomic,strong)UILabel *singerL;
@property (nonatomic,strong)UIButton *nbtn;;
@property (nonatomic,retain)AudioPlayer *audioPlayer;
@property (nonatomic,retain) AudioButton *btn;
@property (nonatomic,retain)NSString *mUrl;
@property (nonatomic,strong)NSMutableArray *musicS;
@property (nonatomic,assign)id<PlayerViewDelegate>delegate;

+(PlayerView *)shareWithPlayerView:(CGRect)frame;
- (void)playAudio:(AudioButton *)button;
-(void)playMusic:(AudioButton *)button;

//- (void)addTarget:(id)target
         //  action:(SEL)action;
@end

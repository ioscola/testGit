//
//  PlayerView.m
//  BarV
//
//  Created by lanouhn on 15/9/11.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "PlayerView.h"

#import "AudioPlayer.h"
#import "ShowViewController.h"

@implementation PlayerView
+(PlayerView *)shareWithPlayerView:(CGRect)frame{
    static PlayerView *vieww = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    vieww = [[self alloc]initWithFrame:frame];
        
    });
    return vieww;
    
}




-(NSMutableArray *)musicS{
    if (!_musicS) {
        self.musicS = [NSMutableArray arrayWithCapacity:0];
        [_musicS addObject:@"music1"];
        [_musicS addObject:@"music2"];
    }
    return _musicS;
    
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:231/255.0 green:224/255.0 blue:214/255.0 alpha:1.0];
        [self addSubview: self.picc];
        [self addSubview:self.nameL];
        [self addSubview:self.singerL];
        [self addSubview:self.btn];
        [self addSubview:self.nbtn];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(show)];
        [self addGestureRecognizer:tap];
        self.nbtn.alpha = 0;
        self.nbtn.userInteractionEnabled = NO;
        self.userInteractionEnabled = NO;
    }
    return self;
}


-(UIButton *)nbtn{
    if (!_nbtn) {
        self.nbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _nbtn.frame = CGRectMake(self.btn.frame.origin.x+self.btn.frame.size.width+15, 18, self.frame.size.height-36, self.frame.size.height-36);
        _nbtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:37];
        [_nbtn setTitle:@"\U0000e66e" forState:(UIControlStateNormal)];
        [_nbtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
         [_nbtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        [_nbtn addTarget:self action:@selector(nbtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _nbtn;
}


-(void)nbtnAction:(UIButton *)sender{
    NSLog(@"按下按钮");
    if ([self.delegate respondsToSelector:@selector(btnPlayNextMusic)]) {
        [self.delegate btnPlayNextMusic];
    }
}

-(void)show
{
    

    if ([self.delegate respondsToSelector:@selector(showPlayingView:)]) {
        [self.delegate showPlayingView:self];
    }
    
    
    
    
}


-(UIImageView *)picc{
    if (!_picc) {
        self.picc = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.height-10, self.frame.size.height-10)];
        //_picc.backgroundColor = [UIColor orangeColor];
//        _picc.layer.borderWidth = 1;
//        _picc.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _picc;
}

-(UILabel *)nameL{
    if (!_nameL) {
        self.nameL = [[UILabel
                       alloc]initWithFrame:CGRectMake(self.picc.frame.size.width+20, 5, [UIScreen mainScreen].bounds.size.width-200, (self.frame.size.height-10)/2.0)];
        //_nameL.backgroundColor = [UIColor redColor];
    }
    return _nameL;
}

-(UILabel *)singerL{
    if (!_singerL) {
        self.singerL = [[UILabel
                       alloc]initWithFrame:CGRectMake(self.picc.frame.size.width+20, 5+(self.frame.size.height-10)/2.0, [UIScreen mainScreen].bounds.size.width-200, (self.frame.size.height-10)/2.0)];
        //_singerL.backgroundColor = [UIColor grayColor];
    }
    return _singerL;
}


-(AudioButton *)btn{
    if (!_btn) {
        self.btn = [[AudioButton alloc]initWithFrame:CGRectMake(self.nameL.frame.origin.x+self.nameL.frame.size.width+15, 17, self.frame.size.height-34, self.frame.size.height-34)];
        self.btn.userInteractionEnabled = NO;
        [self.btn addTarget:self action:@selector(playAudio:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btn;
}

-(void)playMusic:(AudioButton *)button{
    if (_audioPlayer == nil) {
        _audioPlayer = [[AudioPlayer alloc] init];
    }
    
    [self.musicS removeObjectAtIndex:0];
    
        [self.musicS addObject:_mUrl];
        NSString *str1 = _musicS[0];
        NSString *str2 = _musicS[1];
    
    if (![str1 isEqualToString:str2]) {
        
    [_audioPlayer stop];
    _audioPlayer.url = [NSURL URLWithString:self.mUrl];
    _audioPlayer.button = button;
    [_audioPlayer play];

}
    
}

- (void)playAudio:(AudioButton *)button
{
    if (_audioPlayer == nil) {
        _audioPlayer = [[AudioPlayer alloc] init];
    }
    
    if ([_audioPlayer.button isEqual:button]) {
        [_audioPlayer play];
    } else {
        [_audioPlayer stop];
        
        _audioPlayer.button = button;
    
        _audioPlayer.url = [NSURL URLWithString:self.mUrl];
        
        [_audioPlayer play];
        NSLog(@"终于走了");
    }
}



@end

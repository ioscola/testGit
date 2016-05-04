//
//  ShowViewController.m
//  BarV
//
//  Created by lanouhn on 15/9/12.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ShowViewController.h"
#import "Yttt.h"
#import "FMDatabase.h"
#import "skinView.h"
#import "ShowTableViewCell.h"
#import "AppDelegate.h"
@interface ShowViewController ()<PlayerViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic)PlayerView *player;
@property (nonatomic)skinView *skinV;
@property (nonatomic,strong)NSMutableArray *picArray;
@property (weak, nonatomic) IBOutlet UIButton *ListButton;

@property (weak, nonatomic) IBOutlet UITableView *listtableView;


@end
BOOL orShow = NO;
@implementation ShowViewController


+(ShowViewController *)shareWithShowViewController{
    static ShowViewController *show = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         UIStoryboard *storyB = [UIStoryboard storyboardWithName:@"ShowViewController" bundle:nil];
    show = [storyB instantiateViewControllerWithIdentifier:@"show"];

    });
    return show;
}

-(void)createListButton{
    self.ListButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30];
    [self.ListButton setTitle:@"\U0000e62b" forState:UIControlStateNormal];
    [self.ListButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.ListButton addTarget:self action:@selector(listShowAction:) forControlEvents:UIControlEventTouchUpInside];
}




-(void)createSkinView{
    self.picArray = [NSMutableArray arrayWithCapacity:0];
    NSArray *array = @[@"p1",@"showback",@"p2",@"b3",@"b4",@"b5",@"68"];
    [self.picArray addObjectsFromArray:array];
    self.skinV = [[[NSBundle mainBundle]loadNibNamed:@"skinView" owner:self options:nil]firstObject];
    self.skinV.frame = CGRectMake(WIDTH*3/4+5, 67, WIDTH/4-10, 180);
    
    self.skinV.picScrollView.contentSize =CGSizeMake(self.skinV.frame.size.width, self.picArray.count*80);
    self.skinV.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i < self.picArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 80*i+1, self.skinV.frame.size.width-2, 80)];
        imageView.image = [UIImage imageNamed:self.picArray[i]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSkin:)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100+i;
        [imageView addGestureRecognizer:tap];
        [self.skinV.picScrollView addSubview:imageView];
    }
    
    [self.view addSubview:self.skinV];
    
}



-(void)selectSkin:(UITapGestureRecognizer *)sender{
    NSUserDefaults *photo = [NSUserDefaults standardUserDefaults];
    NSString *str = self.picArray[sender.view.tag-100];
    [photo setValue:str forKey:@"mainPic"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:self.picArray[sender.view.tag-100]]];
    
}



- (void)listShowAction:(UIButton *)sender {
    [self.listtableView reloadData];
    if (self.listtableView.hidden == YES) {
        self.listtableView.hidden = NO;
        self.listtableView.userInteractionEnabled = YES;
        
        
    }else{
        self.listtableView.hidden = YES;
        self.listtableView.userInteractionEnabled = NO;
    }
    
    
    if (self.skinV.userInteractionEnabled == YES) {
        self.skinV.userInteractionEnabled = NO;
        self.skinV.hidden = YES;
        orShow = NO;
    }

}


- (void)createItemBar{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30];
    [button setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 40, 40);
    button1.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30];
    [button1 setTitle:@"\U0000e653" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(changeSkinAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = leftItem1;
    

    
    
}

- (void)backAction:(id)sender {
   
    [self.navigationController popViewControllerAnimated:YES];
    
   
}


- (IBAction)singleMusicMode:(id)sender {
    
    self.rangB.titleLabel.font = [UIFont systemFontOfSize:14];
    self.randomB.titleLabel.font = [UIFont systemFontOfSize:14];
    self.singleB.titleLabel.font = [UIFont systemFontOfSize:20];
    
    _playmode = singleMusicMode;
    
    
}

- (IBAction)randomMusicMode:(id)sender {
    self.rangB.titleLabel.font = [UIFont systemFontOfSize:14];
    self.randomB.titleLabel.font = [UIFont systemFontOfSize:20];
    self.singleB.titleLabel.font = [UIFont systemFontOfSize:14];
    _playmode = randomMusicMode;
   
    
}

- (IBAction)rangMusicMOde:(id)sender {
    self.rangB.titleLabel.font = [UIFont systemFontOfSize:20];
    self.randomB.titleLabel.font = [UIFont systemFontOfSize:14];
    self.singleB.titleLabel.font = [UIFont systemFontOfSize:14];
    _playmode = rangMusicMode;
   
    
}



- (IBAction)addLikeMUsic:(id)sender {
    if (self.loveB.selected == NO) {
        self.loveB.selected = YES;
        
        Model *model = self.musicSoure[self.number];
       
        Model *music = [[Model alloc]init];
        music.wma = model.wma;
        music.pic1 = model.pic1;
        music.pic300 = model.pic300;
        music.musicname = model.musicname;
        music.singer = model.singer;
        FMDatabase *db = [FMDatabase databaseWithPath:DETAILPATH];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists Music(music_id integer primary key autoincrement,music_pic1 text,music_wma text,music_pic300 text,music_musicname text,music_singer text)" ];
            
             [db executeUpdate:@"insert into Music(music_pic1,music_wma,music_pic300,music_singer,music_musicname) values(?,?,?,?,?)",music.pic1,music.wma,music.pic300,music.singer,music.musicname];
            
            [db close];
        }

    }else{
        
        self.loveB.selected = NO;
        Model *model = self.musicSoure[self.number];
        FMDatabase *db = [FMDatabase databaseWithPath:DETAILPATH];
        if ([db open]) {
           [db executeUpdate:@"delete from Music where music_musicname = ? and music_singer = ?",model.musicname,model.singer];
            [db close];
        }
       
    }
    
}

- (void)changeSkinAction:(id)sender {
    if (orShow == NO) {
        self.skinV.hidden = NO;
        self.skinV.userInteractionEnabled = YES;
        orShow = YES;
    }else{
        self.skinV.hidden = YES;
        self.skinV.userInteractionEnabled = NO;
        orShow = NO;

    }
    
    
    if (self.listtableView.hidden == NO) {
        self.listtableView.hidden = YES;
        self.listtableView.userInteractionEnabled = NO;
    }

    
}

#pragma mark listtableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.musicSoure.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Model *model = self.musicSoure[indexPath.row];
    cell.numL.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.nameL.text = model.musicname;
    if (self.number == indexPath.row) {
        cell.nameL.textColor = [UIColor redColor];
        cell.numL.textColor = [UIColor redColor];
    }else{
        cell.nameL.textColor = [UIColor blackColor];
        cell.numL.textColor = [UIColor blackColor];
    }
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *oldPath = [NSIndexPath indexPathForRow:self.number inSection:0];
     ShowTableViewCell *oldCell = (ShowTableViewCell *)[tableView cellForRowAtIndexPath:oldPath];
    oldCell.nameL.textColor = [UIColor blackColor];
    oldCell.numL.textColor = [UIColor blackColor];
    
    self.number = indexPath.row;
    [self playNextMusic];
    
    ShowTableViewCell *cell = (ShowTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.nameL.textColor = [UIColor redColor];
    cell.numL.textColor = [UIColor redColor];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(void)compareLoveMusic{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DETAILPATH];
    if ([db open]) {
        FMResultSet *set = [db executeQuery:@"select *from Music"];
        while ([set next]) {
          NSString  *musicname = [set stringForColumn:@"music_musicname"];
           NSString  *singer = [set stringForColumn:@"music_singer"];
            
            Model *m = self.musicSoure[self.number];
            
            if ([m.musicname isEqualToString: musicname]&&[m.singer isEqualToString:singer]) {
                    self.loveB.selected = YES;
               
                break;
            }else{
                self.loveB.selected = NO;
            }
        }
        [db close];
        
    }
}






- (void)viewDidLoad {
    [super viewDidLoad];
    [self createItemBar];
    [self createSkinView];
    [self createListButton];
    
    self.view.tag =300;
    _playmode = rangMusicMode;
    self.listtableView.dataSource = self;
    self.listtableView.delegate = self;
    
    [self.listtableView registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.player.userInteractionEnabled = YES;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showProgress:) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething:) name:ASStatusChangedNotification object:nil];
    
    
    
    self.loveB.titleLabel.font = [UIFont fontWithName:@"iconfont" size:21];
    [self.loveB setTitle:@"\U0000e607" forState:UIControlStateNormal];
    [self.loveB setTitleColor:[UIColor colorWithRed:0/255.0 green:185/255.0 blue:90/255.0 alpha:1] forState:UIControlStateNormal];
    [self.loveB setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    NSUserDefaults *photo = [NSUserDefaults standardUserDefaults];
    NSString *str = [photo valueForKey:@"mainPic"];
    if (str != nil ) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:str]];
    }else{
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"showback"]];
    }

    
        
    
    
    
}






-(void)doSomething:(NSNotification *)notification
{
    AudioStreamer *streamer =notification.object;
    
    
    if (streamer.state ==2 || streamer.state == 5 || streamer.state == 3) {
        
        [self.timer setFireDate:[NSDate distantPast]];
       
    }
    
    if (streamer.state ==AS_PAUSED) {
        
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    
    self.timeL1.text = [NSString stringWithFormat:@"%d:%02d",
                        (int)((int)([self.player.audioPlayer.streamer duration])) / 60,
                        (int)((int)([self.player.audioPlayer.streamer duration])) % 60, nil];
    
}



-(void)btnPlayNextMusic{
    self.number++;
    [self.timer setFireDate:[NSDate distantFuture]];
    [self playNextMusic];
    
}


-(void)showProgress:(NSTimer *)timer{
    
    self.timeL2.text = self.player.audioPlayer.streamer.currentTime;
    self.progressView.progress =self.player.btn.progress;
    ;
    //|| self.player.audioPlayer.streamer.state == 0
       if (self.player.audioPlayer.streamer.state == 9 || self.player.audioPlayer.streamer.state == 0) {
        [self.timer setFireDate:[NSDate distantFuture]];
       
        if (_playmode == singleMusicMode) {
            Model *m =self.musicSoure[self.number];
            
            [self.player.audioPlayer stop];
            self.player.mUrl = m.wma;
            [self.player playAudio:self.player.btn];
        }else if (_playmode == randomMusicMode){
            NSInteger temp = self.number;
            self.number = arc4random()%(self.musicSoure.count);
            while (self.number == temp) {
                self.number = arc4random()%(self.musicSoure.count);
                
            }
            
            [self playNextMusic];
        }else if (_playmode == rangMusicMode){
            
             self.number++;
            
            [self playNextMusic];
        }
    
    }
}

-(void)playNextMusic{
    if (self.number == self.musicSoure.count ||self.number > self.musicSoure.count) {
        self.number = 0;
    }
    Model *m = self.musicSoure[self.number];
    [self.imageP sd_setImageWithURL:[NSURL URLWithString:m.pic300]placeholderImage:[UIImage imageNamed:@"uu"]];
    
    self.nameL.text = m.musicname;
    self.player.mUrl = m.wma;
    
    [self.player playMusic:self.player.btn];
    self.player.nameL.text = m.musicname;
    self.player.singerL.text = m.singer;
    [self.player.picc sd_setImageWithURL:[NSURL URLWithString:m.pic1]placeholderImage:[UIImage imageNamed:@"uu"]];
    [self compareLoveMusic];
   
}


-(void)viewWillAppear:(BOOL)animated{
    self.imageP.layer.masksToBounds = YES;
    self.imageP.layer.cornerRadius = 101;
    
    self.player = [PlayerView shareWithPlayerView:CGRectMake(0, HEIGHT-72, WIDTH,72)];
    self.player.delegate =self;
    self.player.nbtn.alpha = 1.0;
    self.player.nbtn.userInteractionEnabled =YES;
    self.player.btn.userInteractionEnabled = YES;
    [self.view addSubview:self.player];

    if (self.musicSoure.count != 0) {
        Model *m = self.musicSoure[self.number];
        [self.imageP sd_setImageWithURL:[NSURL URLWithString:m.pic300]placeholderImage:[UIImage imageNamed:@"uu"]];
                self.nameL.text = m.musicname;
        
        self.timeL1.text = [NSString stringWithFormat:@"%d:%02d",
                            (int)((int)([self.player.audioPlayer.streamer duration])) / 60,
                            (int)((int)([self.player.audioPlayer.streamer duration])) % 60, nil];
        
        [self compareLoveMusic];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    self.player.nbtn.alpha = 0;
    self.player.nbtn.userInteractionEnabled = NO;
    self.loveB.selected = NO;
    if (self.skinV.userInteractionEnabled == YES) {
        self.skinV.userInteractionEnabled = NO;
        self.skinV.hidden = YES;
        orShow = NO;
    }
    
    if (self.listtableView.hidden == NO) {
        self.listtableView.hidden = YES;
        self.listtableView.userInteractionEnabled = NO;
    }
    
    self.skinV.picScrollView.contentOffset = CGPointMake(0, 30);
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.skinV.userInteractionEnabled == YES) {
        self.skinV.userInteractionEnabled = NO;
        self.skinV.hidden = YES;
        orShow = NO;
    }
    
    if (self.listtableView.hidden == NO) {
        self.listtableView.hidden = YES;
        self.listtableView.userInteractionEnabled = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

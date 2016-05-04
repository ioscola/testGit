//
//  ItemViewController.m
//  BarV
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ItemViewController.h"
#import "SelfTableViewCell.h"
#import "CollectionViewCell.h"
#import "Yttt.h"
#import "ScrolView.h"
#import "HTableViewCell.h"
#import "HViewController.h"
#import "LikeTableViewController.h"
#import "CollectionHeader.h"
#import "SingerTableViewController.h"

@interface ItemViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
@property (nonatomic,strong) NSMutableArray *dataSource2;
@property (nonatomic,strong)PlayerView *pV;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource3;
@property (nonatomic,strong) NSMutableArray *dataSource4;
@property (nonatomic,strong) NSMutableArray *dataSource5;
@property (nonatomic)CGFloat number;
@property (nonatomic)ScrolView *headerScrolV;
@property (nonatomic)UIPageControl *pageV;
@property (nonatomic)NSInteger count;
@end
static int n = 0;
@implementation ItemViewController


-(NSMutableArray *)dataSource2{
    if (!_dataSource2) {
        self.dataSource2 = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource2;
}
-(NSMutableArray *)dataSource3{
    if (!_dataSource3) {
        self.dataSource3 = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource3;
}
-(NSMutableArray *)dataSource4{
    if (!_dataSource4) {
        self.dataSource4 = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource4;
}
-(NSMutableArray *)dataSource5{
    if (!_dataSource5) {
        self.dataSource5 = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource5;
}


- (IBAction)ShouyeAction:(UITapGestureRecognizer *)sender {
    
    if (self.scroView.contentOffset.x == WIDTH) {
        [UIView animateWithDuration:0.2 animations:^{
          self.scroView.contentOffset = CGPointMake(0, 0);
        }];
    }
    
}


- (IBAction)bangdanAction:(UITapGestureRecognizer *)sender {
    
    if ( n == 0) {
        n = 1;
        [self startRe];
        
    }

    
    if (self.scroView.contentOffset.x == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.scroView.contentOffset = CGPointMake(WIDTH, 0);
        }];
    }
    
}


-(void)createRightItrem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30];
    [button setTitle:@"\U0000e6ed" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushV:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = leftItem;

}

-(void)pushV:(UIButton *)sender{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    SingerTableViewController *singerV = [story instantiateViewControllerWithIdentifier:@"singer"];
    [self.navigationController pushViewController:singerV animated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightItrem];
    self.scroView.frame = CGRectMake(0, 100, WIDTH, HEIGHT-172);
   
    self.scroView.contentSize = CGSizeMake(WIDTH*2, self.scroView.frame.size.height);
    self.scroView.pagingEnabled = YES;
    self.scroView.delegate = self;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.scroView.frame.size.height)];
    [self.tableView registerClass:[SelfTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.scroView addSubview:self.tableView];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake((WIDTH-30)/3.0, (WIDTH-30)/3.0);
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowlayout.minimumLineSpacing = 5;
    flowlayout.minimumInteritemSpacing = 5;
    flowlayout.headerReferenceSize = CGSizeMake(WIDTH, 30);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, self.scroView.frame.size.height) collectionViewLayout:flowlayout];
    
    [self.collectionView registerClass:[CollectionViewCell class]
            forCellWithReuseIdentifier:@"ceel"];
    
   [self.collectionView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"68"]];
    [self.scroView addSubview:self.collectionView];
    __block ItemViewController *controller = self;
    [self.tableView addHeaderWithCallback:^{
        
        controller.count = 1;
        [controller startRequest];
        
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView addFooterWithCallback:^{
        controller.count++;
        [controller startRequest];
        
    }];
    
    [self.tableView headerBeginRefreshing];
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
        header.label.text = @"流行榜单";
        }else if ( indexPath.section == 1){
            header.label.text = @"分类榜单";
        }else if (indexPath.section == 2){
            header.label.text = @"乐库榜单";
        }
        
        return header;
    }else{
        return nil;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    self.pV = [PlayerView shareWithPlayerView:CGRectMake(0, HEIGHT-72, WIDTH, 72)];
    
    self.pV.delegate = self;
    
    [self.view addSubview:self.pV];
}


-(void)startRequest{
    
    NSString *url = [NSString stringWithFormat:@"http://apiios.9ku.com/IOS/ApiHandler.ashx?action=GetIndex&Type=1&PageIndex=%ld&PageSize=30",self.count];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self dealData:dic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力呀..." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"检查网络 ", nil];
        [alert show];
        
        
        
        
    }];
    [operation start];
    
    
}

-(void)showPlayingView:(PlayerView *)player{
   
    if (player.superview.tag!=300) {
        ShowViewController *show = [ShowViewController shareWithShowViewController];
        if (self.pV.audioPlayer.streamer == 0) {
            show.musicSoure = [NSMutableArray arrayWithArray:self.dataSource2];
        }
        
        
        [self.navigationController pushViewController:show animated:YES];
    }
    
}

-(void)dealData:(NSMutableDictionary *)dataDic{
    self.pV.userInteractionEnabled = YES;
    
    if (self.count == 1) {
        [self.tableView headerEndRefreshing];
        [self.dataSource2 removeAllObjects];
    }else{
        [self.tableView footerEndRefreshing];
        if ([self.tableView isHeaderRefreshing]) {
            [self.tableView headerEndRefreshing];
        }
    }
    
    
    self.pV.picc.image = [UIImage imageNamed:@"uu"];
    NSMutableArray *array = dataDic[@"data"];
    
    for (NSDictionary *dicc in array) {
    Model *model = [[Model alloc]init];
    [model setValuesForKeysWithDictionary:dicc];
        model.wma = dicc[@"wma"];
        model.musicname = dicc[@"MusicName"];
        model.singer = dicc[@"Singer"];
        model.zjpic = [NSString stringWithFormat:@"http://img.9ku.com/%@",model.zjpic];
        model.pic300 = [NSString stringWithFormat:@"http://img.9ku.com/%@",model.pic300];
        model.pic1 = [NSString stringWithFormat:@"http://img.9ku.com/%@",model.pic];
    [self.dataSource2 addObject:model];
    }
    
    [self.tableView reloadData];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.dataSource2.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.dataSource2.count!= 0) {
        Model *model = self.dataSource2[indexPath.row];
        [cell setValuesForCell:model];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 30;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
        return @"新歌推荐";

}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Model *model = self.dataSource2[indexPath.row];
    PlayerView *pV = [PlayerView shareWithPlayerView:CGRectMake(0, self.scroView.frame.origin.y+self.scroView.frame.size.height, WIDTH, HEIGHT-self.scroView.frame.origin.y-self.scroView.frame.size.height)];

    pV.nameL.text = model.musicname;
    pV.singerL.text = model.singer;
    pV.mUrl = model.wma;
    [pV.picc sd_setImageWithURL:[NSURL URLWithString:model.zjpic]placeholderImage:[UIImage imageNamed:@"uu"]];
    [pV playMusic:pV.btn];
    

    ShowViewController *show = [ShowViewController shareWithShowViewController];

    show.number = indexPath.row;
    show.musicSoure = [NSMutableArray arrayWithArray:self.dataSource2];
    
    [self.navigationController pushViewController:show animated:YES];
    
    

}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 9;
    }else{
        return 4;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offX = self.scroView.contentOffset.x;
    UILabel *b1 = (UILabel *)[self.view viewWithTag:100];
    UILabel *b2 = (UILabel *)[self.view viewWithTag:101];
    CGFloat num1 = 14+offX/WIDTH * 13;
    CGFloat num = 27- offX/WIDTH * 13;
    b1.font = [UIFont systemFontOfSize:num];
    b2.font = [UIFont systemFontOfSize:num1];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView.tag == 301) {
        
        CGFloat offX = scrollView.contentOffset.x;
        NSInteger n = offX/WIDTH;
        self.pageV.currentPage = n;
        
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (self.scroView.contentOffset.x < WIDTH && n == 0) {
        n = 1;
        [self startRe];
       
    }

    
}


-(void)startRe{
    
    NSString *url = @"http://apiios.9ku.com/BangClass/bangclass_ios.js";
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
        [self handleData:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力呀..." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"检查网络 ", nil];
        [alert show];
       
    }];
    
    [operation start];
    
    
}

-(void)handleData:(NSMutableDictionary *)dataDic{
    
    NSMutableArray *array = dataDic[@"datas"];
    NSDictionary *dic1 = array[0];
    NSMutableArray *array1 = dic1[@"data1"];
    
    for (NSDictionary *dc in array1) {
        Model *m = [[Model alloc]init];
        [m setValuesForKeysWithDictionary:dc];
       
        [self.dataSource3 addObject:m];
    }
    
    NSDictionary *dic2 = array[1];
    NSMutableArray *array2 = dic2[@"data2"];
    for (NSDictionary *dc in array2) {
        Model *m = [[Model alloc]init];
        [m setValuesForKeysWithDictionary:dc];
        [self.dataSource4 addObject:m];
    }

    NSDictionary *dic3 = array[2];
    NSMutableArray *array3 = dic3[@"data3"];
    for (NSDictionary *dc in array3) {
        Model *m = [[Model alloc]init];
        [m setValuesForKeysWithDictionary:dc];
        [self.dataSource5 addObject:m];
    }

    [self.collectionView reloadData];

    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ceel" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (indexPath.section==0) {

        array = self.dataSource3;
    }else if (indexPath.section==1){
        array = self.dataSource4;
        
    }else if(indexPath.section==2){
        array =self.dataSource5;
    }
    if (array.count!=0) {
        Model *m = array[indexPath.row];
        [cell.picture sd_setImageWithURL:[NSURL URLWithString:m.pic] placeholderImage:[UIImage imageNamed:@"uu"]];
    }
        return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (indexPath.section==0) {
        
        array = self.dataSource3;
    }else if (indexPath.section==1){
        array = self.dataSource4;
        
    }else if(indexPath.section==2){
        array =self.dataSource5;
    }
    if (array.count!=0) {
    
    
    Model *m = array[indexPath.row];
   
    UIStoryboard *hStory = [UIStoryboard storyboardWithName:@"HStoryboard" bundle:nil];
    HViewController *hV = [hStory instantiateViewControllerWithIdentifier:@"Hstory"];
    hV.model = m;
        hV.fromWhat = 2;
    [self.navigationController pushViewController:hV animated:YES];
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

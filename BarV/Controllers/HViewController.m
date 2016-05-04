//
//  HViewController.m
//  BarV
//
//  Created by lanouhn on 15/9/15.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "HViewController.h"
#import "Yttt.h"
#import "HTableViewCell.h"
#import "HHeaderView.h"
#import "SingerMusicTableViewCell.h"


@interface HViewController ()
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic)NSInteger count;
@property (nonatomic,strong)NSString *listUrl;
@end
@implementation HViewController


-(void)createRightItrem{
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
    [button1 setTitle:@"\U0000e66c" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pushPlayingV:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = leftItem1;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightItrem];
    self.count = 1;
    self.dataSource = [NSMutableArray array];
    HHeaderView *headerV = [[[NSBundle mainBundle]loadNibNamed:@"HHView" owner:self options:nil]firstObject];
    headerV.frame = CGRectMake(0, 0, WIDTH, WIDTH*9/22);
    if (_fromWhat == 3) {
    
        headerV.Hpic.image = [UIImage imageNamed:@"mao "];
        UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*13/44+10, 10, WIDTH*9/22 -20, WIDTH*9/22 -20)];
        [pic sd_setImageWithURL:[NSURL URLWithString:self.model.pic] placeholderImage:[UIImage imageNamed:@"uu"]];
        pic.layer.masksToBounds = YES;
        pic.layer.cornerRadius =pic.frame.size.height/2;
        [headerV addSubview:pic];
        [self.tableView registerNib:[UINib nibWithNibName:@"SingerMusicTableViewCell" bundle:nil] forCellReuseIdentifier:@"cel"];
        self.title = self.model.NClass;
    }else{
        
        NSString *str = self.model.pic;
       NSString *strp = [str stringByReplacingOccurrencesOfString:@"1" withString:@"2"];
       
        [headerV.Hpic sd_setImageWithURL:[NSURL URLWithString:strp]];
       self.title = self.model.name;
    }
    
    
    self.tableView.tableHeaderView = headerV;
    
    
    
    __block HViewController *HV = self;
    [self.tableView addFooterWithCallback:^{
        if (_fromWhat == 1) {
            HV.count = 1;
        }else if (_fromWhat == 2 || _fromWhat == 3){
            HV.count++;
        }
        [HV startRequest];
    }];
    
    [self.tableView addHeaderWithCallback:^{
        HV.count = 1;
        [HV startRequest];
        
    }];
    
    [self.tableView headerBeginRefreshing];
}


- (void)pushPlayingV:(id)sender {
    ShowViewController *show = [ShowViewController shareWithShowViewController];
    if (show.musicSoure.count != 0) {
        [self.navigationController pushViewController:show animated:YES];
    }
    
    
}


- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)startRequest{
       if (_fromWhat == 1) {
           NSString *url = [NSString stringWithFormat:@"http://api.9ku.com/%@",self.model.url];
        self.listUrl = [url stringByReplacingOccurrencesOfString:@"pageindex=1" withString:@"pageindex=%ld"];
        
    }else if(_fromWhat == 2 ){
        self.listUrl = [NSString stringWithFormat:@"http://apiios.9ku.com/IOS/ApiHandler.ashx?action=GetBangList&Tag=%@&PageIndex=%ld&PageSize=30",self.model.tip,self.count];
        
    }else if(_fromWhat == 3){
        
        self.listUrl = [NSString stringWithFormat:@"http://apiios.9ku.com/IOS/ApiHandler.ashx?action=GetSongsBySingerId&SingerId=%@&Type=Hits&PageIndex=%ld&PageSize=30",self.model.NClassID,self.count];
    }
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString  stringWithFormat:self.listUrl,self.count]]]];

    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        
        [self dealData:dic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不给力呀..." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"检查网络 ", nil];
        [alert show];
        
    }];
    [operation start];
    
}


-(void)dealData:(NSMutableDictionary *)dataDic{
    if (self.count == 1) {
        [self.tableView headerEndRefreshing];
        [self.dataSource removeAllObjects];
    }else{
        
        [self.tableView footerEndRefreshing];
    }
    
    if (_fromWhat ==1) {
        [self.dataSource removeAllObjects];
    }
    
        NSArray *array = dataDic[@"data"];
        for (NSDictionary *dic in array) {
            Model *m = [[Model alloc]init];
            [m setValuesForKeysWithDictionary:dic];
            m.musicname = dic[@"MusicName"];
            m.pic300 = [NSString stringWithFormat:@"http://img.9ku.com/%@",m.pic1];
            m.pic1 = [NSString stringWithFormat:@"http://img.9ku.com/%@",m.pic];
            if (_fromWhat == 3) {
                m.musicname = dic[@"MusicName"];
                m.singer = dic[@"Singer"];
                m.pic300 = [NSString stringWithFormat:@"http://img.9ku.com/%@",dic[@"zjpic"]];
                m.pic1 = [NSString stringWithFormat:@"http://img.9ku.com/%@",dic[@"pic1"]];
            }
            [self.dataSource addObject:m];
            
        }
        [self.tableView reloadData];
        

    
   }



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Model *m = self.dataSource[indexPath.row];
    if (_fromWhat == 3) {
        SingerMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cel" forIndexPath:indexPath];
        cell.nameL.text = m.musicname;
        cell.numlabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        return cell;
    }else{
        HTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell10" forIndexPath:indexPath];
        
        [cell setCellWithModel:m];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Model *m = self.dataSource[indexPath.row];
    ShowViewController *show = [ShowViewController shareWithShowViewController];
    show.number = indexPath.row;
    show.musicSoure = [NSMutableArray arrayWithArray:self.dataSource];
    
    
    PlayerView *player = [PlayerView shareWithPlayerView:CGRectZero];
    player.nameL.text = m.musicname;
    player.singerL.text = m.singer;
    
    [player.picc sd_setImageWithURL:[NSURL URLWithString:m.pic1] placeholderImage:[UIImage imageNamed:@"uu"]];
    player.mUrl = m.wma;
    
    [player playMusic:player.btn];
    [self.navigationController pushViewController:show animated:YES];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

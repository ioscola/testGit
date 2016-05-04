//
//  SingerTableViewController.m
//  BarV
//
//  Created by lanouhn on 15/9/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SingerTableViewController.h"
#import "SearchViewCell.h"
#import "Yttt.h"
#import "HViewController.h"
@interface SingerTableViewController ()<UIAlertViewDelegate>
@property (strong,nonatomic)NSMutableArray *dataS;
@property (nonatomic)NSInteger number;
@end

@implementation SingerTableViewController

-(NSMutableArray *)dataS{
    if (!_dataS) {
        self.dataS = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataS;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightItrem];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchViewCell" bundle:nil] forCellReuseIdentifier:@"celll"];
   
    
    __block SingerTableViewController *singerV = self;
    [self.tableView addFooterWithCallback:^{
        singerV.number++;
        [singerV startRequest];
        
    }];
    
    
    [self.tableView addHeaderWithCallback:^{
        singerV.number = 1;
        [singerV startRequest];
    }];
    
    [self.tableView headerBeginRefreshing];
}

-(void)startRequest{
    NSString *url = [NSString stringWithFormat:@"http://apiios.9ku.com/IOS/ApiHandler.ashx?action=GetSingerByClass&let=alllet&tp=other&PageIndex=%ld&PageSize=20",self.number];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self dealData:dic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络连接" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }];
    [operation start];
    
    
}

-(void)dealData:(NSMutableDictionary *)dataDic{
    if (self.number == 1) {
        [self.tableView headerEndRefreshing];
        [self.dataS removeAllObjects];
    }else{
        
        [self.tableView footerEndRefreshing];
    }
    
    NSMutableArray *array = dataDic[@"data"];
    if (array.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无数据" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    for (NSDictionary *dic in array) {
        Model *model = [[Model alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        model.pic300 = [NSString stringWithFormat:@"http://img.9ku.com/%@",model.pic300];
        model.pic1 = [NSString stringWithFormat:@"http://img.9ku.com/%@",model.pic];
        [self.dataS addObject:model];
        
    }
    
    [self.tableView reloadData];
    
}



-(void)createRightItrem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30];
    [button setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 40, 40);
    button1.titleLabel.font = [UIFont fontWithName:@"iconfont" size:30];
    [button1 setTitle:@"\U0000e66c" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(pushShowV:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = leftItem1;
    
}







- (void)returnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushShowV:(id)sender {
    ShowViewController *show = [ShowViewController shareWithShowViewController];
    if (show.musicSoure.count != 0) {
        
        [self.navigationController pushViewController:show animated:YES];
    }
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.dataS.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celll" forIndexPath:indexPath];
    Model *model = self.dataS[indexPath.row];
    [cell setValueForCell:model];
    
    cell.num.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Model *m = self.dataS[indexPath.row];
    m.pic = [NSString stringWithString:m.pic1];
    UIStoryboard *hStory = [UIStoryboard storyboardWithName:@"HStoryboard" bundle:nil];
    HViewController *hV = [hStory instantiateViewControllerWithIdentifier:@"Hstory"];
    hV.model = m;
    hV.fromWhat = 3;
    [self.navigationController pushViewController:hV animated:YES];

    
    
    
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

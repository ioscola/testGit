//
//  LikeTableViewController.m
//  BarV
//
//  Created by lanouhn on 15/9/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "LikeTableViewController.h"
#import "LikeTableViewCell.h"
#import "FMDatabase.h"
#import "DeletTableViewCell.h"

@interface LikeTableViewController ()
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation LikeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource= [NSMutableArray arrayWithCapacity:0];
    
    self.editButtonItem.title = @"编辑";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    if (self.editing) {
        
        self.editButtonItem.title = @"完成";
        
    } else {
        
        self.editButtonItem.title = @"编辑";
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataSource removeAllObjects];
    FMDatabase *db = [FMDatabase databaseWithPath:DETAILPATH];
    if ([db open]) {
        FMResultSet *set = [db executeQuery:@"select *from Music"];
        while ([set next]) {
            Model *model = [[Model alloc]init];
            model.wma = [set stringForColumn:@"music_wma"];
            model.pic1 = [set stringForColumn:@"music_pic1"];

           model.pic300 = [set stringForColumn:@"music_pic300"];

           model.musicname = [set stringForColumn:@"music_musicname"];
           model.singer = [set stringForColumn:@"music_singer"];
            [self.dataSource addObject:model];

        }
        [db close];
        [self.tableView reloadData];
    }
    
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
    return self.dataSource.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.dataSource.count) {
         DeletTableViewCell *cellD = [tableView dequeueReusableCellWithIdentifier:@"cell9"];
        if (self.dataSource.count!=0) {
           
            cellD.textLabel.text = @"按住左滑删除";
            
        }else{
            cellD.textLabel.text = @"快去添加喜欢的歌曲吧";
        }
        cellD.textLabel.textColor = [UIColor lightGrayColor];
        return cellD;
        
    }else{
         LikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"likecell" forIndexPath:indexPath];
        if (self.dataSource.count != 0) {
            Model *m = self.dataSource[indexPath.row];
            [cell setCellWithModel:m];
            cell.numL.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        }
        

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
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataSource.count) {
        return NO;
    }else{
        return YES;
    }
    
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Model *m = self.dataSource[indexPath.row];
        FMDatabase *db = [FMDatabase databaseWithPath:DETAILPATH];
        if ([db open]) {
            [db executeUpdate:@"delete from Music where music_singer = ?",m.singer];
            [db close];
        }
        [self.dataSource removeObject:m];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if (self.dataSource.count == 0) {
            LikeTableViewCell *cell = (LikeTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.textLabel.text = @"快去添加喜欢的歌曲吧";
            
        }
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

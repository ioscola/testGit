//
//  SettingViewController.m
//  BarV
//
//  Created by lanouhn on 15/9/23.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cleanLabel;

@property (weak, nonatomic) IBOutlet UISwitch *vSwitch;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSUserDefaults *state = [NSUserDefaults standardUserDefaults];
     NSNumber *number = [state valueForKey:@"switchOn"];
    self.vSwitch.on = number.boolValue;
    
    // Do any additional setup after loading the view.
    

}



-(NSString *)giveOutNumber{
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSString *fileSize = [NSString string];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *array = [fileManager subpathsAtPath:cachePath];
    double size = 0;
    for (NSString *fileName in array) {
        double tempSize = 0;
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *fileAttri = [fileManager attributesOfItemAtPath:filePath error:nil];
        
        tempSize = [fileAttri[NSFileSize] integerValue];
        tempSize = tempSize / 1024.0 / 1024.0;
        size = size + tempSize;
        
    }
    fileSize = [NSString stringWithFormat:@"%.1fM", size];
    
    return fileSize;
}







- (IBAction)voiceSwitch:(UISwitch *)sender {
    if (sender.on == YES ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"高品音质在移动网络下会消耗\n更多的数据流量" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"开启", nil];
        [alert show];
    }else{
        NSUserDefaults *state = [NSUserDefaults standardUserDefaults];
        [state setValue:[NSNumber numberWithBool:self.vSwitch.on] forKey:@"switchOn"];
    }

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSUserDefaults *state = [NSUserDefaults standardUserDefaults];
    if (buttonIndex == 0) {
        self.vSwitch.on = NO;
    }else{
        self.vSwitch.on = YES;
    }
    [state setValue:[NSNumber numberWithBool:self.vSwitch.on] forKey:@"switchOn"];
}

- (IBAction)cleanAction:(UIButton *)sender {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *array = [fileManager subpathsAtPath:cachePath];
    
        for (NSString *fileName in array) {
            NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:filePath error:nil];
            
}
        
    
    self.cleanLabel.text = @"0.0M";
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.cleanLabel.text = [self giveOutNumber];
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

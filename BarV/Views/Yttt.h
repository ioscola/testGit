


#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ShowViewController.h"
#import "Model.h"
#import "PlayerView.h"





#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define DOCUMENTPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject]

#define DETAILPATH  [DOCUMENTPATH stringByAppendingPathComponent:@"Music.sqlite"]


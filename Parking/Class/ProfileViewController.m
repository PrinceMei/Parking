//
//  ProfileViewController.m
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "ProfileViewController.h"
#import "ParkNavigationController.h"
#import "CommentViewController.h"
#import "ParkingPoint.h"
#import "Utility.h"
#import "DataEnvironment.h"
#import "LocateFreeSapceViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize data;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _comments = [[NSArray alloc] initWithObjects:
                     @"感觉这里停车很不错，门卫都横负责，安全由保障。价格也很便宜，还有小礼品送。",
                     @"这个停车场蛮不错的，不过是露天的，还是蛮好的，这个停车场大小也算蛮大了，还是蛮不错的。",
                     @"第一印象，停车场很大；第二感觉，要去得早,管理还得加强。",
                     @"停车位是比较多的，停车也很方便，管理人员很热情，服务很到位收费也比较合理。",
                     @"总感觉这个地方停车的人不多，不管什么时间段去都有车位，不过在这里消费的话都有免费券拿的。",
                     @"停车场比较适合新手，价格还可以，进出口的坡度是挺陡的。",
                     @"这个停车场还是算蛮不错的一个了，周末要算好时间来，不过这里的价格真的是很便宜的。",
                     @"其实来这里还是感觉蛮方便的，不过这里的停车费好像也不是怎么贵的，还是算可以的。",
                     @"这里的车库第一次看到的时候感觉都不感进去，但是进去后没想象中的贵。",
                     @"够空够宽敞，周末车也不多。转弯处空间也很大。",
                     @"碰上优惠的话是免费的，不过晚上停车场劝大家就不要进去了，实在车太多就是真实版抢车位！",
                     @"其实蛮好的，停车场走到商场的那段路都要窒息了，管理方该好好清理改进一下。",nil];
        _commentPhotos = [[NSArray alloc] initWithObjects:@"comment1",
                          @"comment2",
                          @"comment3",
                          @"comment4",
                          @"comment5",
                          @"comment6",
                          @"comment7",
                          @"comment8",
                          @"comment9",
                          @"comment10",
                          @"comment11",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = data.name;
    _imgView.image = [UIImage imageNamed:data.bigPicture];
    _priceLbl.text = [NSString stringWithFormat:@"费 用:%@   空车位:%d", data.price, data.freeSpace];
    _timeLbl.text = [NSString stringWithFormat:@"营业时间:%@", data.time];
    _addressLbl.text = [NSString stringWithFormat:@"地址:%@", data.address];
    
    NSString *desc = [NSString stringWithFormat:@"基本信息:%@", data.desc];
    _infoLbl.text = desc;
    CGFloat height = [desc sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(300, MAXFLOAT)].height;
    _infoLbl.height = height;
    
    NSString *pro = data.promotions;
    _promoLbl.top = _infoLbl.bottom+2;
    if(pro){
        NSString *string = [NSString stringWithFormat:@"优惠活动:%@", pro];
        CGFloat height = [string sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(300, MAXFLOAT)].height;
        _promoLbl.text = string;
        _promoLbl.height = height;
    }else{
        _promoLbl.height = 0;
    }
    
    UIView *tableHeaderView = _tableView.tableHeaderView;
    tableHeaderView.height = _promoLbl.bottom;
    _tableView.tableHeaderView = tableHeaderView;
    
    UIImage *image = nil;
    NSUInteger left = data.freeSpace;
    if(left < 10){
        image = [UIImage imageNamed:@"bar_re"];
    }else if(left < 20){
        image = [UIImage imageNamed:@"bar_ye"];
    }else{
        image = [UIImage imageNamed:@"bar_gr"];
    }
    
    _barImgView.image = image;
}

- (void)viewDidUnload
{
    _imgView = nil;
    _priceLbl = nil;
    _timeLbl = nil;
    _addressLbl = nil;
    _infoLbl = nil;
    _promoLbl = nil;
    _headImgView = nil;
    _barImgView = nil;
    _tableView = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MAX(arc4random() % 8, 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.contentView.backgroundColor = RGBCOLOR(247, 246, 244);
    
    // Configure the cell...
    UILabel *timeLbl = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *commentLbl = (UILabel *)[cell.contentView viewWithTag:2];
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:3];
    
    NSInteger row = indexPath.row;
    
    NSString *d = [NSString stringWithFormat:@"%d", 2*(row+1)+row];
    if(d.length == 1){
        d = [NSString stringWithFormat:@"0%@", d];
    }
    
    NSString *h = [NSString stringWithFormat:@"%d", (arc4random() % 12)+1];
    if(h.length == 1){
        h = [NSString stringWithFormat:@"0%@", h];
    }
    
    NSString *s = [NSString stringWithFormat:@"%d", (arc4random() % 60)];
    if(s.length == 1){
        s = [NSString stringWithFormat:@"0%@", s];
    }
    timeLbl.text = [NSString stringWithFormat:@"2012.0%d.%@\n%@:%@", row+1, d, h, s];
    commentLbl.text = [_comments objectAtIndex:arc4random()%_comments.count];
                
    NSString *img = [_commentPhotos objectAtIndex:arc4random()%_commentPhotos.count];
    imgView.image = [UIImage imageNamed:img];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y < 0){
        _headImgView.top = 0-scrollView.contentOffset.y/3-20;        
    }else{
        _headImgView.top = 0-scrollView.contentOffset.y-20;
    }
}

- (IBAction)popSheet:(UIButton *)button {
    if(![DataEnvironment sharedDataEnvironment].isParking){
        _rightNavigationBarBtn = button;
        
        NSInteger free = data.freeSpace;
        if(free > 0){
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"抢到了车位,开始停车计费吧" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"开始计费", nil];
            [sheet showInView:self.view];
        }else{
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"没有空车位了，不能停车" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
            [sheet showInView:self.view];
        }
    }else{
        [self doSetting];
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)comment:(id)sender {
    CommentViewController *commentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentViewController"];
    commentVC.title = self.title;
    ParkNavigationController *naVC = [[ParkNavigationController alloc] initWithRootViewController:commentVC];
    [self presentModalViewController:naVC animated:YES];
}

- (void)doMaskMe{
//    ParkingCameraViewController *imagePickerController = [[ParkingCameraViewController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.finishedBlock = ^(ParkingCameraViewController *vc, id obj){
//        [DataEnvironment sharedDataEnvironment].isMaskMe = YES;
//    };
//    [self presentModalViewController:imagePickerController animated:YES];
    [Utility takePhotoWithDelegate:self inViewController:self];
    
    [self doSetting];
}

- (void)doLocateMyCar{
    LocateFreeSapceViewController *suggestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LocateFreeSapceViewController"];
    suggestVC.point = self.data;
    ParkNavigationController *naVC = [[ParkNavigationController alloc] initWithRootViewController:suggestVC];
    [self presentModalViewController:naVC animated:YES];
    
    [self doSetting];
}

- (void)doConsum{
    [self doSetting];    
}

- (void)doSetting {
    if(!_showPopView){
        _showPopView = YES;
        
        _popView = [[[NSBundle mainBundle] loadNibNamed:@"PopoverView" owner:self options:nil] objectAtIndex:0];
        //        _popView.alpha = 0;
        _popView.right = 320;
        _popView.bottom = 0;
        [self.view addSubview:_popView];
        
        if(![DataEnvironment sharedDataEnvironment].isMaskMe){
            UIButton *button1 = (UIButton *)[_popView viewWithTag:1];
            [button1 setImage:[UIImage imageNamed:@"btn_mask.png"] forState:UIControlStateNormal];
            [button1 addTarget:self action:@selector(doMaskMe) forControlEvents:UIControlEventTouchUpInside];
        }else {
            UIButton *button1 = (UIButton *)[_popView viewWithTag:1];
            [button1 setImage:[UIImage imageNamed:@"btn_findcar.png"] forState:UIControlStateNormal];
            [button1 addTarget:self action:@selector(doLocateMyCar) forControlEvents:UIControlEventTouchUpInside];            
        }
        
        UIButton *button2 = (UIButton *)[_popView viewWithTag:2];
        [button2 setImage:[UIImage imageNamed:@"btn_pay.png"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(doConsum) forControlEvents:UIControlEventTouchUpInside];
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             //                             _popView.alpha = 1;
                             _popView.top = 0;
                         }];
    }else{
        _showPopView = NO;
        [UIView animateWithDuration:0.3f
                         animations:^{
                             //                             _popView.alpha = 0;
                             _popView.bottom = 0;
                         }completion:^(BOOL finished) {
                             [_popView removeFromSuperview]; _popView = nil;
                         }];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *string = [actionSheet buttonTitleAtIndex:buttonIndex];
    if([string isEqualToString:@"开始计费"]){
        [DataEnvironment sharedDataEnvironment].isParking = YES;
        [_rightNavigationBarBtn setImage:[UIImage imageNamed:@"btn_more.png"] forState:UIControlStateNormal];
        
        if(_isBelowParking){
            
        }else{
            
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [DataEnvironment sharedDataEnvironment].isMaskMe = YES;
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}


@end

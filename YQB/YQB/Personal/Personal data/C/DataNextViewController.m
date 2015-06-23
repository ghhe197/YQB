//
//  DataNextViewController.m
//  YQB
//
//  Created by jian on 15/6/8.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "DataNextViewController.h"

@interface DataNextViewController ()

@end

@implementation DataNextViewController

@synthesize myPicImgView,submitImgView,filePath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片上传";
    
    //加载控件
    [self initControl];
    
    //请求数据
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initControl
{
    UITapGestureRecognizer *mytapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPicture:)];
    [myPicImgView addGestureRecognizer:mytapPress];
    
    UITapGestureRecognizer *sumittapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPicture:)];
    [submitImgView addGestureRecognizer:sumittapPress];
    
}

-(void)initData
{
    
}

-(IBAction)gotoUpData:(id)sender
{
    [super useImagePickerController];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    [super setStatusBarStyle];
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    //    int savetime = [timeSp intValue];
    NSLog(@"intimeSp:%@",timeSp); //时间戳的值
    
    //        self.myimage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *myimage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //    UIImageWriteToSavedPhotosAlbum(myimage, self, nil, NULL);
    //UIImagePickerControllerOriginalImage 完整
    //UIImagePickerControllerEditedImage  截取
    
    //    NSString *imgName = [NSString stringWithFormat:@"%@.png",timeSp];
    
    //修改图片尺寸
    //    myimage = [self fitSmallImage:myimage];
    
    //保存沙盒
    [self saveImage:myimage withName:[NSString stringWithFormat:@"%@.png",timeSp]];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",timeSp]];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    filePath = [NSURL fileURLWithPath:fullPath];
    
    [myPicImgView setImage:savedImage];
    
    submitImgView.hidden = YES;
    
    //关闭相册界面
    //    [picker dismissModalViewControllerAnimated:YES];
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

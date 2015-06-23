//
//  SignDetailViewController.m
//  YQB
//
//  Created by jian on 15/5/21.
//  Copyright (c) 2015年 jian. All rights reserved.
//

#import "SignDetailViewController.h"

@interface SignDetailViewController ()

@end

@implementation SignDetailViewController

@synthesize agree_btn,name_tf,password_tf,agpassword_tf,headView,base_code,filePath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self initControl];
    
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initControl
{
    agree_btn.selected = YES;
    
    headView.layer.cornerRadius=35.0;
    headView.layer.masksToBounds = YES;
    headView.layer.borderWidth=0;

    UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPicture:)];
    [headView addGestureRecognizer:tapPress];
}

-(void)initData
{
    
}

-(void)addPicture:(UIGestureRecognizer *)gestureRecognizer
{
    [name_tf resignFirstResponder];
    [password_tf resignFirstResponder];
    [agpassword_tf resignFirstResponder];
    
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
    myimage = [self fitSmallImage:myimage];
    
    //保存沙盒
    [self saveImage:myimage withName:[NSString stringWithFormat:@"%@.png",timeSp]];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",timeSp]];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    filePath = [NSURL fileURLWithPath:fullPath];
    
    [headView setImage:savedImage];
    
    //关闭相册界面
    //    [picker dismissModalViewControllerAnimated:YES];
}


//阅读并同意条款
-(IBAction)gotoSetAgree:(id)sender
{
    if (agree_btn.selected)
    {
        agree_btn.selected = NO;
        return;
    }
    agree_btn.selected = YES;
}

-(IBAction)gotoLogin:(id)sender
{
    if (name_tf.text.length == 0)
    {
        [self.view makeToast:@"请输入昵称" duration:1.5 position:@"center"];
        return;
    }
    if (password_tf.text.length == 0)
    {
        [self.view makeToast:@"请输入登录密码" duration:1.5 position:@"center"];
        return;
    }
    if (agpassword_tf.text.length == 0)
    {
        [self.view makeToast:@"请验证登录密码" duration:1.5 position:@"center"];
        return;
    }
    if (![password_tf.text isEqualToString:agpassword_tf.text])
    {
        [self.view makeToast:@"两次密码不相同" duration:1.5 position:@"center"];
        return;
    }
    if (!agree_btn.selected)
    {
        [self.view makeToast:@"请阅读并同意《钱兜理财服务条款》" duration:1.5 position:@"center"];
        return;
    }
    [self gotoSign];
}

//注册
-(void)gotoSign
{
    Frequest *req = [[Frequest alloc]init];
    req.delegate = self;
    //    req.apiName = @"Login";
    req.connectEnd = @selector(signConEnd:);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"signphone"] forKey:@"phone"];
    [postDic setObject:name_tf.text forKey:@"nickname"];
    NSString *forBase64password = [password_tf.text base64String];
    NSString *forBase64agpassword = [agpassword_tf.text base64String];
    [postDic setObject:forBase64password forKey:@"password"];
    [postDic setObject:forBase64agpassword forKeyedSubscript:@"confirm_password"];
    [postDic setObject:base_code forKeyedSubscript:@"base_code"];
    [postDic setObject:@"pic" forKey:@"pic"];
    [MBProgressHUD showHUDAddedTo:self.view text:@"注册中..."];

    [req callAPI:REGISTERURL WithParams:postDic path:filePath View:self.view];
}

-(void)signConEnd:(id)aInfo
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view makeToast:@"注册成功" duration:1.5 position:@"center"];
    [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.5];
}

-(UIImage *)fitSmallImage:(UIImage *)image  
{
    if (nil == image)
    {
        return nil;
    }
    if (image.size.width<300 && image.size.height<300)
    {
        return image;
    }
    CGSize size = [self fitsize:image.size];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newing;
}

-(CGSize)fitsize:(CGSize)thisSize
{
    if(thisSize.width == 0 && thisSize.height ==0)
        return CGSizeMake(0, 0);
    CGFloat wscale = thisSize.width/300;
    CGFloat hscale = thisSize.height/300;
    CGFloat scale = (wscale>hscale)?wscale:hscale;
    CGSize newSize = CGSizeMake(thisSize.width/scale, thisSize.height/scale);
    NSLog(@"%f______________%f",newSize.width,newSize.height);
    return newSize;
    
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

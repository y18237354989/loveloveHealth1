//
//  SendPostViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "SendPostViewController.h"
#import "Header.h"
#import "YCXMenu.h"
#import "PostServerce.h"
@interface SendPostViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic)UILabel *titleLabel;

@property (strong,nonatomic)UITextField *titleText;

@property (strong,nonatomic)UILabel *contentLabel;

@property (strong,nonatomic)UITextView *contentView;

@property (strong,nonatomic)UIButton *markBtn;

@property (strong,nonatomic)UIButton *sendBtn;

@property (strong,nonatomic)UILabel *addpicLabel;

@property (strong,nonatomic)UIButton *addpicBtn;

@property (strong, nonatomic)NSMutableArray *items;

@property (strong,nonatomic)UIView *view1;

@property (strong, nonatomic)UIImageView *tempImage; //临时存放选择的图片

@property (strong,nonatomic)NSString *dateStr;

@end

@implementation SendPostViewController
@synthesize items = _items;

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view.
     
     self.navigationItem.title = @"发帖子";
     self.view.backgroundColor = [UIColor whiteColor];
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     self.automaticallyAdjustsScrollViewInsets = NO;
     [self createPart];
     
     //获取当前时间
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
     [dateFormatter setDateStyle:NSDateFormatterFullStyle];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     
     self.dateStr = [dateFormatter stringFromDate:[NSDate date]];
     
     
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)createPart{
     
     self.view1 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(185), WIDTH5S(290), HEIGHT5S(305))];
     self.view1.backgroundColor = [UIColor whiteColor];
     self.view1.layer.borderWidth = 1.0;
     self.view1.layer.borderColor= COLOR(228, 228, 288, 1).CGColor;
     self.view1.layer.cornerRadius = 6;
     [self.view addSubview:self.view1];
     
     self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(80), WIDTH5S(35), HEIGHT5S(20))];
     self.titleLabel.font = FONT(15);
     self.titleLabel.text = @"标题:";
     [self.view addSubview:self.titleLabel];
     
     self.titleText = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(115), WIDTH5S(290), HEIGHT5S(20))];
     self.titleText.placeholder = @"不超过25字";
     self.titleText.layer.borderColor=COLOR(228, 228, 228, 1).CGColor;
     [self.view addSubview:self.titleText];
     //添加文字输入限制
     [self.titleText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     
     UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(144), WIDTH5S(290), HEIGHT5S(1))];
     line.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:line];
     
     self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(155), WIDTH5S(35), HEIGHT5S(20))];
     self.contentLabel.font = FONT(15);
     self.contentLabel.text = @"内容:";
     [self.view addSubview:self.contentLabel];
     
     self.contentView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(290), HEIGHT5S(230))];
     self.contentView.delegate = self;
     [self.view1 addSubview:self.contentView];
     
     self.markBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(245), HEIGHT5S(80), WIDTH5S(60), HEIGHT5S(20))];
     [self.markBtn setBackgroundColor:COLOR(204, 255, 255, 1)];
     [self.markBtn setTitle:@"选择标签" forState:UIControlStateNormal];
     self.markBtn.titleLabel.font = FONT(12);
     [self.markBtn setTitleColor:COLOR(0, 204, 204, 1) forState:UIControlStateNormal];
     [self.markBtn addTarget:self action:@selector(ChooseMark:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:self.markBtn];
     
     self.sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(15), HEIGHT5S(510), WIDTH5S(290), HEIGHT5S(40))];
     [self.sendBtn setBackgroundColor:COLOR(0, 204, 204, 1)];
     [self.sendBtn setTitle:@"确认发布" forState:UIControlStateNormal];
     [self.sendBtn setTitleColor:COLOR(255, 255, 255, 1) forState:UIControlStateNormal];
     [self.sendBtn addTarget:self action:@selector(sendPostNew) forControlEvents:UIControlEventTouchUpInside];
     self.sendBtn.layer.cornerRadius = 5;
     [self.view addSubview:self.sendBtn];
     
     self.addpicLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(235), HEIGHT5S(230), WIDTH5S(55), HEIGHT5S(18))];
     self.addpicLabel.font = FONT(13);
     self.addpicLabel.textColor = COLOR(228, 228, 228, 1);
     self.addpicLabel.text = @"添加图片";
     [self.view1 addSubview:self.addpicLabel];
     
     self.addpicBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(235), HEIGHT5S(250), WIDTH5S(50), HEIGHT5S(50))];
     [self.addpicBtn setImage:[UIImage imageNamed:@"AddPic"] forState:UIControlStateNormal];
     [self.view1 addSubview:self.addpicBtn];
     [self.addpicBtn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
     
}

//textField输入文字限制
- (void)textFieldDidChange:(UITextField *)textField{
     
     if (textField == self.titleText) {
          if (textField.text.length > 15) {
               textField.text = [textField.text substringToIndex:15];
          }
     }
}

//添加图片调用此方法
- (void)addPic{
     
     [self chosePic];
}

/*
 
 图片压缩上传步骤：
 1 选择图片
 2 图片裁剪
 3 图片压缩
 4 图片保存到沙盒
 5 从沙盒中获取压缩后图片并添加到相应位置
 
 */

//找到本地相册选择图片（1）
- (void)chosePic{
     
     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
     {
          UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
          imagePickerController.delegate = self;
          imagePickerController.allowsEditing = YES;
          imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
          [self presentViewController:imagePickerController animated:YES completion:^{}];
     }
}

//裁剪（2）
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
     [picker dismissViewControllerAnimated:YES completion:^{}];
     
     UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
     /* 此处info 有六个值
      * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
      * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
      * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
      * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
      * UIImagePickerControllerMediaURL;       // an NSURL
      * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
      * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
      */
     [self saveImage:image withName:@"sdddssds.png"];
     
}

//取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
     [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - 保存图片至沙盒 （4）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
     
     UIImage *image = [self image:currentImage andWithWidth:600];
     NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
     // 获取沙盒目录
     
     NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
     // 将图片写入文件
     
     [imageData writeToFile:fullPath atomically:YES];
     
     //将压缩后的图片添加到需要位置（5）
     [self.addpicBtn setBackgroundImage:[UIImage imageWithContentsOfFile:fullPath] forState:UIControlStateNormal];
     self.tempImage.image = [UIImage imageWithContentsOfFile:fullPath];
     
}

//   图片压缩（3）（2个参数：第一个是需要压缩的图片名，第二个是压缩后的宽度）
- (UIImage *)image:(UIImage *)sourceImage andWithWidth:(CGFloat)Width{
     CGFloat width = sourceImage.size.width;
     CGFloat height = sourceImage.size.height;
     CGFloat targetWidth = Width;
     CGFloat targetHeight = (targetWidth/width)*height;
     
     UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
     [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
     
     UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return newImage;
}

//发帖方法
-(void)sendPostNew{
     
     if ([self.titleText.text isEqualToString:@""]||[self.contentView.text isEqualToString:@""]) {
          NSLog(@"标题或内容为空");
     }else{
          
          NSDictionary *dic = @{@"userid":@"1",
                                @"postTypeid":@"1",
                                @"postTitle":self.titleText.text,
                                @"postword":self.contentView.text,
                                @"posttime":self.dateStr,
                                @"postimage":@""};
          
          [PostServerce sendPostWithDic:dic andWith:^(NSDictionary *dics) {
               
               NSDictionary *newdic = dics;
               NSLog(@"%@",newdic);
          }];
          [self.navigationController popViewControllerAnimated:YES];
          
          
     }
     
}


//标签菜单
- (void)ChooseMark:(UIButton *)sender{
     
     //    ChooseMarkViewController *cvc = [[ChooseMarkViewController alloc]init];
     //    [self.navigationController pushViewController:cvc animated:YES];
     // 显示默认样式的Menu
     if ([sender isKindOfClass:[UIButton class]]) {
          UIButton *btn = sender;
          [YCXMenu setHasShadow:YES];
          [YCXMenu setBackgrounColorEffect:YCXMenuBackgrounColorEffectGradient];
          [YCXMenu setTintColor:COLOR(0, 204, 204, 1)];
          [YCXMenu setTitleFont:[UIFont systemFontOfSize:15.0]];
          [YCXMenu showMenuInView:self.view fromRect:btn.frame menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
               NSLog(@"%@",item);
          }];
     }
}

#pragma mark - setter/getter
- (NSMutableArray *)items {
     if (!_items) {
          
          // set title
          YCXMenuItem *menuTitle = [YCXMenuItem menuTitle:@"Menu" WithIcon:nil];
          menuTitle.foreColor = [UIColor whiteColor];
          menuTitle.titleFont = [UIFont boldSystemFontOfSize:15.0f];
          
          //          //set logout button
          //          YCXMenuItem *logoutItem = [YCXMenuItem menuItem:@"Logout" image:nil target:self action:@selector(logout:)];
          //          logoutItem.foreColor = [UIColor redColor];
          //          logoutItem.alignment = NSTextAlignmentCenter;
          
          
          //set item
          _items = [@[
                      //                      menuTitle,
                      [YCXMenuItem menuItem:@"中医"
                                      image:nil
                                        tag:100
                                   userInfo:@{@"title":@"Menu"}],
                      [YCXMenuItem menuItem:@"西医"
                                      image:nil
                                        tag:101
                                   userInfo:@{@"title":@"Menu"}],
                      [YCXMenuItem menuItem:@"健身"
                                      image:nil
                                        tag:102
                                   userInfo:@{@"title":@"Menu"}],
                      [YCXMenuItem menuItem:@"心理"
                                      image:nil
                                        tag:103
                                   userInfo:@{@"title":@"Menu"}],
                      [YCXMenuItem menuItem:@"饮食"
                                      image:nil
                                        tag:104
                                   userInfo:@{@"title":@"Menu"}]
                      //  logoutItem
                      ] mutableCopy];
     }
     return _items;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.view endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
     self.contentView.frame = CGRectMake(0, 0, 290, 120);
     
}
-(void)textViewDidEndEditing:(UITextView *)textView{
     self.contentView.frame = CGRectMake(0, 0, 290, 230);
}

@end

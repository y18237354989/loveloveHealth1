//
//  PersonDataViewController.m
//  LoveHealth
//
//  Created by administrator on 16/3/26.
//  Copyright © 2016年 yjh. All rights reserved.
//

#import "PersonDataViewController.h"
#import "Header.h"
#import "AddressViewController.h"

@interface PersonDataViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic)UITableView *userDataTable;

@property (strong, nonatomic)UILabel *cellTitle1,*cellTitle2,*cellTitle3,*cellTitle4;

@property (strong, nonatomic)UIImageView *userHead;

@property (strong, nonatomic)UITextField *userMessage2,*userMessage3;

@property (strong, nonatomic)UILabel *userMessage4;

@property (strong, nonatomic)NSArray *dataArr;

@property (strong, nonatomic)UIButton *btn;

@property (strong, nonatomic)UITapGestureRecognizer *ges; //更换头像手势

@property (assign, nonatomic)int i;

@end

@implementation PersonDataViewController

- (void)viewWillAppear:(BOOL)animated{
     
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.i = 0;
     self.view.backgroundColor = COLOR(255, 255, 255, 1);
     self.navigationItem.title = @"个人资料";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     
     UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
     self.navigationItem.rightBarButtonItem = right;
     
     self.userDataTable = TABLE_RECT(WIDTH5S(0), HEIGHT5S(0), SCREEN_WIDTH, HEIGHT5S(260));
     self.userDataTable.separatorStyle = NO; //隐藏分割线
     self.userDataTable.scrollEnabled = NO;
     self.userDataTable.delegate = self;
     self.userDataTable.dataSource = self;
     [self.view addSubview:self.userDataTable];
     
     self.btn = BUTTON_RECT(WIDTH5S(15), HEIGHT5S(460), WIDTH5S(290), HEIGHT5S(40));
     self.btn.layer.cornerRadius = 3;
     self.btn.layer.masksToBounds = YES;
     self.btn.titleLabel.font = FONT(15);
     [self.btn setTitle:@"保存修改" forState:UIControlStateNormal];
     self.btn.backgroundColor = COLOR(0, 210, 210, 1);
     [self.view addSubview:self.btn];
     [self.btn addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
     
     UILabel *line = LABEL_RECT(WIDTH5S(0), HEIGHT5S(260), WIDTH5S(320), HEIGHT5S(1));
     line.backgroundColor = COLOR(228, 228, 228, 1);
     [self.view addSubview:line];
     
     self.ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePic)];
     self.ges.numberOfTapsRequired = 1; //单击
     [self.userHead addGestureRecognizer:self.ges];
     
}

//修改信息
- (void)edit{
     self.i ++;
     if (self.i %2 == 1) {
          self.navigationItem.rightBarButtonItem.title = @"取消";
          [self.userMessage2 setEnabled:YES];
          [self.userMessage3 setEnabled:YES];
          
     }else{
          
          self.navigationItem.rightBarButtonItem.title = @"编辑";
          [self.userMessage2 setEnabled:NO];
          [self.userMessage3 setEnabled:NO];
          
     }
     
     
}

//手势换图
- (void)changePic{
     
     [self chosePic];
}

//保存信息
- (void)saveData{
     
     [self.navigationController popViewControllerAnimated:YES];
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
     self.userHead.image = [UIImage imageWithContentsOfFile:fullPath];
     
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     
     return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     float h;
     
     if (indexPath.row == 0) {
          h = 80.0;
     }else{
          h = 40.0;
     }
     return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     static NSString *str = @"userData";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
     if (cell == nil) {
          cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
     }
     if (indexPath.row == 0) {
          cell.accessoryType = UITableViewCellAccessoryCheckmark;
          self.cellTitle1 = LABEL_RECT(WIDTH5S(15), HEIGHT5S(30), WIDTH5S(80), HEIGHT5S(20));
          self.cellTitle1.textAlignment = 0;
          self.cellTitle1.font = FONT(15);
          self.cellTitle1.text = @"头像";
          [cell addSubview:self.cellTitle1];
          
          self.userHead = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH5S(245), HEIGHT5S(10), WIDTH5S(60), HEIGHT5S(60))];
          self.userHead.image = IMAGE(@"1.3.jpg");
          self.userHead.userInteractionEnabled = YES;
          self.userHead.layer.cornerRadius = 5;
          self.userHead.layer.masksToBounds = YES;
          [cell addSubview:self.userHead];
          
          UILabel *line = LABEL_RECT(WIDTH5S(15), HEIGHT5S(79), WIDTH5S(290), HEIGHT5S(1));
          line.backgroundColor = COLOR(228, 228, 228, 1);
          [cell addSubview:line];
          
     }else if (indexPath.row == 1){
          self.cellTitle2 = LABEL_RECT(WIDTH5S(15), HEIGHT5S(10), WIDTH5S(80), HEIGHT5S(20));
          self.cellTitle2.textAlignment = 0;
          self.cellTitle2.font = FONT(15);
          self.cellTitle2.text = @"昵称";
          [cell addSubview:self.cellTitle2];
          
          self.userMessage2 = TEXT_RECT(WIDTH5S(100), HEIGHT5S(10), WIDTH5S(205), HEIGHT5S(20));
          [self.userMessage2 setEnabled:NO]; //不可编辑
          self.userMessage2.text = @"happy";
          self.userMessage2.textAlignment = 2;
          self.userMessage2.font = FONT(15);
          [cell addSubview:self.userMessage2];
          
          UILabel *line = LABEL_RECT(WIDTH5S(15), HEIGHT5S(39), WIDTH5S(290), HEIGHT5S(1));
          line.backgroundColor = COLOR(228, 228, 228, 1);
          [cell addSubview:line];
          
     }else if (indexPath.row == 2){
          self.cellTitle3 = LABEL_RECT(WIDTH5S(15), HEIGHT5S(10), WIDTH5S(80), HEIGHT5S(20));
          self.cellTitle3.textAlignment = 0;
          self.cellTitle3.font = FONT(15);
          self.cellTitle3.text = @"手机号";
          [cell addSubview:self.cellTitle3];
          
          self.userMessage3 = TEXT_RECT(WIDTH5S(100), HEIGHT5S(10), WIDTH5S(205), HEIGHT5S(20));
          [self.userMessage3 setEnabled:NO]; //不可编辑
          self.userMessage3.text = @"110";
          self.userMessage3.textAlignment = 2;
          self.userMessage3.font = FONT(15);
          [cell addSubview:self.userMessage3];
          
          UILabel *line = LABEL_RECT(WIDTH5S(15), HEIGHT5S(39), WIDTH5S(290), HEIGHT5S(1));
          line.backgroundColor = COLOR(228, 228, 228, 1);
          [cell addSubview:line];
          
     }else if (indexPath.row == 3){
          
          self.cellTitle4 = LABEL_RECT(WIDTH5S(15), HEIGHT5S(10), WIDTH5S(80), HEIGHT5S(20));
          self.cellTitle4.textAlignment = 0;
          self.cellTitle4.font = FONT(15);
          self.cellTitle4.text = @"收货地址";
          [cell addSubview:self.cellTitle4];
          
          self.userMessage4 = LABEL_RECT(WIDTH5S(100), HEIGHT5S(10), WIDTH5S(190), HEIGHT5S(20));
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
          self.userMessage4.text = @"未添加";
          self.userMessage4.textAlignment = 2;
          self.userMessage4.font = FONT(15);
          [cell addSubview:self.userMessage4];
          
     }
     
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
     [self.userDataTable deselectRowAtIndexPath:indexPath animated:YES];
     
     if (indexPath.row == 3) {
          
          AddressViewController *avc = [[AddressViewController alloc]init];
          [self.navigationController pushViewController:avc animated:YES];
     }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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

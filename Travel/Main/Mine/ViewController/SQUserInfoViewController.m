//
//  SQUserInfoViewController.m
//  Travel
//
//  Created by yinsiqian on 2019/6/26.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQUserInfoViewController.h"
#import "SQUserInfoCell.h"

@interface SQUserInfoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *pickerVC;

@end

@implementation SQUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self setupSubviews];
}

- (void)setupSubviews {
    self.pickerVC = [UIImagePickerController new];
    self.pickerVC.delegate = self;
    self.pickerVC.allowsEditing = true;
    [self.view addSubview:self.sq_tableView];
}

- (void)updateUserIconWithImage:(UIImage *)image {
    
    [self showHUDWithMessage:@"上传图片中..."];
    [SQNetworkManager fileUpload:sq_url_combine(upload) parameters:@{} name:@"image" image:image progress:^(CGFloat progress) {
        
    } success:^(NSDictionary * _Nullable data) {
        
        NSString *imageInfo = data[@"url"];
        NSData *imageData = [imageInfo dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *result = [NSJSONSerialization JSONObjectWithData:imageData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"result---->%@", result);
        NSDictionary *info = result.firstObject;
        [SQUserModel shared].icon = [NSString stringWithFormat:@"%@/%@", info[@"baseUrl"], info[@"path"]];
        [self updateUserAvatar:[SQUserModel shared].icon];
    } fail:^(NSError * _Nullable error) {
        [self hideHUD];

    }];
}

- (void)updateUserAvatar:(NSString *)url {
    NSDictionary *params = @{@"url": url};
    [SQNetworkManager POST:sq_url_combine(update_user_avatar) parameters:params success:^(NSDictionary * _Nullable data) {
        [self hideHUD];
        [self showSuccessWithMessage:@"上传成功"];
        [self.sq_tableView reloadData];
    } fail:^(NSError * _Nullable error) {
        [self hideHUD];
    }];
}

- (void)updateUserNameWithName:(NSString *)name {
    if ([name isEmpty]) {
        [self showFailureWithMessage:@"请输入用户名"];
        return;
    }
    NSDictionary *params = @{@"username": name};
    [SQNetworkManager POST:sq_url_combine(update_name) parameters:params success:^(NSDictionary * _Nullable data) {
        [SQUserModel shared].name = name;
        [self showSuccessWithMessage:@"修改成功"];
        [self.sq_tableView reloadData];
    } fail:^(NSError * _Nullable error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 2 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SQUserInfoCell *cell = [SQUserInfoCell cellWithTableView:tableView];
        NSArray *titles = @[@"头像", @"用户名"];
        NSArray *contents = @[@"", [SQUserModel shared].name];
        [cell setDataWithTitle:titles[indexPath.row] content:contents[indexPath.row] isAvatar:indexPath.row == 0];
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"更换用户头像" preferredStyle:UIAlertControllerStyleActionSheet];
//        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self openCameraWithSourceType:UIImagePickerControllerSourceTypeCamera];
//        }];
//
//        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"手机相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self openCameraWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//
//        }];
//
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//        }];
//
//        [alert addAction:camera];
//        [alert addAction:photo];
//        [alert addAction:cancelAction];
//
//        [self presentViewController:alert animated:YES completion:nil];
    }
    if (indexPath.row == 1) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改用户名" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *name = alert.textFields.firstObject.text;
            if ([name isEqualToString: [SQUserModel shared].name]) {
                return ;
            }
            [self updateUserNameWithName:name];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = [SQUserModel shared].name;
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:ensureAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogout object:nil];
        [[SQUserModel shared] clear];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)openCameraWithSourceType:(UIImagePickerControllerSourceType)soureType {
    if (soureType == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
            [self showFailureWithMessage:@"该设备暂不支持拍摄"];
            return;
        }
    }
    self.pickerVC.sourceType = soureType;
    [self presentViewController:self.pickerVC animated:YES completion:nil];
}


#pragma mark -- UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    NSLog(@"image--->%@", image);
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (image) {
        [self updateUserIconWithImage:image];
    }
    
}


@end

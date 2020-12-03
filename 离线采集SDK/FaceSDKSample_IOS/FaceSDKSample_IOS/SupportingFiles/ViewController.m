//
//  ViewController.m
//  FaceSDKSample_IOS
//
//  Created by Tong,Shasha on 2017/5/15.
//  Copyright © 2017年 Baidu. All rights reserved.
//
#import "IDLFaceSDK/IDLFaceSDK.h"
#import "ViewController.h"
#import "BDFaceLivenessViewController.h"
#import "BDFaceDetectionViewController.h"
#import "BDFaceLivingConfigModel.h"
#import "BDFaceLivingConfigViewController.h"
#import "BDFaceAgreementViewController.h"
#import "BDFaceLogoView.h"

#define ScreenRect [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (strong, nonatomic) UIImageView *warningView;
@property (strong, nonatomic) UILabel *waringLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"screen width=%f, height=%f", ScreenWidth , ScreenHeight);
    
    // 设置按钮
    self.settingBtn.frame = CGRectMake((ScreenWidth-22-20), 42.7, 22, 22);
    [self.settingBtn setImage:[UIImage imageNamed:@"icon_titlebar_setting"] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingBtn];
    
    // 欢迎使用的label
    UILabel *welcome = [[UILabel alloc] init];
    welcome.frame = CGRectMake(51.8, 47.3, 82.3, 33.3);
    welcome.text = @"欢迎使用";
    welcome.font =  [UIFont fontWithName:@"PingFangSC-Medium" size:19.3];
    welcome.textColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:welcome];
    
    // 欢迎使用的下一行
    UILabel *welcomeNext = [[UILabel alloc] init];
    welcomeNext.frame = CGRectMake(50, 80.7, 214.7, 33.3);
    welcomeNext.text = @"百度人脸采集SDK";
    welcomeNext.font = [UIFont fontWithName:@"PingFangSC-Medium" size:25.3];
    welcomeNext.textColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:welcomeNext];
    
    // 光线的提示和图片
    UIImageView *lightImage = [[UIImageView alloc] init];
    lightImage.frame =  CGRectMake(50, 190, 60, 60);
    lightImage.image = [UIImage imageNamed:@"icon_guide1"];
    [self.view addSubview:lightImage];
    UILabel *adjustLight = [[UILabel alloc] init];
    adjustLight.frame =  CGRectMake(126, 198.7, 96, 18);
    adjustLight.text = @"识别光线适中";
    adjustLight.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    adjustLight.textColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:adjustLight];
    UILabel *adjustLight2 = [[UILabel alloc] init];
    adjustLight2.frame =  CGRectMake(126, 226, 144, 12);
    adjustLight2.text = @"请保证光线不要过暗或过亮";
    adjustLight2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    adjustLight2.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:adjustLight2];
    
    // 正对手机的图片t和提示
    UIImageView *angleImage = [[UIImageView alloc] init];
    angleImage.frame = CGRectMake(50, 282, 60, 60);
    angleImage.image = [UIImage imageNamed:@"icon_guide3"];
    [self.view addSubview:angleImage];
    UILabel *focesText = [[UILabel alloc] init];
    focesText.frame = CGRectMake(126, 290.7, 80, 18);
    focesText.text = @"请正对手机";
    focesText.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    focesText.textColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:focesText];
    UILabel *focesTextNext = [[UILabel alloc] init];
    focesTextNext.frame = CGRectMake(126, 318, 144, 12);
    focesTextNext.text = @"保持您的脸出现在取景框内";
    focesTextNext.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    focesTextNext.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:focesTextNext];
    
    // 口罩的图片和提示
    UIImageView *maskImage = [[UIImageView alloc] init];
    maskImage.frame = CGRectMake(50, 374, 60, 60);
    maskImage.image = [UIImage imageNamed:@"icon_guide2"];
    [self.view addSubview:maskImage];
    UILabel *maskText = [[UILabel alloc] init];
    maskText.frame = CGRectMake(126, 382.7, 96, 18);
    maskText.text = @"支持口罩识别";
    maskText.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    maskText.textColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:maskText];
    UILabel *maskTextNext = [[UILabel alloc] init];
    maskTextNext.frame = CGRectMake(126, 410, 180, 12);
    maskTextNext.text = @"采集无需摘掉口罩 (动作活体除外)";
    maskTextNext.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    maskTextNext.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:maskTextNext];
    
    // 开始采集的Button
    UIButton *startBtn  = [[UIButton alloc] init];
    startBtn.frame = CGRectMake((self.view.frame.size.width-266.7)/2, 478, 266.7, 52);
    [startBtn setImage:[UIImage imageNamed:@"btn_main_normal"] forState:UIControlStateNormal];
    [startBtn setImage:[UIImage imageNamed:@"btn_main_p"] forState:UIControlStateSelected];
    UILabel *btnLabel = [[UILabel alloc] init];
    btnLabel.frame = CGRectMake((self.view.frame.size.width-108)/2, 495, 108, 18);
    btnLabel.text = @"开始人脸采集";
    btnLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    btnLabel.textColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1 / 1.0];
    [self.view addSubview:startBtn];
    [self.view addSubview:btnLabel];
    [startBtn addTarget:self action:@selector(startGatherAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * remindView = [[UIView alloc] init];
    remindView.frame = CGRectMake((self.view.frame.size.width-162)/2, 546, ScreenWidth, 14);
    
    // 勾选人脸验证协议的button
    UIButton *checkAgreeBtn = [[UIButton alloc] init];
    checkAgreeBtn.frame = CGRectMake(0, 0, 14, 14);
    [checkAgreeBtn setImage:[UIImage imageNamed:@"icon_guide"] forState:UIControlStateNormal];
    [checkAgreeBtn addTarget:self action:@selector(checkAgreeClick:) forControlEvents:UIControlEventTouchUpInside];
    [remindView addSubview:checkAgreeBtn];
    
    UILabel *agreeLabel = [[UILabel alloc] init];
    agreeLabel.frame = CGRectMake(22, 0, 28, 14);
    agreeLabel.text = @"同意";
    agreeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    agreeLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1 / 1.0];
    [remindView addSubview:agreeLabel];
    
    // 人脸验证协议的label，提供了点击响应事件
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.frame = CGRectMake(50, 0, 112, 14);
    remindLabel.text = @"《人脸验证协议》";
    remindLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    remindLabel.textColor = [UIColor colorWithRed:0 / 255.0 green:186 / 255.0 blue:242 / 255.0 alpha:1 / 1.0];
    remindLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreementAction:)];
    [remindLabel addGestureRecognizer:labelTapGestureRecognizer];
    [remindView addSubview:remindLabel];
    [self.view addSubview:remindView];
    
    
    // 不正常操作问题
    // 弹窗的view
    self.warningView = [[UIImageView alloc] init];
    self.warningView.frame = CGRectMake((ScreenWidth - 208) / 2, 298, 208, 44);
    self.warningView.image = [UIImage imageNamed:@"icon_notice"];
    // 弹窗的label内容
    self.waringLabel = [[UILabel alloc] init];
    self.waringLabel.frame = CGRectMake((ScreenWidth - 168) / 2, 310, 168, 14);
    self.waringLabel.text = @"请先同意《人脸验证协议》";
    self.waringLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.waringLabel.textColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1 / 1.0];
    
    // 设置logo，底部的位置和大小，实例化显示
    BDFaceLogoView* logoView = [[BDFaceLogoView alloc] initWithFrame:CGRectMake(0, (ScreenHeight-15-12), ScreenWidth, 12)];
    [self.view addSubview:logoView];
    
    [self initSDK];
    
    [self initLivenesswithList];
}

- (IBAction)checkAgreeClick:(UIButton *)sender {
    sender.selected ^= 1;
    // 如果再次点击选中button，提示窗口消失
    [self.warningView removeFromSuperview];
    [self.waringLabel removeFromSuperview];
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"icon_guide_s"] forState:UIControlStateSelected];
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"checkAgreeBtn"];
    } else {
        [sender setImage:[UIImage imageNamed:@"icon_guide"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"checkAgreeBtn"];
        
    }
}


#pragma mark - Button Action
- (IBAction)startGatherAction:(UIButton *)sender{
    // 检测是否同意，如果同意"开始人脸采集"可点击
    NSNumber *checkAgree = [[NSUserDefaults standardUserDefaults] objectForKey:@"checkAgreeBtn"];
    if (!checkAgree.boolValue){
        [self.view addSubview:self.warningView];
        [self.view addSubview:self.waringLabel];
        return;
    }
    // 读取设置配置，启动活体检测与否
    NSNumber *LiveMode = [[NSUserDefaults standardUserDefaults] objectForKey:@"LiveMode"];
    if (LiveMode.boolValue){
        [self faceLiveness];
    } else {
        [self faceDetect];
    }
}


- (void)faceDetect {
    BDFaceDetectionViewController* dvc = [[BDFaceDetectionViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:dvc];
    navi.navigationBarHidden = true;
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)faceLiveness {
    BDFaceLivenessViewController* lvc = [[BDFaceLivenessViewController alloc] init];
    BDFaceLivingConfigModel* model = [BDFaceLivingConfigModel sharedInstance];
    [lvc livenesswithList:model.liveActionArray order:model.isByOrder numberOfLiveness:model.numOfLiveness];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:lvc];
    navi.navigationBarHidden = true;
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}

- (IBAction)agreementAction:(UILabel *)sender{
    BDFaceAgreementViewController *avc = [[BDFaceAgreementViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:avc];
    navi.navigationBarHidden = true;
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
}

- (IBAction)settingAction:(UIButton *)sender{
    BDFaceLivingConfigViewController *lvc = [[BDFaceLivingConfigViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:lvc];
    navi.navigationBarHidden = true;
    navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:nil];
    
}

#pragma mark - UI Action
- (void) initSDK {
    
    if (![[FaceSDKManager sharedInstance] canWork]){
        NSLog(@"授权失败，请检测ID 和 授权文件是否可用");
        return;
    }
    
    // 初始化SDK配置参数，可使用默认配置
    // 设置最小检测人脸阈值
    [[FaceSDKManager sharedInstance] setMinFaceSize:200];
    // 设置截取人脸图片高
    [[FaceSDKManager sharedInstance] setCropFaceSizeWidth:400];
    // 设置截取人脸图片宽
    [[FaceSDKManager sharedInstance] setCropFaceSizeHeight:640];
    // 设置人脸遮挡阀值
    [[FaceSDKManager sharedInstance] setOccluThreshold:0.5];
    // 设置亮度阀值
    [[FaceSDKManager sharedInstance] setIllumThreshold:40];
    // 设置图像模糊阀值
    [[FaceSDKManager sharedInstance] setBlurThreshold:0.3];
    // 设置头部姿态角度
    [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:10 yaw:10 roll:10];
    // 设置人脸检测精度阀值
    [[FaceSDKManager sharedInstance] setNotFaceThreshold:0.6];
    // 设置抠图的缩放倍数
    [[FaceSDKManager sharedInstance] setCropEnlargeRatio:3.0];
    // 设置照片采集张数
    [[FaceSDKManager sharedInstance] setMaxCropImageNum:6];
    // 设置超时时间
    [[FaceSDKManager sharedInstance] setConditionTimeout:15];
    // 设置开启口罩检测，非动作活体检测可以采集戴口罩图片
    [[FaceSDKManager sharedInstance] setIsCheckMouthMask:true];
    // 设置开启口罩检测情况下，非动作活体检测口罩过滤阈值，默认0.8 不需要修改
    [[FaceSDKManager sharedInstance] setMouthMaskThreshold:0.8f];
    // 设置原始图缩放比例
    [[FaceSDKManager sharedInstance] setImageWithScale:0.8f];
    // 设置图片加密类型，type=0 基于base64 加密；type=1 基于百度安全算法加密
    [[FaceSDKManager sharedInstance] setImageEncrypteType:0];
    // 初始化SDK功能函数
    [[FaceSDKManager sharedInstance] initCollect];
    
    
}

- (void)initLivenesswithList {
    // 默认活体检测打开，顺序执行
    [BDFaceLivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveEye)];
    [BDFaceLivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveMouth)];
    [BDFaceLivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveYawRight)];
    [BDFaceLivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveYawLeft)];
    [BDFaceLivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLivePitchUp)];
    [BDFaceLivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLivePitchDown)];
    [BDFaceLivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveYaw)];
    BDFaceLivingConfigModel.sharedInstance.isByOrder = YES;
    BDFaceLivingConfigModel.sharedInstance.numOfLiveness = 7;
}

- (void) destorySDK{
    // 销毁SDK功能函数
    [[FaceSDKManager sharedInstance] uninitCollect];
}

@end

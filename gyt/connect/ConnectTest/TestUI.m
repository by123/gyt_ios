//
//  TestUI.m
//  ConnectTest
//
//  Created by  SmallTask on 13-8-15.
//
//

#import "TestUI.h"

@interface TestUI ()

@property (strong, nonatomic)  UITextField *tfAddress;
@property (strong, nonatomic)  UITextField *tfPort;
@property (strong, nonatomic)  UIButton *btConnect;
@property (strong, nonatomic)  UIButton *btSend;


@property (strong, nonatomic)  UILabel *lbConnectionResult;

@property (strong, nonatomic)  UITextField *tftxt;

@property (strong, nonatomic)  UITextView *tfRecived;

@end

@implementation TestUI

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self netstate];
}

-(void)initView
{
    _tfAddress = [[UITextField alloc]init];
    _tfAddress.text = @"192.168.1.111";
    _tfAddress.frame = CGRectMake(0, 40, 200, 50);
    [self.view addSubview:_tfAddress];
    
    _tfPort = [[UITextField alloc]init];
    _tfPort.frame = CGRectMake(0, 60, 200, 50);
    _tfPort.text = @"64350";
    [self.view addSubview:_tfPort];
    
    _btConnect = [[UIButton alloc]init];
    _btConnect.backgroundColor = [UIColor orangeColor];
    [_btConnect setTitle:@"连接" forState:UIControlStateNormal];
    _btConnect.frame = CGRectMake(0, 100, 200, 50);
    [_btConnect addTarget:self action:@selector(onBtConnection:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btConnect];

    _lbConnectionResult = [[UILabel alloc]init];
    _lbConnectionResult.text = @"结果:";
    _lbConnectionResult.frame = CGRectMake(0, 160, 200, 40);
    [self.view addSubview:_lbConnectionResult];
    

    _tftxt = [[UITextField alloc]init];
    _tftxt.frame = CGRectMake(0, 200, 200, 50);
    [self.view addSubview:_tftxt];
    
    _btSend = [[UIButton alloc]init];
    _btSend.backgroundColor = [UIColor orangeColor];
    [_btSend setTitle:@"发送" forState:UIControlStateNormal];
    [_btSend addTarget:self action:@selector(onbtClicked:) forControlEvents:UIControlEventTouchUpInside];

    _btSend.frame = CGRectMake(0, 260, 200, 50);
    [self.view addSubview:_btSend];
    
    _tfRecived = [[UITextView alloc]init];
    _tfRecived.frame = CGRectMake(0, 300, 200, 50);
    [self.view addSubview:_tfRecived];

    

}

-(void)netstate;
{
    NSLog(@"开启 www.baidu.com 的网络检测");
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NSLog(@"-- current status: %@", reach.currentReachabilityString);
    
    // start the notifier which will cause the reachability object to retain itself!
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    /*
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.blockLabel.text = @"网络可用";
//            self.blockLabel.backgroundColor = [UIColor greenColor];
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tfRecived.text = @"网络不可用";
            self.tfRecived.backgroundColor = [UIColor redColor];
        });
    };
    
    */
    [reach startNotifier];
      
}

- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        self.tfRecived.text = @"网络不可用";
        self.tfRecived.backgroundColor = [UIColor redColor];
        
//        self.wifiOnlyLabel.backgroundColor = [UIColor redColor];
//        self.wwanOnlyLabel.backgroundColor = [UIColor redColor];
        
        TcpClient *tcp = [TcpClient sharedInstance];
        [tcp setDelegate_ITcpClient:self];
        
        [tcp.asyncSocket disconnect];
        
        return;
    }
    
    self.tfRecived.text = @"网络可用";
    self.tfRecived.backgroundColor = [UIColor greenColor];
    
    if (reach.isReachableViaWiFi) {
        self.tfRecived.backgroundColor = [UIColor greenColor];
        self.tfRecived.text = @"当前通过wifi连接";
    } else {
        self.tfRecived.backgroundColor = [UIColor redColor];
        self.tfRecived.text = @"wifi未开启，不能用";
    }
    
    if (reach.isReachableViaWWAN) {
        self.tfRecived.backgroundColor = [UIColor greenColor];
        self.tfRecived.text = @"当前通过2g or 3g连接";
    } else {
        self.tfRecived.backgroundColor = [UIColor redColor];
        self.tfRecived.text = @"2g or 3g网络未使用";
    }
}


- (void)onBtConnection:(id)sender {
    TcpClient *tcp = [TcpClient sharedInstance];
    [tcp setDelegate_ITcpClient:self];
    if(tcp.asyncSocket.isConnected)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络已经连接好啦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else
    {
        NSString *HOST = self.tfAddress.text;
        NSString *port = self.tfPort.text;
        [tcp openTcpConnection:HOST port:[port intValue]];
    }
    
    [self resignKeyboard];
    
}

//发送消息
- (void)onbtClicked:(id)sender {
    
    TcpClient *tcp = [TcpClient sharedInstance];
    if(tcp.asyncSocket.isDisconnected)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络不通" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }else if(tcp.asyncSocket.isConnected)
    {

        NSString *requestStr = [NSString stringWithFormat:@"%@\r\n",self.tftxt.text];
        [tcp writeString:requestStr];
    
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"TCP链接没有建立" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
    [self resignKeyboard];
}

-(void)resignKeyboard;
{
    [self.tfAddress resignFirstResponder];
    [self.tfPort resignFirstResponder];
    [self.tftxt resignFirstResponder];
}

#pragma mark -
#pragma mark ITcpClient

/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt;
{
    self.tfRecived.text = [NSString stringWithFormat:@"%@\r\nsended-->:%@\r\n",self.tfRecived.text,sendedTxt];
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSString*)recivedTxt;
{
    self.tfRecived.text = [NSString stringWithFormat:@"%@\r\n-->recived:%@\r\n",self.tfRecived.text,recivedTxt];
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err;
{
    self.tfRecived.text = [NSString stringWithFormat:@"%@\r\n\r\n**** network error! ****\r\n",self.tfRecived.text];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_tfAddress resignFirstResponder];
    [_tfPort resignFirstResponder];
    [_tftxt resignFirstResponder];

}

@end

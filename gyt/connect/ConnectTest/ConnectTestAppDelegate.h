#import <UIKit/UIKit.h>
#import "TestUI.h"
#import "TcpClient.h"

@class GCDAsyncSocket;


@interface ConnectTestAppDelegate : NSObject <UIApplicationDelegate>
{
	GCDAsyncSocket *asyncSocket;
}

@property(nonatomic,retain) TcpClient *tcpClient;

@property (nonatomic, strong) IBOutlet UIWindow *window;

@end

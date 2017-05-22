//
//  Parameters.h
//  QingYue
//
//  Created by leilei on 2017/3/26.
//  Copyright © 2017年 com.lanou.product_A. All rights reserved.
//

#ifndef Parameters_h
#define Parameters_h
/**适配宏  */
#define SUITABLE_WIDTH 375.0 * MSSize_Width
#define SUITABLE_HEIGHT 667.0 * MSSize_Height

#define MSSize_Bounds [UIScreen mainScreen].bounds
#define MSSize_Width [UIScreen mainScreen].bounds.size.width
#define MSSize_Height [UIScreen mainScreen].bounds.size.height
#define kSVS_Width self.bounds.size.width
#define kSVS_Height self.bounds.size.height
#define kTB_Height 49
#define kNB_Height 64
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define Font(R) [UIFont systemFontOfSize:R];
#define kSC_W (375.f/MSSize_Width)
#define kSC_H (667.f/MSSize_Height)
#define RGB(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A/1.0]

#define MyRedColor [UIColor colorWithRed:244/255.0f green:68/255.0f blue:68/255.0f alpha:1/1.0]
#define MyGrayColor [UIColor colorWithRed:240/255.0f green:241/255.0f blue:245/255.0f alpha:1/1.0]
#define MyBlueColor [UIColor colorWithRed:19/255.0f green:139/255.0f blue:202/255.0f alpha:1/1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define MyGreenColor [UIColor colorWithRed:38/255.0f green:203/255.0f blue:100/255.0f alpha:1/1.0]

#define kNumber @"0123456789\n"
#define kPassWord @"0123456789abcdefghijklmnopqrstuvwxyz\n"

#define kWScale(R) (MSSize_Width/375.f)*R
#define kHScale(R) (MSSize_Height/375.f)*R



#define FFont(S) [UIFont systemFontOfSize:S]
#define kWFont(S) (MSSize_Width>320)?(MSSize_Width>375?FFont(S*(414/375.f)):FFont(S*(375/375.f))):FFont(S*(320/375.f))

#define BFont(S) [UIFont boldSystemFontOfSize:S]
#define kBFont(S) (MSSize_Width>320)?(MSSize_Width>375?BFont(S*(414/375.f)):BFont(S*(375/375.f))):BFont(S*(320/375.f))

#define AlertReqestFailureText  @"网络请求失败,稍后重试"
#define NetWorkingText          @"努力加载中..."
#define ISStringEqual(A,B)  [A isEqualToString:B]


#define kShowNet(S) [SVProgressHUD showWithStatus:S]
#define kHideNet [SVProgressHUD dismiss]

#define kTimeAfter(T,Block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(T * NSEC_PER_SEC)), dispatch_get_main_queue(), Block);

#endif /* Parameters_h */

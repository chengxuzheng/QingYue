//
//  Parameters.h
//  Yuncang
//
//  Created by ChengxuZheng on 15/11/18.
//  Copyright © 2015年 ChengxuZheng. All rights reserved.
//

#ifndef Parameters_h
#define Parameters_h


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

#endif /* Parameters_h */

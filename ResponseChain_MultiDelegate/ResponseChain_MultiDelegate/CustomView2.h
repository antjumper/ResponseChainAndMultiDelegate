//
//  CustomView2.h
//  ResponseChain_MultiDelegate
//
//  Created by 刘红波 on 2018/7/2.
//  Copyright © 2018年 flex. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomView2;

@protocol CustomView2Delegate<NSObject>
@optional
- (void)customView2:(CustomView2 *)view2 clickedWith:(UIButton *) button userInformation:(NSDictionary *)dict;

@end

@interface CustomView2 : UIView

@property (nonatomic,weak) id <CustomView2Delegate> delegate;

@end

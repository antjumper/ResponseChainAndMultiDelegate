//
//  CustomView2.m
//  ResponseChain_MultiDelegate
//
//  Created by 刘红波 on 2018/7/2.
//  Copyright © 2018年 flex. All rights reserved.
//

#import "CustomView2.h"

@interface CustomView2 ()

@property (nonatomic,strong) UIButton *button2;

@end

@implementation CustomView2

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.button2];
    }
    return self;
    
}
- (void)clickevent:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(customView2:clickedWith:userInformation:)]) {
        [self.delegate customView2:self clickedWith:self.button2 userInformation:@{@"2":@"2"}];
    }
}

#pragma mark - UIButton getter方法
- (UIButton *)button2
{
    if (_button2 == nil)
    {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.frame = self.bounds;
        _button2.backgroundColor = [UIColor clearColor];
        [_button2 addTarget:self action:@selector(clickevent:) forControlEvents:UIControlEventTouchUpInside];
        _button2.backgroundColor = [UIColor greenColor];
        
    }
    return _button2;
}


@end

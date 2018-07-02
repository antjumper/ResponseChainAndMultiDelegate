//
//  CustomeView.m
//  ResponseChain_MultiDelegate
//
//  Created by 刘红波 on 2018/7/2.
//  Copyright © 2018年 flex. All rights reserved.
//

#import "CustomeView.h"
#import "UIResponder+MethodRouter.h"
@interface CustomeView ()

@property (nonatomic,strong) UIButton *button1;

@end

@implementation CustomeView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.button1];
    }
    return self;

}
- (void)clickevent:(UIButton *)btn {
    [self routerEventWithSelectorName:@"redButtonClick:userInformation:" object:btn userInfo:@{@"1":@"1"}];
}

#pragma mark - UIButton getter方法
- (UIButton *)button1
{
    if (_button1 == nil)
    {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame = self.bounds;
        _button1.backgroundColor = [UIColor clearColor];
        [_button1 addTarget:self action:@selector(clickevent:) forControlEvents:UIControlEventTouchUpInside];
        _button1.backgroundColor = [UIColor redColor];
        
    }
    return _button1;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

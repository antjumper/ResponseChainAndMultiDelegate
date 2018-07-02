//
//  UIResponder+MethodRouter.m
//  ResponseChain_MultiDelegate
//
//  Created by 刘红波 on 2018/7/2.
//  Copyright © 2018年 flex. All rights reserved.
//

#import "UIResponder+MethodRouter.h"

@implementation UIResponder (MethodRouter)

- (void)routerEventWithSelectorName:(NSString *)selectorName
                             object:(id)object
                           userInfo:(NSDictionary *)userInfo {
    
    NSLog(@"%@-routerEventWithSelectorName",NSStringFromClass([self class]));
    
    [[self nextResponder] routerEventWithSelectorName:selectorName
                                               object:object
                                             userInfo:userInfo];
}


@end

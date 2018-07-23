//
//  ViewController.m
//  ResponseChain_MultiDelegate
//
//  Created by 刘红波 on 2018/7/2.
//  Copyright © 2018年 flex. All rights reserved.
//

#import "ViewController.h"
#import "CustomeView.h"
#import "UIResponder+MethodRouter.h"



#import "CustomView2.h"
#import "MultipleDelegateObject.h"
@interface ViewController () <CustomView2Delegate>
@property (nonatomic,strong) CustomeView *customView;


@property (nonatomic,strong) CustomView2 *view2;

@property (strong, nonatomic) MultipleDelegateObject *helper;//必须强制持有  否者被释放了


@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.customView = [[CustomeView alloc] initWithFrame:CGRectMake(00, 0, 50, 50)];
    
    self.customView.center = self.view.center;
    
    [self.view addSubview:self.customView];
    
    self.view2 = [[CustomView2 alloc] initWithFrame:CGRectMake(0, self.view.center.y + 60, 80, 80)];
    
    [self.view addSubview:self.view2];
    
    MultipleDelegateObject *helper = [MultipleDelegateObject new];
    helper.delegateTargets = @[self];
    self.helper = helper;
    self.view2.delegate = (id <CustomView2Delegate>)helper;
    
    
}


- (void)customView2:(CustomView2 *)view2 clickedWith:(UIButton *) button userInformation:(NSDictionary *)dict {
    NSLog(@"点击了绿色按钮");
    
    
}
//redButtonClick:userInformation:
- (NSInteger)redButtonClick:(UIButton *)btn userInformation:(NSDictionary *)dict{
    
    NSLog(@"点击了红色按钮");
    
    return 1;
    
}

- (void)routerEventWithSelectorName:(NSString *)selectorName
                             object:(id)object
                           userInfo:(NSDictionary *)userInfo {
    
    
    SEL action = NSSelectorFromString(selectorName);

    NSMutableArray *arr = [NSMutableArray array];
    if(object) {[arr addObject:object];};
    if(userInfo) {[arr addObject:userInfo];};
    NSNumber *returnValue = [self performSelector:action withObjects:arr];

    NSLog(@"returnValue -- %@",@([returnValue integerValue]));
    
}

- (id)performSelector:(SEL)aSelector withObjects:(NSArray <id> *)objects {
    
    
    //创建签名对象
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    //判断传入的方法是否存在
    if (!signature) { //不存在
        //抛出异常
        NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance",[self class],NSStringFromSelector(aSelector)];
        @throw [[NSException alloc] initWithName:@"ResponseChain remind:" reason:info userInfo:nil];
        return nil;
    }
    
    //创建 NSInvocation 对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    //保存方法所属的对象
    invocation.target = self;
    invocation.selector = aSelector;
    
    
    //设置参数
    //存在默认的 _cmd、target 两个参数，需剔除
    NSInteger arguments = signature.numberOfArguments - 2;
    
    //谁少就遍历谁,防止数组越界
    NSUInteger objectsCount = objects.count;
    NSInteger count = MIN(arguments, objectsCount);
    for (int i = 0; i < count; i++) {
        id obj = objects[i];
        //处理参数是 NULL 类型的情况
        if ([obj isKindOfClass:[NSNull class]]) {obj = nil;}
        [invocation setArgument:&obj atIndex:i+2];
    }
    
    //调用
    [invocation invoke];
    
    //如果调用的消息有返回值，那么可进行以下处理
    
    //获得返回值类型
    const char *returnType = signature.methodReturnType;
    //声明返回值变量
    //如果没有返回值，也就是消息声明为void，那么returnValue=nil
    if( strcmp(returnType, @encode(void)) == 0 ){
        return nil;
    }
    //如果返回值为对象，那么为变量赋值
    else if( strcmp(returnType, @encode(id)) == 0 ){
        id returnValue;
        [invocation getReturnValue:&returnValue];
        return returnValue;
    }else{
        //如果返回值为普通类型NSInteger  BOOL
        if( strcmp(returnType, @encode(NSInteger)) == 0 ) {
            NSInteger result = 0;
            [invocation getReturnValue:&result];
            return @(result);
        }else if (strcmp(returnType, @encode(BOOL)) == 0) {
            
            BOOL result = 0;
            [invocation getReturnValue:&result];
            return @(result);
            
        }else if (strcmp(returnType, @encode(CGFloat)) == 0) {
            
            CGFloat result = 0;
            [invocation getReturnValue:&result];
            return @(result);
        }else if (strcmp(returnType, @encode(NSUInteger)) == 0) {
            
            NSUInteger result = 0;
            [invocation getReturnValue:&result];
            return @(result);
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  GCDObjcViewController.m
//  GCDDemo
//
//  Created by 逢阳曹 on 2017/2/8.
//  Copyright © 2017年 逢阳曹. All rights reserved.
//

#import "GCDObjcViewController.h"

@interface GCDObjcViewController ()

@end

@implementation GCDObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //demo 调试
//    [self dispatchSetTargetQueueDemo];
//    [self dispatchBarrierAsyncDemo];
//    [self dispatchApplyDemo];
//    [self dispatchDealWiththreadWithMaybeExplode:false];
//    [self dispatchGroupsWaitDemo];
//    [self dispatchGroupNotifyDemo];
//    [self createDispatchBlock];
//    [self dispatchBlockWaitDemo];
    [self dispatchBlockNotifyDemo];
//    [self dispatchBlockCancelDemo];
}

#pragma mark - GCD Demo

//队列分类
- (void)queueCategories {
    //全局主队列 串行
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //全局并发队列 按优先级区分 一共有四个 用户无法被创建 只能获取
    dispatch_queue_t globalLowQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t globalDefaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t globalHighQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_queue_t globalBackgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    //自定义队列
    //串行队列
    dispatch_queue_t customSerialQueue = dispatch_queue_create("com.fengyangcao.serialqueue", DISPATCH_QUEUE_SERIAL);
    //并行队列
    dispatch_queue_t customConcurrentQueue = dispatch_queue_create("com.fengyangcao.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    //自定义队列的优先级
    //方法一:
    //dispatch_queue_attr_make_with_qos_class iOS8之后出现 以前的DISPATCH_QUEUE_PRIORITY属性已经废弃
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, -1);
    dispatch_queue_t customPriorityqueue1 = dispatch_queue_create("com.fengyangcao.qosqueue", attr);
    
    
    //方法二:
    //dispatch_set_target_queue 设置和某个队列一样的优先级
    dispatch_queue_t customPriorityqueue2 = dispatch_queue_create("com.fengyangcao.qosqueue", NULL);
    dispatch_queue_t referQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_set_target_queue(customSerialQueue, referQueue);
}

//dispatch_set_target_queue
- (void)dispatchSetTargetQueueDemo {
    
    //让多个串行和并行队列在统一一个串行队列里串行执行
    dispatch_queue_t serialQueue = dispatch_queue_create("com.fengyangcao.gcdDemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t firstQueue = dispatch_queue_create("com.fengyangcao.gcdDemo.firstqueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t secondQueue = dispatch_queue_create("com.fengyangcao.gcdDemo.secondqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_set_target_queue(firstQueue, serialQueue);
    dispatch_set_target_queue(secondQueue, serialQueue);
    
    dispatch_async(firstQueue, ^{
        NSLog(@"4");
        [NSThread sleepForTimeInterval:4.f];
    });
    
    dispatch_async(firstQueue, ^{
        NSLog(@"3");
        [NSThread sleepForTimeInterval:3.f];
    });
    
    dispatch_async(secondQueue, ^{
        NSLog(@"2");
        [NSThread sleepForTimeInterval:2.f];
    });
    
    dispatch_async(secondQueue, ^{
        NSLog(@"1");
        [NSThread sleepForTimeInterval:1.f];
    });
}

//dispatch_barrier_async
- (void)dispatchBarrierAsyncDemo {
    
    //dispatch_barrier_async 线程阻塞解决多线程并发读写同一个资源时发生死锁
    //防止文件读写冲突，可以创建一个串行队列，操作都在这个队列中进行，没有更新数据读用并行，写用串行。
    dispatch_queue_t dataQueue = dispatch_queue_create("com.fengyangcao.gcddemo.dataqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:5.f];
        NSLog(@"read data 1");
    });
    
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 2");
    });
    
    //等待前面的都完成 在执行barrier后面的
    dispatch_barrier_async(dataQueue, ^{
        NSLog(@"write data 1");
    });
    
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"read data 3");
    });
    
    dispatch_async(dataQueue, ^{
        NSLog(@"read data 4");
    });
}

//dispatch_apply
- (void)dispatchApplyDemo {
    //因为可以并行执行，所以使用dispatch_apply可以运行的更快
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.fengyangcao.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10, concurrentQueue, ^(size_t i) {
        NSLog(@"%zu", i);
        //并发无序
    });
    NSLog(@"The end");//dispatch_apply会阻塞主线程
}

//dispatch_apply 避免线程爆炸
- (void)dispatchDealWiththreadWithMaybeExplode:(BOOL)explode {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.fengyangcao.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    if (explode) {
        //有问题的情况, 可能会死锁
        for (int i = 0; i < 99999; i++) {
            dispatch_async(concurrentQueue, ^{
                NSLog(@"wrong %d", i);
                //do something hard
            });
        }
    }else {
        //会优化很多 能够利用GCD管理线程
        dispatch_apply(99999, concurrentQueue, ^(size_t i) {
            NSLog(@"correct %zu", i);
            //do something hard
        });
    }
}

//dispatch_group_t 监视多个异步任务

//dispatch_group_wait
- (void)dispatchGroupsWaitDemo {
    //dispatch_group_wait 阻塞当前进程 等所有的任务都完成或等待超时
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.fengyangcao.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    //在group中添加队列的block
    dispatch_group_async(group, concurrentQueue, ^{
        [NSThread sleepForTimeInterval:5.f];
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
    });
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, DISPATCH_TIME_FOREVER);
    //设置超时时长 15秒 当超时后 result返回一个非0的数字 标识超时
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"go on");
}

//dispatch_group_notify
- (void)dispatchGroupNotifyDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.fengyangcao.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t concurrentQueue2 = dispatch_queue_create("com.fengyangcao.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t group = dispatch_group_create();
    
    //dispatch_group_async == dispatch_group_enter + dispatch_group_leave
//    dispatch_group_enter(group);
//    NSLog(@"1");
//    dispatch_group_leave(group);
//    
//    dispatch_group_enter(group);
//    [NSThread sleepForTimeInterval:5.f];
//    NSLog(@"2");
//    dispatch_group_leave(group);
    
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue2, ^{
        [NSThread sleepForTimeInterval:5.f];
        NSLog(@"2");
    });
    dispatch_group_notify(group, concurrentQueue, ^{
        NSLog(@"end");
    });
    NSLog(@"can continue");
}

//dispatch_block

//创建block
- (void)createDispatchBlock {
    //normal way
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.fengyangcao.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t block = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
        NSLog(@"run block");
        [NSThread sleepForTimeInterval:3.f];
    });
    dispatch_async(concurrentQueue, block);
    
    //QOS way
    dispatch_block_t qosBlock = dispatch_block_create_with_qos_class(0, QOS_CLASS_USER_INITIATED, -1, ^{
        NSLog(@"run qos block");
    });
    dispatch_async(concurrentQueue, qosBlock);
}

//dispatch_block_wait
- (void)dispatchBlockWaitDemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.fengyangcao.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"start");
        [NSThread sleepForTimeInterval:5.f];
        NSLog(@"end");
    });
    dispatch_async(serialQueue, block);
    //设置DISPATCH_TIME_FOREVER会一直等到前面任务都完成
    dispatch_block_wait(block, DISPATCH_TIME_FOREVER);
    NSLog(@"ok, now can go on");
}

//dispatch_block_notify
- (void)dispatchBlockNotifyDemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.fengyangcao.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_block_t firstBlock = dispatch_block_create(0, ^{
        NSLog(@"first block start");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"first block end");
    });
    dispatch_async(serialQueue, firstBlock);
    dispatch_block_t secondBlock = dispatch_block_create(0, ^{
        NSLog(@"second block run");
    });
    //first block执行完才在serial queue中执行second block
    dispatch_block_notify(firstBlock, serialQueue, secondBlock);
}

//dispatch_block_cancel：iOS8后GCD支持对dispatch block的取消
- (void)dispatchBlockCancelDemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t firstBlock = dispatch_block_create(0, ^{
        NSLog(@"first block start");
        [NSThread sleepForTimeInterval:5.f];
        NSLog(@"first block end");
    });
    dispatch_block_t secondBlock = dispatch_block_create(0, ^{
        NSLog(@"second block run");
    });
    dispatch_async(serialQueue, firstBlock);
    dispatch_async(serialQueue, secondBlock);
    //取消secondBlock
    dispatch_block_cancel(secondBlock);
}

//dispatch_io 文件读取
- (void)dispatchIODemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_io_t channel = dispatch_io_create(DISPATCH_IO_STREAM, 0, serialQueue, ^(int error) {
        
    });
}

@end

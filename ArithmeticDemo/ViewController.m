//
//  ViewController.m
//  ArithmeticDemo
//
//  Created by 冯磊 on 2019/3/26.
//  Copyright © 2019年 FL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数组中重复的数字
    long repetitiveNumber = [self fetchRepetitiveNumberWithArray:@[@2, @3, @1, @0, @2, @5, @3]];
    NSLog(@"repetitiveNumber = %ld",repetitiveNumber);
    
    //二维数组中的查找
    NSArray *array = @[
                       @[@1,@2,@3,@4],
                       @[@5,@6,@7,@8],
                       @[@9,@10,@11,@12]
                       ];
    BOOL contain = [self fetchTwoDimensionalArray:array withNumber:7];
    NSLog(@"contain = %d",contain);
    
    //跳台阶最大次数
    NSLog(@" step = %ld",[self jumpStepWithTotal:5]);

    //连续子序列的最大和
    NSLog(@"sum = %ld",[self fetchMaxSumWithArray:@[@6,@-3,@-2,@7,@-15,@1,@2,@2]]);
    
}

/**数组中重复的数字
 **题目描述**
 在一个长度为 n 的数组里的所有数字都在 0 到 n-1 的范围内。数组中某些数字是重复的，但不知道有几个数字是重复的。也不知道每个数字重复几次。请找出数组中任意一个重复的数字。例如，如果输入长度为 7 的数组 {2, 3, 1, 0, 2, 5, 3}，那么对应的输出是第一个重复的数字 2。
 */
- (long)fetchRepetitiveNumberWithArray:(NSArray *)array {
    if (array.count <= 0) {
        return -1;
    }
    for (int i = 0 ; i < array.count; i++) {
        for (int j = i + 1; j < array.count; j++) {
            if (array[i] == array[j]) {
                return [array[i] longValue];
                break;
            }
        }
    }
    return -1;
}

/*
 ## 二维数组中的查找
 
 **题目描述**
 
 在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。
 */

- (BOOL)fetchTwoDimensionalArray:(NSArray *)array withNumber:(NSInteger)number{
    if (array == nil || array.count <= 0) {
        return NO;
    }
    NSInteger m = array.count;
    NSInteger n = [[array objectAtIndex:0] count];
    NSInteger row = 0;
    NSInteger col = n - 1; /*二维数组右上角 左边数字都比它小 下边数字都比它大*/
    while (row < m&& col >= 0) {
        if ([array[row][col] longValue] == number) {
            return YES;
        }else if (number < [array[row][col] longValue]) {
            col--;
        }else {
            row++;
        }
    }
    
    return NO;
}

/*
 ## 跳台阶
 
 **题目描述**
 
 一只青蛙一次可以跳上 1 级台阶，也可以跳上 2 级。求该青蛙跳上一个 n 级的台阶总共有多少种跳法。
 */
- (NSInteger)jumpStepWithTotal:(long)total {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(1)];
    [array addObject:@(2)];
    
    for (int i = 2; i < total; i++) {
        long temp1 = [[array objectAtIndex:i-1] longValue];
        long temp2 = [[array objectAtIndex:i-2] longValue];
        [array addObject:@(temp1+temp2)];
    }
    
    return [[array lastObject] longValue];
    
}

/*
 ## 连续子系列的最大和
 
 **题目描述**
 
 {6,-3,-2,7,-15,1,2,2}，连续子向量的最大和为 8（从第 0 个开始,到第 3 个为止）
 
 */
- (long)fetchMaxSumWithArray:(NSArray *)array {
    long sum = 0;
    long theSum = 0;
    
    for (int i = 0; i < array.count ; i++) {
        theSum += [array[i] longValue];
        if (theSum > sum) {
            sum = theSum;
        }else if (theSum < 0) {
            theSum = 0;
        }
    }
    return sum;
}

/**
 快速排序

 @param array 待排序数组
 @param leftNumber 0
 @param rightNumber array.coun - 1
 */
- (void)fetchQuickSortWithArray:(NSMutableArray *)array
                                left:(NSInteger)leftNumber
                               right:(NSInteger)rightNumber {
    if (leftNumber >= rightNumber) {
        return;
    }
    NSInteger i = leftNumber;
    NSInteger j = rightNumber;
    long key = [array[i] longValue];
    while (i < j) {
        while (i < j && key < [array[j] longValue]) {
            j--;
        }
        array[i] = array[j];
        while (i < j && key > [array[i] longValue]) {
            i++;
        }
        array[j] = array[i];
    }
    array[i] = @(key);
    /** 递归 **/
    [self fetchQuickSortWithArray:array left:leftNumber right:(array.count - 1)];
    [self fetchQuickSortWithArray:array left:(i + 1) right:rightNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  RecommendCycle
//
//  Created by zx on 2017/4/10.
//  Copyright © 2017年 zx. All rights reserved.
//

#import "ViewController.h"
#import "JMRecommendCycleView.h"

@interface ViewController ()
@property (nonatomic, strong) JMRecommendCycleView *recommendCycleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUI];
}

- (void)setUI
{
    self.recommendCycleView = [[JMRecommendCycleView alloc] setRecommendCycleView];
    
    self.recommendCycleView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 150);
    
    [self.view addSubview:self.recommendCycleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

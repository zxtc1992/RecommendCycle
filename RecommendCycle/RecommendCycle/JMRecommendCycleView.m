//
//  RecommendCycleView.m
//  RecommendDemo
//
//  Created by zx on 2017/4/5.
//  Copyright © 2017年 zx. All rights reserved.
//

#import "JMRecommendCycleView.h"

#define KCycleCell @"KCycleCell"
#define KCellNum 6

@interface JMRecommendCycleView()<UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSTimer *timer;

@end


@implementation JMRecommendCycleView

- (JMRecommendCycleView *)setRecommendCycleView
{
    return (JMRecommendCycleView *)[[[NSBundle mainBundle] loadNibNamed:@"JMRecommendCycleView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:KCycleCell];
    
    self.pageControl.numberOfPages = KCellNum;
    
}

- (void)layoutSubviews
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    [layout setItemSize:self.collectionView.bounds.size];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:6 * 10 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    [self removeCycleTimer];
    [self addCycleTimer];
}



#pragma mark - 实现collectionview代理，数据源方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeCycleTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addCycleTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5;
    
    self.pageControl.currentPage = (int)(offsetX / scrollView.bounds.size.width) % KCellNum;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return KCellNum * 10000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:KCycleCell forIndexPath:indexPath];
    
    cell.backgroundColor = indexPath.row % 2 == 0 ?[UIColor redColor] : [UIColor greenColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 定时器的方法

- (void)addCycleTimer
{
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeCycleTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollToNext
{
    CGFloat currentOffsetX = self.collectionView.contentOffset.x;
    CGFloat offsetX = currentOffsetX + self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

@end

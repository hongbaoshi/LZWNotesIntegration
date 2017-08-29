//
//  PPAddressController.m
//  LZW_iOS_common_questions
//
//  Created by 饶思学 on 2017/8/16.
//  Copyright © 2017年 红宝时. All rights reserved.
//

#import "PPAddressController.h"
#import "PPAddressCell.h"
#import "PPAddressHeadView.h"
@interface PPAddressController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray  *dataArr;

@end

@implementation PPAddressController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    return  self.dataArr.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    PPAddressCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PPAddressCell class]) forIndexPath:indexPath];
//   
//    return cell;
//}
//
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(SCW, 50);
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(SCW, 1);
//}
//
//-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reusableview = nil;
//    if (kind ==UICollectionElementKindSectionHeader) {
//        PPAddressHeadView * header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([PPAddressHeadView class]) forIndexPath:indexPath];
//        if (indexPath.section==0) {
//      
//     
//        }else{
//
//        }
//        reusableview=header;
//        
//    }
//    if (kind == UICollectionElementKindSectionFooter){
//        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
//        reusableview=footerview;
//    }
//    return reusableview;
//    
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//   
//        return CGSizeZero;
//   
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    //设置每一行的最小行间距
//    return 5;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    //设置每一列的最小间距
//    return 0;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 10, 0, 10);
//}
//-(UICollectionView *)collectionview{
//    
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
//        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
//        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
//        _collectionView.delegate=self;
//        _collectionView.dataSource=self;
//        _collectionView.backgroundColor=[UIColor whiteColor];
//        [_collectionView registerClass:[PPAddressCell class] forCellWithReuseIdentifier:NSStringFromClass([PPAddressCell class])];
//        [_collectionView registerClass:[PPAddressHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([PPAddressHeadView class])];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
//        
//        
//    }
//    
//    return _collectionView;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

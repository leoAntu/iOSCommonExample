//
//  displayTableCell.m
//  AsyncDisplayTableViewDemo
//
//  Created by 叮咚钱包富银 on 2018/6/6.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "displayTableCell.h"
@interface displayTableCell ()

@end

@implementation displayTableCell {
    ASTextNode *_titleNode;                 //标题
    ASNetworkImageNode *_goodsImageNode;    //商品图片
    ASImageNode *_goodsTypeTagNode;         //商品类别标签
    ASButtonNode *_goodsTimeTagNode;        //标签
    ASTextNode *_limitNode;                 //限量
    ASTextNode *_specialPriceNode;          //特卖价格
    ASTextNode *_normalPriceNode;           //平时价
    ASButtonNode *_shareButtonNode;         //分享
    ASImageNode *_bottomToolBarNode;        //底部工具条
    ASTextNode *_onLineCountNode;           //上架数目
    ASTextNode *_earningNode;               //收益
    ASTextNode *_lineStatusNode;            //上下架状态
    UISwitch *_lineSwitchButton;            //上下架开关
    ASDisplayNode *_lineSwitchBGNode;       //上下架开关背景(协助UISwitch位置)
    ASNetworkImageNode *_nationalFlagNode;  //国旗
    ASTextNode *_nationalNameNode;          //国家名
    BOOL _isImageChange;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _isImageChange = false;
        [self setupNode];
    }
    return self;
}

- (void)setupNode {
//    _isHaiTao = ret;
    [self addTitleNode: @"2018夏装新款大码韩版女装宽松包臀显瘦圆领条纹短袖连衣裙中长款"];
//    [self addNationalNameNode:@"China"];
    [self addGoodsImageNode];
    [self addGoodsTypeTagNode];
    [self addGoodsTimeTagNode:@"10:00 未开枪"];
    [self addLimitNode:@"限量: 200"];
    [self addSpecialPriceNode:@"特卖价:¥175"];
    [self addNormalPriceNode:@"平时:¥243.00"];
    [self addShareButtonNode];
    [self addBottomToolBarNode];

    [self addOnLineCountNode:@"已被1980位店主上架"];
    [self addEarningNode:@"收益:47.5"];
    [self addLineStatusNode:@"上架"];
    [self addLineSwitchBackgroundNode];
}

- (void)addLineSwitchBackgroundNode {
    _lineSwitchBGNode = [ASDisplayNode new];
    _lineSwitchBGNode.style.preferredSize = CGSizeMake(41, 25);
    [self addSubnode:_lineSwitchBGNode];
}

- (void)addLineStatusNode:(NSString *)text {
    _lineStatusNode = [[ASTextNode alloc] init];
    _lineStatusNode.attributedText = [self nodeAttributesStringText:text TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    [self addSubnode:_lineStatusNode];
}

- (void)addEarningNode:(NSString *)text {
    _earningNode = [[ASTextNode alloc] init];
    _earningNode.attributedText = [self nodeAttributesStringText:text TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    [self addSubnode:_earningNode];
}

- (void)addOnLineCountNode:(NSString *)text {
    _onLineCountNode = [[ASTextNode alloc] init];
    _onLineCountNode.attributedText = [self nodeAttributesStringText:text TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    [self addSubnode:_onLineCountNode];
    
}

//工具条
- (void)addBottomToolBarNode{
    _bottomToolBarNode = [[ASImageNode alloc] init];
    _bottomToolBarNode.image = [UIImage imageNamed:@"home_cell_bottom_bg"];
    [self addSubnode:_bottomToolBarNode];
    _bottomToolBarNode.style.height = ASDimensionMake(38);
}

//分享
- (void)addShareButtonNode{
    ASButtonNode *buttonNode = [ASButtonNode new];
    [buttonNode setImage:[UIImage imageNamed:@"home_share_normal"] forState:UIControlStateNormal];
    [buttonNode setImage:[UIImage imageNamed:@"home_share_selected"] forState:UIControlStateHighlighted];
    [buttonNode setBackgroundImage:[UIImage imageNamed:@"home_share_button"] forState:UIControlStateNormal];
    buttonNode.imageAlignment = ASButtonNodeImageAlignmentBeginning;
    buttonNode.contentVerticalAlignment = ASVerticalAlignmentCenter;
    buttonNode.contentHorizontalAlignment = ASHorizontalAlignmentMiddle;
    [self addSubnode:buttonNode];
    buttonNode.style.preferredSize = CGSizeMake(43, 36);
    _shareButtonNode = buttonNode;
    [_shareButtonNode addTarget:self action:@selector(shareBtnAction) forControlEvents:ASControlNodeEventTouchUpInside];
    
}

- (void)shareBtnAction {
    NSLog(@"改变当前ImageSize");
    _isImageChange = !_isImageChange;
    //如果想在当前runloop中立即刷新，调用顺序应该是
    [self setNeedsLayout];
    [self layoutIfNeeded];
 
}

- (void)addNormalPriceNode:(NSString *)text {
    _normalPriceNode = [[ASTextNode alloc] init];
    _normalPriceNode.attributedText = [self nodeAttributesStringText:text TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    [self addSubnode:_normalPriceNode];
}

- (void)addSpecialPriceNode:(NSString *)text {
    _specialPriceNode = [[ASTextNode alloc] init];
    _specialPriceNode.attributedText = [self nodeAttributesStringText:text TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    [self addSubnode:_specialPriceNode];
}

- (void)addLimitNode:(NSString *)text {
    _limitNode = [[ASTextNode alloc] init];
    _limitNode.attributedText = [self nodeAttributesStringText:text TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    [self addSubnode:_limitNode];
}

- (void)addGoodsTimeTagNode:(NSString *)text {
    _goodsTimeTagNode = [[ASButtonNode alloc] init];
    [_goodsTimeTagNode setTitle:text withFont:[UIFont systemFontOfSize:12] withColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _goodsTimeTagNode.backgroundColor = [UIColor redColor];
    _goodsTimeTagNode.cornerRadius = 25/2;
    _goodsTimeTagNode.style.preferredSize = CGSizeMake(90, 25);
    [self addSubnode:_goodsTimeTagNode];
}

- (void)addGoodsTypeTagNode {
    _goodsTypeTagNode = [[ASImageNode alloc] init];
    _goodsTypeTagNode.contentMode = UIViewContentModeScaleAspectFill;
    _goodsTypeTagNode.image = [UIImage imageNamed:@"home_cell_empty_icon.png"];
    _goodsTypeTagNode.style.layoutPosition = CGPointMake(0, 0);  //绝对对位中相对父视图的坐标点
    _goodsTypeTagNode.style.preferredSize = CGSizeMake(30, 30);
    
    [self addSubnode:_goodsTypeTagNode];
}

- (void)addGoodsImageNode {
    //网络图片
    _goodsImageNode = [[ASNetworkImageNode alloc] init];
    _goodsImageNode.clipsToBounds = YES;
    _goodsImageNode.contentMode = UIViewContentModeScaleAspectFill;
    _goodsImageNode.style.preferredSize = CGSizeMake(100, 100);
    _goodsImageNode.defaultImage = [UIImage imageNamed:@"luisX.png"];
    [self addSubnode:_goodsImageNode];
    _goodsImageNode.URL = [NSURL URLWithString:@"https://img.alicdn.com/imgextra/i1/1652582583/TB1nWt3hScqBKNjSZFgXXX_kXXa_!!0-item_pic.jpg_430x430q90.jpg"];

}

- (void)addTitleNode:(NSString *)text {
    _titleNode = [[ASTextNode alloc] init];
    _titleNode.attributedText = [self nodeAttributesStringText:text TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:16]];
    _titleNode.maximumNumberOfLines = 0;
    [self addSubnode:_titleNode];
}


- (void)addLineSwitchButton{
    _lineSwitchButton = [[UISwitch alloc] init];
    _lineSwitchButton.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [self.view addSubview:_lineSwitchButton];
}

- (void)changeImageSize {
    _isImageChange = !_isImageChange;
    //layoutIfNeeded 不会执行 layoutSpecThatFits方法
    //如果想在当前runloop中立即刷新，调用顺序应该是
    [self setNeedsLayout];
    [self layoutIfNeeded];

}

#pragma mark --- 重载富父类方法，

//布局方法必须重载，
#warning ---- 两个方法要区分，使用屏蔽的方法会崩溃
//- (ASLayout *)layoutThatFits:(ASSizeRange)constrainedSize
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    _goodsImageNode.style.preferredSize = _isImageChange == YES ? CGSizeMake(150, 150) : CGSizeMake(100, 100);

    //图片和类型标签的布局，绝对布局
    ASAbsoluteLayoutSpec *goodsImageSpec = [ASAbsoluteLayoutSpec absoluteLayoutSpecWithSizing:ASAbsoluteLayoutSpecSizingDefault
                                                                                     children:@[_goodsImageNode,_goodsTypeTagNode]];

    //第一行标题布局，水平布局
    ASStackLayoutSpec *titleSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                           spacing:5
                                                                    justifyContent:ASStackLayoutJustifyContentStart
                                                                        alignItems:ASStackLayoutAlignItemsCenter
                                                                          children:@[_goodsTimeTagNode,_limitNode]];
    //价格布局，水平布局
    ASStackLayoutSpec *priceSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                           spacing:10
                                                                    justifyContent:ASStackLayoutJustifyContentStart
                                                                        alignItems:ASStackLayoutAlignItemsCenter
                                                                          children:@[_specialPriceNode,_normalPriceNode]];

    //中间整体部分垂直布局
    ASStackLayoutSpec *middleSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                           spacing:5
                                                                    justifyContent:ASStackLayoutJustifyContentStart
                                                                        alignItems:ASStackLayoutAlignItemsStretch
                                                                          children:@[titleSpec,_titleNode,priceSpec]];
    //如果所有项目的flex-shrink属性都为1，当空间不足时，都将等比例缩小。如果一个项目的flex-shrink属性为0，其他项目都为1，则空间不足时，前者不缩小。
    middleSpec.style.flexShrink = 1;

    //上部分整体布局
    ASStackLayoutSpec *topSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                         spacing:10
                                                                  justifyContent:ASStackLayoutJustifyContentStart
                                                                      alignItems:ASStackLayoutAlignItemsCenter
                                                                        children:@[goodsImageSpec,middleSpec,_shareButtonNode]];

    //下部分右边布局
    ASStackLayoutSpec *bottomRightSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                         spacing:5
                                                                  justifyContent:ASStackLayoutJustifyContentStart
                                                                      alignItems:ASStackLayoutAlignItemsCenter
                                                                        children:@[_earningNode,_lineStatusNode,_lineSwitchBGNode]];

    //下部分整体布局
    ASStackLayoutSpec *bottomSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                 spacing:0
                                                                          justifyContent:ASStackLayoutJustifyContentSpaceBetween
                                                                              alignItems:ASStackLayoutAlignItemsCenter
                                                                                children:@[_onLineCountNode,bottomRightSpec]];


    ASInsetLayoutSpec *bottomContentInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 10, 0, 10) child:bottomSpec];
    ASBackgroundLayoutSpec *backSpec = [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:_bottomToolBarNode background:bottomContentInset];


    //上部分整体布局

    ASStackLayoutSpec *allSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                         spacing:5
                                                                  justifyContent:ASStackLayoutJustifyContentStart
                                                                      alignItems:ASStackLayoutAlignItemsStretch
                                                                        children:@[topSpec,backSpec]];

    
    //整体边框---(边框约束)
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                  child:allSpec];

}



- (void)didLoad {
    [super didLoad];
    [self addLineSwitchButton];
}

-(void)layout {
    [super layout];
    _lineSwitchButton.frame = _lineSwitchBGNode.frame;
}


- (NSAttributedString *)nodeAttributesStringText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName : font,NSForegroundColorAttributeName: textColor};
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    return attr;
}


@end

//
//  NewsCell.m
//  AsyncDisplayTableViewDemo
//
//  Created by 叮咚钱包富银 on 2018/6/8.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "NewsCell.h"
@interface NewsCell ()
@property (nonatomic, strong)  ASTextNode *titleNode;
@property (nonatomic, strong)  ASTextNode *contentNode;
@property (nonatomic, strong)  ASImageNode *contentImageNode;
@property (nonatomic, strong)  ASTextNode *usernameLabel;
@property (nonatomic, strong)  ASTextNode *timeNode;

@end

@implementation NewsCell
- (instancetype)init{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupNode];
    }
    return self;
}

- (void)setupNode {
    
    self.titleNode = [[ASTextNode alloc] init];
    [self addSubnode:self.titleNode];
    
    self.contentNode = [[ASTextNode alloc] init];
//    self.contentNode.maximumNumberOfLines = 2;
    [self addSubnode:self.contentNode];
    
    self.contentImageNode = [ASImageNode new];
    self.contentImageNode.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubnode:self.contentImageNode];
    
    
    self.usernameLabel = [[ASTextNode alloc] init];
    [self addSubnode:self.usernameLabel];
    
    self.timeNode = [[ASTextNode alloc] init];
    [self addSubnode:self.timeNode];

    self.usernameLabel.attributedText = [self nodeAttributesStringText:@"wqerqw" TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:15]];
    self.timeNode.attributedText = [self nodeAttributesStringText:@"fgggg" TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:15]];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    //名字和时间的布局
    ASStackLayoutSpec *bottomSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                            spacing:0
                                                                     justifyContent:ASStackLayoutJustifyContentSpaceBetween
                                                                         alignItems:ASStackLayoutAlignItemsCenter
                                                                           children:@[_usernameLabel,_timeNode]];
    
    //alignItems 设为ASStackLayoutAlignItemsStart导致_usernameLabel和_timeNode不能布局在两端
    ASStackLayoutSpec *allSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                         spacing:10
                                                                  justifyContent:ASStackLayoutJustifyContentStart
                                                                      alignItems:ASStackLayoutAlignItemsStretch
                                                                        children:@[_titleNode,_contentNode,_contentImageNode,bottomSpec]];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                  child:allSpec];
}

- (void)layout {
    [super layout];
}

- (void)didLoad {
    [super didLoad];
}

- (void)displayWithModel:(ListModel *)model {
    self.titleNode.attributedText = [self nodeAttributesStringText:model.title TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:15]];
    self.contentNode.attributedText = [self nodeAttributesStringText:model.content TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:15]];
//    self.usernameLabel.attributedText = [self nodeAttributesStringText:model.username TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:15]];
//    self.timeNode.attributedText = [self nodeAttributesStringText:model.time TextColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:15]];
    self.contentImageNode.image = [UIImage imageNamed:model.imageName];
    [self setNeedsLayout];
    [self layoutIfNeeded];

}

- (NSAttributedString *)nodeAttributesStringText:(NSString *)text TextColor:(UIColor *)textColor Font:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName : font,NSForegroundColorAttributeName: textColor};
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    return attr;
}

@end

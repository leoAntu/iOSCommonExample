//
//  ListCell.m
//  YogaKitDemo
//
//  Created by 叮咚钱包富银 on 2018/6/4.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ListCell.h"
#import <YogaKit/UIView+Yoga.h>

@interface ContentView : UIView

@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;
@property (nonatomic, strong)  UIView  *bottomDiv;
@end

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [UILabel new];
        
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        
        _contentImageView = [UIImageView new];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        _usernameLabel = [UILabel new];
        
        _timeLabel = [UILabel new];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_titleLabel];
        [self addSubview:_contentLabel];
        [self addSubview:_contentImageView];
        
        self.bottomDiv = [[UIView alloc] init];
        
        [self.bottomDiv addSubview:_usernameLabel];
        [self.bottomDiv addSubview:_timeLabel];
        
        [self addSubview:self.bottomDiv];
    }
    
    return self;
}

- (void)configData:(ListModel *)entity{
    
    _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:entity.title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    _contentLabel.attributedText = [[NSAttributedString alloc] initWithString:entity.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
    if (entity.imageName.length>0) {
        _contentImageView.yoga.display = YGDisplayFlex;
        _contentImageView.image = [UIImage imageNamed:entity.imageName];
        
    }else{
        _contentImageView.image = nil;
        _contentImageView.yoga.display = YGDisplayNone;
    }
    
    _usernameLabel.attributedText = [[NSAttributedString alloc] initWithString:entity.username attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    _timeLabel.attributedText = [[NSAttributedString alloc] initWithString:entity.time attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
}

- (void)layoutView {
    YGLayoutConfigurationBlock marginWrapConfigureBlock  = ^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.marginTop = YGPointValue(10);
        layout.marginLeft= layout.marginRight = layout.marginBottom  = YGPointValue(0);
        layout.flexWrap  = YGWrapWrap;
    } ;

    [_titleLabel configureLayoutWithBlock:marginWrapConfigureBlock];
    _titleLabel.yoga.marginLeft = YGPointValue(10);
    
    [_contentLabel configureLayoutWithBlock:marginWrapConfigureBlock];
    _contentLabel.yoga.marginLeft  = YGPointValue(10);
    
    [_contentImageView configureLayoutWithBlock:marginWrapConfigureBlock];

    YGLayoutConfigurationBlock growWrapConfigureBlock  = ^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.flexGrow  = 1.0;
        layout.flexWrap  = YGWrapWrap;
    } ;
    
    [_usernameLabel configureLayoutWithBlock:growWrapConfigureBlock];
    _usernameLabel.yoga.marginLeft = YGPointValue(10);
    
    [_timeLabel configureLayoutWithBlock:growWrapConfigureBlock];
    _timeLabel.yoga.marginRight = YGPointValue(10);

    [self.bottomDiv configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled      = YES;
        layout.flexDirection  = YGFlexDirectionRow;
        layout.justifyContent = YGJustifySpaceBetween;
        layout.alignItems     = YGAlignCenter;
        layout.marginTop      = YGPointValue(10);
        layout.marginBottom   = YGPointValue(10);
    }];
    
    [self configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled     = YES;
        layout.width      = YGPointValue([UIScreen mainScreen].bounds.size.width);//必须要指定宽度
        layout.flexGrow   = 1.0; //最好加上,防止计算高度失败
    }];
    
    [self.yoga applyLayoutPreservingOrigin:YES];
}

@end


@interface ListCell()

@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel *usernameLabel;
@property (nonatomic, strong)  UILabel *timeLabel;
@property (nonatomic, strong)  UIView  *bottomDiv;
@property (nonatomic, strong) ContentView *feedView;

@end

@implementation ListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled     = YES;
            layout.flexDirection = YGFlexDirectionColumn;
            layout.flexWrap      = YGWrapWrap;
        }];
        
        [self.contentView addSubview:self.feedView];
        
        [self.contentView.yoga applyLayoutPreservingOrigin:YES];
    }
    
    return  self;
}

- (void)configureData:(ListModel *)model {
    [self.feedView configData:model];
    [self.feedView layoutView];
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}

- (ContentView *)feedView{
    if (!_feedView) {
        _feedView = [[ContentView alloc] init];
    }
    return _feedView;
}

@end

@implementation  UITableView (TemplateCell)

- (CGFloat)heightForData:(ListModel *)model cellIdentifier:(NSString *)identifier {
    
    ListCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    
    [cell prepareForReuse];
    
    
    [cell configureData:model];
    
    return cell.contentView.yoga.intrinsicSize.height;
}
@end


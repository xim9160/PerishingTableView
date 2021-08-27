//
//  TTCTableViewCell.m
//  TerrableTCellMode
//
//  Created by 肖冯敏 on 2021/8/27.
//

#import "TTCTableViewCell.h"
#import "Masonry.h"

@interface TTCTableViewCell()

@property (nonatomic, strong) UIView *panel;

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *titlePanel;

@property (nonatomic, strong) UIImageView *contentImagView;
@property (nonatomic, strong) UILabel *topicLabel;
@property (nonatomic, strong) UILabel *extLabel;

@property (nonatomic, strong) NSDictionary *dict;
//@property (nonatomic, strong) MASViewAttribute *offsetConstraint;
//@property (nonatomic, weak) UIView *constraintBaseView

@end

@implementation TTCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        [self masSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    _panel = ^{
        UIView *v = [UIView new];
        return v;
    }();
    
    _avatar = ^{
        UIImageView *imgV = [[UIImageView alloc] init];
        return imgV;
    }();
    
    _titleLabel = ^{
        UILabel *l = [[UILabel alloc] init];
        return l;
    }();
    
    _contentLabel = ^{
        UILabel *l = [[UILabel alloc] init];
        l.numberOfLines = 0;
        return l;
    }();
    
    _dateLabel = ^{
        UILabel *l = [[UILabel alloc] init];
        return l;
    }();
    
    _titlePanel = ^{
        UILabel *l = [[UILabel alloc] init];
        return l;
    }();
    
    _rightBtn = ^{
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor orangeColor];
        btn.layer.cornerRadius = 12;
        return btn;
    }();
    
    _contentImagView = ^{
        UIImageView *imgV = [[UIImageView alloc] init];
        return imgV;
    }();
    
    _topicLabel = ^{
        UILabel *l = [[UILabel alloc] init];
        l.backgroundColor = [UIColor orangeColor];
        l.layer.cornerRadius = 5;
        return l;
    }();
    
    _extLabel = ^{
        UILabel *l = [[UILabel alloc] init];
        l.backgroundColor = [UIColor greenColor];
        return l;
    }();
    
    [self.contentView addSubview:_panel];
    [self.panel addSubview:_avatar];
    [self.panel addSubview:_titlePanel];
    [self.titlePanel addSubview:_titleLabel];
    [self.titlePanel addSubview:_dateLabel];
    [self.panel addSubview:_contentLabel];
    [self.panel addSubview:_rightBtn];
    [self.panel addSubview:_contentImagView];
    [self.panel addSubview:_topicLabel];
    [self.panel addSubview:_extLabel];
}

- (void)masSubviews {
    
    [self.panel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.panel).offset(16);
        make.height.width.equalTo(@32);
    }];
    
    _titlePanel.backgroundColor = [UIColor redColor];

    [_titlePanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_avatar);
        make.left.equalTo(_titleLabel);
        make.right.greaterThanOrEqualTo(_titleLabel);
        make.right.greaterThanOrEqualTo(_dateLabel);
        make.right.lessThanOrEqualTo(_rightBtn.mas_left).offset(-16);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(16);
        make.top.equalTo(_titlePanel);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.bottom.equalTo(_titlePanel);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_panel.mas_right).offset(-16);
        make.centerY.equalTo(_avatar);
        make.width.equalTo(@100);
//        make.left.lessThanOrEqualTo(_titlePanel);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.avatar.mas_bottom).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.bottom.lessThanOrEqualTo(self.panel).offset(-16);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


/// 模型入口 并对数据进行赋值
/// @param dic 元数据
- (void)updateDataWithDic:(NSDictionary *)dic {
    ///原始数据备份, 便于排查问题
    _dict = dic;

    NSString *imgName = dic[@"avatar"]?:@"";
    NSString *title = dic[@"title"]?:@"";
    NSString *rightBtnTitle = dic[@"rightBtn"]?:@"";
    NSString *content = dic[@"content"]?:@"";
    NSString *date = dic[@"date"]?:@"";
    NSString *contentImg = dic[@"contentImg"]?:@"";
    NSString *topic = dic[@"topic"]?:@"";
    NSString *ext = dic[@"ext"]?:@"";
    
    [_avatar setImage:[UIImage imageNamed:imgName]];
    _titleLabel.text = title;
    _contentLabel.text = content;
    _dateLabel.text = date;
    [_contentImagView setImage:[UIImage imageNamed:contentImg]];
    _topicLabel.text = topic;
    _extLabel.text = ext;
    [_rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];

    [self updateMasWithDic:dic];
    
}


/// 控制布局变化
/// @param dic 元数据
- (void)updateMasWithDic:(NSDictionary *)dic {
    
//    NSString *imgName = dic[@"avatar"]?:@"";
//    NSString *title = dic[@"title"]?:@"";
    NSString *rightBtnTitle = dic[@"rightBtn"]?:@"";
//    NSString *content = dic[@"content"]?:@"";
    NSString *date = dic[@"date"]?:@"";
    NSString *contentImg = dic[@"contentImg"]?:@"";
    NSString *topic = dic[@"topic"]?:@"";
    NSString *ext = dic[@"ext"]?:@"";
    
    if ([date length] > 0) {
        [_dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(8);
        }];
    } else {
        [_dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        }];
    }
    
    if ([rightBtnTitle length] > 0) {
        [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
        }];
    } else {
        [_rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
    }
    
    UIView *constraintView = self.contentLabel;///基准视图
    
    if ([contentImg length] > 0) {
        [_contentImagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom).offset(16);
            make.left.equalTo(@16);
            make.width.height.equalTo(@200);
            make.bottom.lessThanOrEqualTo(self.panel).offset(-16);
        }];
        constraintView = _contentImagView;
    } else {
        [_contentImagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@0);
        }];
    }
    
    if ([topic length] > 0) {
        
        [_topicLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom).offset(16);
            make.left.equalTo(@16);
            make.right.equalTo(@-16);
            make.bottom.lessThanOrEqualTo(self.panel).offset(-16);
        }];
        constraintView = _topicLabel;
    } else {
        [_topicLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    if ([ext length] > 0) {
        [_extLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(constraintView.mas_bottom).offset(16);
            make.left.equalTo(@16);
            make.right.equalTo(@-16);
            make.height.equalTo(@32);
            make.bottom.lessThanOrEqualTo(self.panel).offset(-16);
        }];
        constraintView = _extLabel;
    } else {
        [_extLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
}

@end

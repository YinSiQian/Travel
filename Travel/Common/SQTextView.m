//
//  SQTextView.m
//  Travel
//
//  Created by ABJ on 2019/5/8.
//  Copyright © 2019 ysq. All rights reserved.
//

#import "SQTextView.h"

@interface SQTextView ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, strong) UILabel *desLabel;

@end


@implementation SQTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        [self setupSubviews];
    }
    return self;
}

- (void)commonInit {
    self.maxNum = 50;
}

- (void)setupSubviews {
    
    self.textView = [[UITextView alloc]initWithFrame:self.bounds];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate = self;
    [self addSubview:self.textView];
    
    self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, self.textView.width - 6, 20)];
    self.placeholderLabel.textColor = kLightDarkColor;
    self.placeholderLabel.font = [UIFont systemFontOfSize:16];
    [self.textView addSubview:self.placeholderLabel];
    
    self.desLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textView.width - 10 - 200, self.textView.height - 23, 200, 20)];
    self.desLabel.textColor = kLightDarkColor;
    self.desLabel.font = [UIFont systemFontOfSize:12];
    self.desLabel.text = [NSString stringWithFormat:@"0/%ld", self.maxNum];
    self.desLabel.textAlignment = NSTextAlignmentRight;
    [self.textView addSubview:self.desLabel];

    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.desLabel.text = [NSString stringWithFormat:@"0/%ld", self.maxNum];
    self.placeholderLabel.text = self.placeholder;
    
    self.textView.frame = self.bounds;
    self.desLabel.frame = CGRectMake(self.textView.width - 10 - 200, self.textView.height - 23, 200, 20);
    self.placeholderLabel.frame = CGRectMake(5, 8, self.textView.width - 6, 20);
}

#pragma mark -- UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.location + text.length > self.maxNum) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholderLabel.hidden = textView.text.length > 0;
    self.desLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.textView.text.length, self.maxNum];
}


- (NSString *)content {
    return self.textView.text;
}

@end

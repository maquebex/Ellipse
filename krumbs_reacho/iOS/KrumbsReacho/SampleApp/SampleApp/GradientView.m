#import "GradientView.h"

@implementation GradientView
@synthesize topColor, bottomColor, userInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.bottomColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.userInfo = [[NSMutableDictionary alloc] init];
        
        [self addObserver:self forKeyPath:@"topColor" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"bottomColor" options:NSKeyValueObservingOptionNew context:nil];
        
        self.opaque = NO;
    }
    return self;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"topColor"];
    [self removeObserver:self forKeyPath:@"bottomColor"];
    self.topColor = nil;
    self.bottomColor = nil;
    self.userInfo = nil;
}

@end

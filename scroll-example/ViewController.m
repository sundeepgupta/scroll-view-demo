#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *puppyView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
    // Uncomment only one of these examples!
//    [self basicScrollingExample];
//    [self zoomExample];
    [self pagingExample];
}

- (void)setupScrollView {
    // Instantiate a UIScrollView with a frame that gives a 10 point border
    // Add it as a subview to the view controller's view
    
    CGRect frame = CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 20);
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.scrollView];
}

- (void)basicScrollingExample {
    // Add a random view so we can see it scroll
    UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    view0.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:view0];
    
    // Important! Set the content size of the scroll view
    // Must be bigger than the scroll view itself to be scrollable
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*2, self.scrollView.frame.size.height*2);
}

- (void)zoomExample {
    // Create a UIImageView with an image and add it to our scroll view
    // If we don't set a frame, UIImageView will use x=0, y=0 and the height and width of the image
    UIImage *image = [UIImage imageNamed:@"puppy.jpg"];
    self.puppyView = [[UIImageView alloc] initWithImage:image];
    [self.scrollView addSubview:self.puppyView];
    
    // Configure the scroll view to allow for zooming
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 10;
}

// This UIScrollViewDelegate method is required for zooming. Return the view to be zoomed.
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.puppyView;
}


- (void)pagingExample {
    // The container view will hold the various color views.
    UIView *containerView = [[UIView alloc] initWithFrame:self.scrollView.bounds];
    [self.scrollView addSubview:containerView];
    
    // Create an array of UIColors
    NSArray *colors = @[
                        [UIColor redColor],
                        [UIColor orangeColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor purpleColor]
                        ];
    
    
    // Loop over our colors to generate a UIView for each color and add them to our container view
    CGFloat x = 0;

    // Leaving this here to illustrate two different ways of looping. The uncommented one ("fast enumeration") is preferred.
//    for (NSInteger i; i < colors.count; i++) {
//        CGRect frame = CGRectMake(x, self.scrollView.bounds.origin.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//        UIView *colorView = [[UIView alloc] initWithFrame:frame];
//        colorView.backgroundColor = colors[i];
//        
//        [containerView addSubview:colorView];
//        
//        x = x + self.scrollView.frame.size.width;
//    }
    
    for (UIColor *color in colors) {
        CGRect frame = CGRectMake(x, self.scrollView.bounds.origin.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        UIView *colorView = [[UIView alloc] initWithFrame:frame];
        colorView.backgroundColor = color;
        
        [containerView addSubview:colorView];
        
        // Keep moving x to the right after each color view is added
        x = x + self.scrollView.frame.size.width;
    }
    
    // Set the content size to be as wide as all of our color views
    self.scrollView.contentSize = CGSizeMake(x, self.scrollView.frame.size.height);
    
    // Configure the scroll view scroll in page mode
    self.scrollView.pagingEnabled = YES;
}


@end



#import "MyViewController.h"

static NSArray *__pageControlColorList = nil;

@implementation MyViewController

@synthesize pageNumberLabel;

// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    if (__pageControlColorList == nil) {
        __pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor magentaColor],
                                  [UIColor blueColor], [UIColor orangeColor], [UIColor brownColor], [UIColor grayColor], nil];
    }
	
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlColorList objectAtIndex:index % [__pageControlColorList count]];
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page pop:(BOOL)pop {
    if (self = [super initWithNibName:@"MyView" bundle:nil]) {
        pageNumber = page;
		pop_ = pop;
        self.view.backgroundColor = [MyViewController pageControlColorWithIndex:page];
    }
    
    return self;
}

- (void)dealloc {
    [pageNumberLabel release];
    [super dealloc];
}

// Set the label and background color when the view has finished loading.
- (void)viewDidLoad {
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	NSLog(@"did rotate MyVC");
}

- (IBAction)pop:(id)sender {
	if (pop_) {
		[self.navigationController popViewControllerAnimated:YES];
	} else {
		[self dismissModalViewControllerAnimated:YES];
		MBApplicationDelegate.scrollEnabled = YES;
	}

}

@end

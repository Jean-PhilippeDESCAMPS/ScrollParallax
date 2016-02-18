//
//  ViewController.m
//  ScrollParallax
//
//  Created by Jean-Philippe DESCAMPS on 28/01/2016.
//  Copyright © 2016 Jean-Philippe. All rights reserved.
//

#import "ScrollParallaxViewController.h"
#import <MapKit/MapKit.h>
#import "CritizrAnnotation.h"

@interface ScrollParallaxViewController () <UIScrollViewDelegate>
{
    CGFloat lastYValue;
}

@property (strong, nonatomic) IBOutlet UIScrollView *parallaxScrollView;
/*@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;*/
@property (strong, nonatomic) UIViewController *controller;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ScrollParallaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CLLocationCoordinate2D akihabara = CLLocationCoordinate2DMake(35.7022077,139.774459);
    CritizrAnnotation *annotation = [[CritizrAnnotation alloc] init];
    [annotation setCoordinate:akihabara];
    [self.mapView addAnnotation:annotation];
    MKMapCamera *mapCamera = [MKMapCamera camera];
    [mapCamera setCenterCoordinate:akihabara];
    [mapCamera setAltitude:1500];
    [self.mapView setCamera:mapCamera animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Controller"];
    CGRect frame = CGRectMake(0, 200, self.parallaxScrollView.frame.size.width, 1000);
    self.controller.view.frame = frame;
    [self.parallaxScrollView addSubview:self.controller.view];
    [self.parallaxScrollView setContentSize:frame.size];
    
    CGPoint centerMap = [self.mapView convertCoordinate:self.mapView.centerCoordinate toPointToView:self.view];
    centerMap.y = 110;
    [self.mapView setCenter:centerMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        //if(lastYValue >= scrollView.contentOffset.y) {
            //self.heightConstraint.constant = 200 + fabs(scrollView.contentOffset.y);
            //[self.backgroundView setNeedsUpdateConstraints];
        CGPoint centerMap = [self.mapView convertCoordinate:self.mapView.centerCoordinate toPointToView:self.view];
        centerMap.y = 110 + fabs(scrollView.contentOffset.y);
        //[self.mapView setCenter:centerMap];
        //}
        
        lastYValue = scrollView.contentOffset.y;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.contentOffset.y <= 0) {
        //self.heightConstraint.constant = 200;
        //[self.backgroundView setNeedsUpdateConstraints];
        
        /*[UIView animateWithDuration:fabs(velocity.y) delay:scrollView.decelerationRate options:kNilOptions animations:^{
            [self.backgroundView layoutIfNeeded];
        } completion:nil];*/
    }
}



@end

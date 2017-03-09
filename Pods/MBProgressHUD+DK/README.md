#DKProgressHUD

A simple second-dev of MBProgressHUD for Dankal_iOS.

****

####效果图

![img](https://github.com/bingozb/DKProgressHUD/blob/master/DKProgressHUDDemo.gif)

##背景

- `SVProgressHUD`是单例模式，且HUD是show到keyWindow上的，这会导致不同控制器里使用HUD会相互冲突并引发许多问题，例如

    - 问题1: 在A控制器show，当它还没结束的时候我pushB控制器，HUD仍然在屏幕上。

    - 问题2: 在B控制器show，我pop到A控制器的时候，HUD仍然在屏幕上。

- 为了解决以上问题，必须在控制器的生命周期里做手脚，但因为有导航控制器，不能在控制器的`dealloc`方法里做手脚，只能在例如`viewWillAppear`或者`viewWillDisAppear`甚至是`viewDidAppear`等的时候调用`dismiss`。

- 可以写一个`UIViewController`的分类在`load`的时候用`runtime`来拦截一下系统的方法换成自己写的方法，给`viewWillAppear`等方法调用的时候调用一下`dismiss`，还是会有问题。例如

    - 问题1: 在`viewWillAppear`的时候加`dismiss`，A控制器show，然后push到B，B也要show，这时候HUD会闪现，原因是B即将要显示了。
    
    - 问题2: 在`viewWillDisAppear`的时候加`dismiss`，不管是push还是pop，同样也会有闪现问题。

    - 问题3: 在`viewDidAppear`的时候加`dismiss`，从A控制器push到B，B控制器show，1秒不到就消失了，原因是B控制器显示完毕了。

    - 问题4: 在`viewDidDisAppear`的时候加`dismiss`，从A控制器Push到B，B控制器show，同样也是1秒不到就消失了，原因是A控制器消失完毕了。

- 也就是说，想要一劳永逸的用分类和`runtime`去解决这个问题，目前来说我觉得是不可能的。最笨的方法是手动在每个控制器的生命周期里，根据实际需求去管理，反正我是不会这么干的。有没有使用SV并且遇到同样问题的朋友有其他的解决方法欢迎Issues。

- 于是，我转用`MBProgressHUD`。与`SVProgressHUD`最明显的区别就是它不是单例，而且是可以add到view上的。但MB用起来没有SV的showSuccess、showError等那么直接方便。最终我模仿SV的样式、封装出了这个框架。

##安装

- 通过cocoapods安装

```objc

pod 'MBProgressHUD+DK'

```

> 看仔细! 不是 'DKProgressHUD' !!!

- 或者直接clone，将`DKProgressHUD`文件夹整个拖到你的项目中

##使用

**引用头文件**

```objc

#import "DKProgressHUD.h" 

```

**在控制器中调用类方法**

```objc

// 加载中
[DKProgressHUD showLoadingToView:self.view];
[DKProgressHUD showLoadingWithStatus:@"Loading" toView:self.view]; // 带有文字

// 成功
[DKProgressHUD showSuccessToView:self.view];
[DKProgressHUD showSuccessWithStatus:@"Success" toView:self.view];

// 失败
[DKProgressHUD showErrorToView:self.view];
[DKProgressHUD showErrorWithStatus:@"Error" toView:self.view];

// 提示/警告
[DKProgressHUD showInfoToView:self.view];
[DKProgressHUD showInfoWithStatus:@"Warning" toView:self.view];

// 进度条
[DKProgressHUD showProgressToView:self.view];
[DKProgressHUD showProgressWithStatus:@"Progress" toView:self.view];

```

**如果在某些场合下拿不到view，提供了show到keyWindow上的方法**

> 不建议show到keyWindow上，否则跟SV一样还是会存在问题，提供此接口只是方便有时候不得已而为之。

```objc

// 加载中
[DKProgressHUD showLoading];
[DKProgressHUD showLoadingWithStatus:@"Loading"];

// 成功
[DKProgressHUD showSuccess];
[DKProgressHUD showSuccessWithStatus:@"Success"];

// 失败
[DKProgressHUD showError];
[DKProgressHUD showErrorWithStatus:@"Error"];

// 提示/警告
[DKProgressHUD showInfo];
[DKProgressHUD showInfoWithStatus:@"Info"];

// 进度条
[DKProgressHUD showProgress];
[DKProgressHUD showProgressWithStatus:@"Progress"];

```

**进度条的使用**

```objc

@property (nonatomic, weak) DKProgressHUD *hud;

self.hud = [DKProgressHUD showProgressWithStatus:@"uploading.." toView:self.view];

// 更新进度
[self.hud setProgress:progress]; // progress: CGFloat 0.0~1.0

```

##自定义

建议在项目中进行子类化，继承自`DKProgressHUD`即可，根据需求选择重写以下方法。

```
/**
 * HUD样式
 *  DKProgressHUDStyleBlack : 黑色
 *  DKProgressHUDStyleLight : 白色
 * 默认返回DKProgressHUDStyleBlack
 */
+ (DKProgressHUDStyle)progressHUDStyle;

/**
 * 进度条样式
 *  DKProgressHUDModeDeterminateHorizontalBar : 水平进度条
 *  DKProgressHUDModeAnnularDeterminate       : 圆环进度条
 * 默认返回DKProgressHUDModeAnnularDeterminate
 */
+ (DKProgressHUDMode)progressHUDMode;

/**
 * HUD隐藏的时间间隔(秒)
 * Success || Error || Info
 * 默认1.5秒后隐藏
 */
+ (CGFloat)progressHUDIntervalDismiss;

/**
 * HUD超时的时间间隔(秒)
 * Loading || Progress
 * 经过返回的时间后,HUD会被隐藏
 * 默认返回MAXFLOAT,不自动隐藏
 */
+ (CGFloat)progressHUDIntervalOvertime;

/**
 * 是否启用遮罩蒙版 默认为NO
 * 如果返回YES,当HUD显示的时候会有透明的遮罩层阻挡用户点击,并且用户点击蒙版时会发出通知:DKProgressHUDDidClickedNotification
 */
+ (BOOL)useCoverMask;

```


>stackoverflow上关于Objective-C关注度比较高的问题系列
>[链接](https://stackoverflow.com/questions/tagged/objective-c?sort=frequent&pageSize=15)

# 页面之间传递数据

原文链接[《Passing Data between View Controllers》](https://stackoverflow.com/questions/5210535/passing-data-between-view-controllers)

关键词
> Passing Data between View Controllers

## 1.向下一个页面传递数据
**Passing Data Forward**

从页面A通过navitagion push进入页面B，此时需要传递数据（这个数据可以是object或者value）给页面B，可以用下面这个方法。

有两个ViewController：`ViewControllerA` 和 `ViewControllerB`，需用从`ViewControllerA`传递一个`字符串`给`ViewControllerB`.

1) 在`ViewControllerB`中添加一个`NSString`类型的`property` title

```
@property (nonatomic, copy) NSString *title;

```

2) 在`ViewControllerA` 中你需要导入`ViewControllerB` 

```
#import "ViewControllerB.h"
```
然后在你需要push`ViewControllerB`之前给`ViewControllerB`的`propety`title赋值

```
ViewControllerB *viewControllerB = [[ViewControllerB alloc] init];
viewControllerB.title = @"The second View";
[self.navigationController pushViewController:viewControllerB animated:YES];

```

## 2.通过Segues进入下个页面的传递数据
**Passing Data Forward using Segues**

如果你使用了Storyboards，那么很大可能会用到segue来push页面。这里的数据传递和上面中的数据传递类似，在push页面之前下面这个方法会被调用

```
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

```
所以从`ViewControllerA`传递一个`字符串`给`ViewControllerB`的步骤应如下：

1) 在`ViewControllerB`中添加一个`NSString`类型的`property` title

```
@property (nonatomic, copy) NSString *title;

```

2) 在`ViewControllerA` 中你需要导入`ViewControllerB` 

```
#import "ViewControllerB.h"
```
3) 在Storyboard中创建一个从`ViewControllerA`到`ViewControllerB`的segue，并且给这个segue一个`identifier`，例如`"showDetailSegue"`

4) 在`ViewControllerA`添加`-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender`方法，此方法会在任何使用segue进行转场时被调用(响应)。其中segue就是storyBoard转场控制对象，在参数segue中能够获取所要跳转的试图控制器，destinationViewController（目标vc），sourceViewController(源视图vc)。

```
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
		ViewControllerB *viewControllerB = (ViewControllerB *)segue.destinationViewController;        
		viewControllerB.title = @"The second View";
    }
}

```

如果你的`ViewControllerB`是嵌入在一个`NavigationController`中那么需要使用下面这个方法来获取`ViewControllerB`：

```

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        ViewControllerB * viewControllerB = (ViewControllerB *)navController.topViewController;
        viewControllerB.title = @"The second View";
    }
}

```

## 3.向上一个页面传递数据

**Passing Data Back**

从`ViewControllerB`向`ViewControllerA`回传数据，你可以使用Protocol和delegate 或者是 Block。**后者可以作为一种低耦合的回调机制**

### Protocol and Delegate 方式

我们将使`ViewControllerA`为`ViewControllerB`的一个delegate(代理)。这样可以允许`ViewControllerB`发送一个message回传给`ViewControllerB`，从而实现回传数据。

要想使`ViewControllerA`为`ViewControllerB`的一个delegate，`ViewControllerA`必须(conform)遵从`ViewControllerB`的protocol(协议)。此协议将告诉`ViewControllerA`哪些方法是必须要实现的。

1) `ViewControllerB`中，在`#import`和`@interface`之间你需要具体说明你的协议，代码如下：

```

@class ViewControllerB;

@protocol ViewControllerBDelegate <NSObject>

- (void)viewController:(ViewControllerB *)controller didFinishEnteringItem:(NSString *)content;

@end

```

2) 接下来还是在`ViewControllerB`中，你需要给ViewContollerB添加一个`delegate`属性，然后在`.m`中`synthesize`

```
@property (nonatomic, weak) id<ViewControllerBDelegate> delegate;

```

3) 在`ViewControllerB`中当我们需要传递数据给`ViewControllerA`时，调用`delegate`的方法。通常在点击button或者页面pop的时候。

```

- (IBAction)backButtonClicked:(id)sender {
    NSString *content = @"Pass this value back to ViewControllerA";
    if ([self.delegate respondsToSelector:@selector(viewController:didFinishEnteringItem:)]) {
        [self.delegate viewController:self didFinishEnteringItem:content];
    }
}

```

4) 以上`ViewControllerB`部分就完成了，接下来在`ViewControllerA`中，导入`ViewControllerB.h`并且遵从它的协议。

```
#import "ViewControllerB.h"

@interface ViewControllerA ()<ViewControllerBDelegate>

@end

```

5) 在`ViewControllerA`中实现`ViewControllerBDelegate`的方法。

```
#pragma mark - ViewControllerBDelegate

- (void)viewController:(ViewControllerB *)controller didFinishEnteringItem:(NSString *)content {
    NSLog(@"This was returned from ViewControllerB %@", content);
}

```

6) 在push进入`ViewControllerB`之前，你需要告诉`ViewControllerB`，它的`delegate`是`ViewControllerA`。

```
ViewControllerB *viewControllerB = [[ViewControllerB alloc] init];
viewControllerB.delegate = self
[self.navigationController pushViewController:viewControllerB animated:YES];

```

### Block 方式

我们将在`ViewControllerA`中给`ViewControllerB`的block赋值，当在`ViewControllerB`调用block时，`ViewControllerA`中block将响应，并执行block中的操作。

1) 在`ViewControllerB.h`中添加一个`block`属性

```
@property (nonatomic, copy) void (^block)(NSString *content);

```

2) 在`ViewControllerB.m`中，当我们需要传递数据给`ViewControllerA`时，调用`block`。通常在点击button或者页面pop的时候。

```
- (IBAction)backButtonClicked:(id)sender {
    NSString *content = @"Pass this value back to ViewControllerA";
    if (self.block) {
        self.block(content);
    }
}
```

3) 在push进入`ViewControllerB`之前，你需要给`ViewControllerB`的block赋值。特别注意，在此处block中，如果要使用self的话，需要使用weakSelf，这样能够防止循环引用。具体代码如下：

```
ViewControllerB *viewControllerB = [[ViewControllerB alloc] init];
__weak __typeof__ (self)weakSelf = self;
viewControllerB.block = ^(NSString *content) {
    NSLog(@"This was returned from ViewControllerB %@", content);
    weakSelf.tipLabel.text = content;
};
[self.navigationController pushViewController:viewControllerB animated:YES];
```

## 4.跨页面的数据传递
有时候传递数据的两个页面并非相互紧挨着，有时候数据需要传递给多个页面，那么上述的方法就不太好用了，下面介绍三个跨页面的数据传递: NSUserDefaults, Singleton, NSNotification。

### NSUserDefaults 

[官方文档](https://developer.apple.com/documentation/foundation/nsuserdefaults?language=objc)

简单来说`NSUserDefaults`是iOS系统提供的一个单例类(iOS提供了若干个单例类)，通过类方法`standardUserDefaults`可以获取`NSUserDefaults`单例，可以读写一下几类数据。

```
NSData
NSString
NSNumber(BOOL, integer, float, double)
NSDate
NSArray
NSDictionary
NSURL
```

使用NSUserDefaults很简单，在需要存储的地方写入数据，在需要使用的地方读取数据。当APP重新启动，版本更新，所存储的数据都不会丢失；但是如果将APP卸载了，存储在NSUserDefaults中的数据就会被一并删除。

1) 写入

```
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
[userDefaults setObject:@"This string was in NSUserDefaults." forKey:@"kPassingDataBetweenViewControllers"];
[userDefaults synchronize];

```

2) 读取

```
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
NSString *content = [userDefaults objectForKey:@"kPassingDataBetweenViewControllers"];
self.userDefaultsLabel.text = content;
```
### Singleton 单例


### NSNotification 通知

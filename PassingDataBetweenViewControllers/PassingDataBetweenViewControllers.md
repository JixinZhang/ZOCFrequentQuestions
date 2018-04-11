
>stackoverflow上关于Objective-C关注度比较高的问题系列
>[链接](https://stackoverflow.com/questions/tagged/objective-c?sort=frequent&pageSize=15)

#页面之间传递数据

原文链接[《Passing Data between View Controllers》](https://stackoverflow.com/questions/5210535/passing-data-between-view-controllers)

关键词
> Passing Data between View Controllers

##1.向下一个页面传递数据
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

##2.通过Segues进入下个页面的传递数据
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

##3.向上一个页面传递数据

**Passing Data Back**

从`ViewControllerB`向`ViewControllerA`回传数据，你可以使用Protocol ,delegate或者Block。

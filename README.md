# RAC+MVVM在实际项目中用法
* RACSignal
* RACSubject
* RACSequence
* RACMulticastConnection
* RACCommand
* RAC常用宏
* RAC-bind
* RAC-过滤操作集合
* RAC-映射
* RAC-组合
* RAC+MVVM-网络请求
* RAC+MVVM-登录逻辑


# YogaKitDemo
Yoga是facebook开源的一个编写视图的跨平台代码，YogaKit是用于iOS开发的,同时支持OC与swift。它是基于Flex，它在web移动端已经使用的非常广泛,让布局变得更简单。可以用它替代 iOS 的AutoLayout，也可以将它当成一种通用的布局系统使用。

AutoLayout令人诟病的问题，就是当视图增加的时候，计算复杂度成倍上升。AutoLayout依靠解线性方程组，所以越多的视图性能下降非常大。

Yogakit常见的几种布局方式（详细的flex布局使用，另行百度）

![](https://github.com/leoAntu/iOSCommonExample/blob/master/YogaKitDemo/2018-06-05%2015_15_17.gif)

# TextureExamples
Texture原名AsyncDisplayKit

![](https://github.com/leoAntu/iOSCommonExample/blob/master/AsyncDisplayTableViewDemo/2018-06-08%2014_42_45.gif)

#### Texture的几个优点
* 1.cell不需要复用，也不用算高度和位置等frame信息了
* 2.布局采用flex，更方便高效的布局方式
* 3.性能更高效，不掉帧，再也不担心卡顿现象，适合大列表和复杂cell使用。

#### Texture的几个注意点
* 1.reload单个cell，会出现一闪的现象，原因就是异步渲染UI，有一点的placeholder，解决办法参照Demo中
* 2.cell中若加载网络图片，需要ASNetworkImageNode 指定一个 ImageManager 用于管理网络请求、图像缓存等操作，[具体使用参照](https://www.jianshu.com/p/e5761e9a7850)

#### 总结
Texture是对整个UIKit的封装，理论上可以实现UIKit实现的界面，考虑到学习的陡峭和难免要踩的坑。
尽量在复杂多变的UITableView和UICollectionView中使用，不需要计算高度和性能问题。


# PopDemo
出自facebook的动画框架

![](https://github.com/leoAntu/iOSCommonExample/blob/master/PopDemo/2018-06-15%2016_51_23.gif)


# RxSwift常见使用参见Demo


# iOS开发中常见的转场动画使用Demo

# TextSlider-- 一个继承自UISlider，自带value text的slider

# ButtonEventInterval --- 可以方便有效防止Button连续点击

# ButtonChangeClickArea --- 改变Button的点击区域，在pointInside：withEvent方法中改变区域





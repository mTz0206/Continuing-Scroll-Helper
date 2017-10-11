# Continuing-Scroll-Helper
这是一个用来解决嵌套的ScrollView视图结构下连续滑动的问题的Helper

This helper is used for improving continuing-scrolling in nested UIScrollview UI structure.

![image](https://github.com/mTz0206/Continuing-Scroll-Helper/tree/master/Demo/gif.gif)

在一个tableView中加入一个webView cell 这个是一个常见的图层结构。上面是native的页面，下面是web的页面，这种情况下就有两个scrollView 嵌套在了一起，滚动事件就不太容易控制。一种解决方案就是直接把webView cell的高度直接设置成contentSize的高度，这样的话webView就全部展开了。带来的问题就是如果webView的内容过大会造成内存问题，所以webView的最大高度就是屏幕的高度。

Add a webView cell into a tableView , it is a common UI structure. Up views are written by native,and add a web view on bottom to show some H5 page , so in this case there are two scrollViews nested together, scrolling events are not easy to control. One solution is to directly set the height of the webView cell equal to the height of the contentSize, if we do like that ,it will cause memory issue when the web view is too large. so the maximum height of webView is the height of the screen.

```objc
  ContinuingScrollHelper *helper = [[ContinuingScrollHelper alloc] initWithScrollView:_tableView superView:self.view];
  [helper setFrame:CGRectMake(0, 0, GET_FULL_WIDTH, GET_FULL_HEIGHT)];
  _helper = helper;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ...
  scrollCell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
  [_helper setSecondScrollView:_scrollCell.scrollView];
  ...
}
```

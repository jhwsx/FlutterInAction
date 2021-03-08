import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogDemoRoute extends StatefulWidget {
  @override
  _DialogDemoRouteState createState() => _DialogDemoRouteState();
}

class MyFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("SnackBar")));
      },
      child: Icon(Icons.add),
    );
  }
}

class _DialogDemoRouteState extends State<DialogDemoRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("7.6 对话框详解"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyBuilder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  bool delete = await showDeleteConfirmDialog();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (delete == null) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('取消删除')));
                  } else {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('已确认删除')));
                  }
                },
                child: Text("AlertDialog-删除确认对话框"),
              );
            }),
            MyBuilder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  int result = await changeLanguage();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (result == 1) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('选择了 中文简体')));
                  } else if (result == 2) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('选择了 美国英语')));
                  }
                },
                child: Text("SimpleDialog-少量条目的列表选择框"),
              );
            }),
            MyBuilder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  int result = await showListDialog();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (result != null) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('选择了 $result')));
                  }
                },
                child: Text("Dialog-大量条目的列表选择框"),
              );
            }),
            Builder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  bool delete = await showCustomDeleteConfirmDialog();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (delete == null) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('取消删除')));
                  } else {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('已确认删除')));
                  }
                },
                child: Text("showDialog-自定义打开动画及遮罩"),
              );
            }),
            Builder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  int result = await _showModalBottomSheet();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (result != null) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('点击了 $result')));
                  }
                },
                child: Text("showModalBottomSheet-底部菜单列表模态对话框"),
              );
            }),
            Builder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  // 这里为什么要传递 ctx 呢？
                  // https://stackoverflow.com/questions/60071855/no-scaffold-widget-found-getting-exception-while-opening-bottom-dialog-sheet
                  _showBottomSheet(ctx);
                },
                child: Text("showBottomSheet-底部菜单列表非模态对话框"),
              );
            }),
            ElevatedButton(
              onPressed: () {
                _showLoadingDialog();
              },
              child: Text("Loading框"),
            ),
            ElevatedButton(
              onPressed: () {
                _showDatePickerMaterial();
              },
              child: Text("日历选择器-Material"),
            ),
            ElevatedButton(
              onPressed: () {
                _showDatePickerCupertino();
              },
              child: Text("日历选择器-Cupertino"),
            ),
            MyBuilder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  Pair<bool, bool> result =
                      await showStateDeleteConfirmDialog1();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (result == null) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('取消删除')));
                  } else {
                    _scaffoldState.showSnackBar(SnackBar(
                        content: Text('已确认删除, 包含子目录否：${result.second}')));
                  }
                },
                child: Text("对话框状态管理-勾选不生效示例"),
              );
            }),
            MyBuilder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  Pair<bool, bool> result =
                      await showStateDeleteConfirmDialog2();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (result == null) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('取消删除')));
                  } else {
                    _scaffoldState.showSnackBar(SnackBar(
                        content: Text('已确认删除, 包含子目录否：${result.second}')));
                  }
                },
                child: Text("对话框状态管理-勾选生效-单独抽出 StatefulWidget"),
              );
            }),
            MyBuilder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  Pair<bool, bool> result =
                      await showStateDeleteConfirmDialog3();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (result == null) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('取消删除')));
                  } else {
                    _scaffoldState.showSnackBar(SnackBar(
                        content: Text('已确认删除, 包含子目录否：${result.second}')));
                  }
                },
                child: Text("对话框状态管理-勾选生效-使用 StatefulBuilder"),
              );
            }),
            MyBuilder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  Pair<bool, bool> result =
                      await showStateDeleteConfirmDialog4();
                  var _scaffoldState = Scaffold.of(ctx);
                  if (result == null) {
                    _scaffoldState
                        .showSnackBar(SnackBar(content: Text('取消删除')));
                  } else {
                    _scaffoldState.showSnackBar(SnackBar(
                        content: Text('已确认删除, 包含子目录否：${result.second}')));
                  }
                },
                child: Text("对话框状态管理-勾选生效-使用 markNeedsBuild"),
              );
            }),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Scaffold.of(context)
      //         .showSnackBar(SnackBar(content: Text("SnackBar")));
      //   },
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButton: MyFab(),
    );
  }

  Future<bool> showDeleteConfirmDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            // 如果使用 ListView，则报错： RenderViewport does not support returning intrinsic dimensions.
            // 因为他们是延迟加载模型的组件。而 AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸
            // content: ListView(),
            content: Text('您确认要删除当前文件吗？'),
            actions: <Widget>[
              TextButton(
                // 关闭对话框
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              TextButton(
                // 关闭对话框并返回 true
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('删除'),
              ),
            ],
          );
        });
  }

  bool withTree = false;

  Future<Pair<bool, bool>> showStateDeleteConfirmDialog1() {
    withTree = false;
    return showDialog<Pair<bool, bool>>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确认要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    Checkbox(
                        value: withTree,
                        onChanged: (bool value) {
                          // 解释角度1：这里调用 setState() 方法并没有选中复选框，原因是 setState 方法
                          // 只能针对当前 context 的子树进行重新 build。
                          // 解释角度2：对话框是通过路由的方式来实现的。在父路由中调用 setState 方法来让子路由
                          // 更新，这是不行的。
                          setState(() {
                            print('$this'); // 打印： _DialogRouteState#94d1f
                            withTree = !withTree;
                          });
                        }),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                // 关闭对话框
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              TextButton(
                // 关闭对话框并返回 true
                onPressed: () =>
                    Navigator.of(context).pop(Pair(true, withTree)),
                child: Text('删除'),
              ),
            ],
          );
        });
  }

  Future<Pair<bool, bool>> showStateDeleteConfirmDialog2() {
    withTree = false;
    return showDialog<Pair<bool, bool>>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确认要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    DialogCheckbox(
                        value: withTree,
                        onChanged: (bool value) {
                          setState(() {
                            print('$this'); // 打印： _DialogRouteState#94d1f
                            withTree = !withTree;
                          });
                        }),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                // 关闭对话框
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              TextButton(
                // 关闭对话框并返回 true
                onPressed: () =>
                    Navigator.of(context).pop(Pair(true, withTree)),
                child: Text('删除'),
              ),
            ],
          );
        });
  }

  Future<Pair<bool, bool>> showStateDeleteConfirmDialog3() {
    withTree = false;
    return showDialog<Pair<bool, bool>>(
        context: context,
        builder: (context) {
          print('context = $context'); // context = Builder(dirty)
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确认要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    MyStatefulBuilder(
                      // 这里的 ctx 和上面的 context 不一样。
                      builder: (BuildContext ctx, StateSetter setState) {
                        // ctx=MyStatefulBuilder(dirty, state: _MyStatefulBuilderState#22eb2)
                        print('ctx=$ctx');
                        // setState 其实就是 MyStatefulBuilder 的父类 StatefulWidget 里的 setState 方法。
                        print('setState=${setState.hashCode}');
                        return Checkbox(
                          value: withTree,
                          onChanged: (bool value) {
                            setState(() {
                              withTree = !withTree;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                // 关闭对话框
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              TextButton(
                // 关闭对话框并返回 true
                onPressed: () =>
                    Navigator.of(context).pop(Pair(true, withTree)),
                child: Text('删除'),
              ),
            ],
          );
        });
  }

  Future<Pair<bool, bool>> showStateDeleteConfirmDialog4() {
    withTree = false;
    return showDialog<Pair<bool, bool>>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('您确认要删除当前文件吗？'),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    // 使用 Builder 来缩小 context 的范围。
                    Builder(builder: (BuildContext context) {
                      return Checkbox(
                        value: withTree,
                        onChanged: (bool value) {
                          // 在组件树中，context实际上就是Element对象的引用。
                          // 直接将对话框UI对应的Element标记为dirty。
                          (context as Element).markNeedsBuild();
                          withTree = !withTree;
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                // 关闭对话框
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              TextButton(
                // 关闭对话框并返回 true
                onPressed: () =>
                    Navigator.of(context).pop(Pair(true, withTree)),
                child: Text('删除'),
              ),
            ],
          );
        });
  }

  Future<int> changeLanguage() {
    return showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          // 它会展示一个列表，用于列表选择的场景。
          return SimpleDialog(
            title: Text("请选择语言"),
            children: <Widget>[
              // 不可以添加延迟加载模型的组件
              // ListView(),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(1);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(2);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('美国英语'),
                ),
              ),
            ],
          );
        });
  }

  Future<int> showListDialog() {
    return showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              children: <Widget>[
                ListTile(title: Text("请选择")),
                Expanded(
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text("$index"),
                        onTap: () {
                          Navigator.of(context).pop(index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<bool> showCustomDeleteConfirmDialog() {
    return showCustomDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            // 如果使用 ListView，则报错： RenderViewport does not support returning intrinsic dimensions.
            // 因为他们是延迟加载模型的组件。而 AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸
            // content: ListView(),
            content: Text('您确认要删除当前文件吗？'),
            actions: <Widget>[
              TextButton(
                // 关闭对话框
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              TextButton(
                // 关闭对话框并返回 true
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('删除'),
              ),
            ],
          );
        });
  }

  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () {
                return Navigator.of(context).pop(index);
              },
            );
          });
        });
  }

  PersistentBottomSheetController<int> _showBottomSheet(BuildContext ctx) {
    return showBottomSheet(
        // 要使用 Scaffold 的 context。
        context: ctx,
        builder: (BuildContext context) {
          return ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                  onTap: () {
                    return Navigator.of(context).pop(index);
                  },
                );
              });
        });
  }

  _showLoadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text("正在加载，请稍后..."),
                ),
              ],
            ),
          );
        });
  }

  Future<DateTime> _showDatePickerMaterial() {
    var dateTime = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime,
      lastDate: dateTime.add(
        Duration(days: 30),
      ),
    );
  }

  Future<DateTime> _showDatePickerCupertino() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }
}

// 这是从 showDialog 拷贝过来修改了一下。
Future<T> showCustomDialog<T>({
  @required
      BuildContext context,
  WidgetBuilder builder,
  bool barrierDismissible = true,
  Color barrierColor,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings routeSettings,
  @Deprecated(
      'Instead of using the "child" argument, return the child from a closure '
      'provided to the "builder" argument. This will ensure that the BuildContext '
      'is appropriate for widgets built in the dialog. '
      'This feature was deprecated after v0.2.3.')
      Widget child,
}) {
  assert(child == null || builder == null);
  assert(barrierDismissible != null);
  assert(useSafeArea != null);
  assert(useRootNavigator != null);
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context);
  // 对话框最终都是由 showGeneralDialog 方法打开的。
  // 它的实现也是通过路由实现的。
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = child ?? Builder(builder: builder);
      Widget dialog = Builder(builder: (BuildContext context) {
        return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
      });
      if (useSafeArea) {
        dialog = SafeArea(child: dialog);
      }
      return dialog;
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    // 修改了背景色
    barrierColor: barrierColor ?? Colors.black87,
    // 修改动画时长
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: _buildDialogTransitions,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
  );
}

Widget _buildDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  // 修改了动画
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

// 这只是系统的 Builder 改了个名字而已。
class MyBuilder extends StatelessWidget {
  const MyBuilder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context);
}

// 单独抽取出 StatefulWidget
// 把复选框的选中逻辑单独封装成一个 StatefulWidget，在内部管理复选状态。
class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({Key key, this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool _value;

  @override
  void initState() {
    _value = widget.value; // 初始化
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: _value,
        onChanged: (v) {
          widget.onChanged(v);
          setState(() {
            _value = v;
          });
        });
  }
}

// 只是把系统的 StatefulBuilder 改了个名字而已。
// 本质上是子组件通知父组件（StatefulWidget）重新build子组件本身来实现UI更新的。
class MyStatefulBuilder extends StatefulWidget {
  const MyStatefulBuilder({Key key, @required this.builder})
      : assert(builder != null),
        super(key: key);

  // StatefulBuilder 获取了StatefulWidget 的上下文，并代理了其构建过程
  final StatefulWidgetBuilder builder;

  @override
  _MyStatefulBuilderState createState() => _MyStatefulBuilderState();
}

class _MyStatefulBuilderState extends State<MyStatefulBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState);
  }
}

class Pair<F, S> {
  Pair(this.first, this.second);

  F first;
  S second;
}

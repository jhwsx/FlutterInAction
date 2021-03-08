import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 知识点:
// 输入框组件: TextField
// 表单组件: Form
class TextFieldAndFormRoute extends StatefulWidget {
  @override
  _TextFieldAndFormRouteState createState() => _TextFieldAndFormRouteState();
}

class _TextFieldAndFormRouteState extends State<TextFieldAndFormRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入框及表单'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TextFieldRoute();
              }));
            },
            child: Text('输入框'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormRoute();
              }));
            },
            child: Text('表单'),
          ),
        ],
      ),
    );
  }
}
// TextField 的属性：

// 非常详细的参考文章：https://blog.csdn.net/yuzhiqiang_1993/article/details/88204031

// 1, final int maxLength: 允许在 TextField 里的字符的最大长度.
//
// 设置了这个属性，那么一个字符计数器就会出现在TextField 的下方，展示已经输入的字符个数。如果
// 设置为一个大于 0 的值，那么计数器也会展示允许的最大字符数。如果设置为 TextField.noMaxLength
// 这个常量值，那么计数器仅仅展示当前的字符数目。
//
// 默认情况下，在 maxLength 个字符被输入后，再输入就会被忽略。如果把 maxLengthEnforced 设置
// 为 false，那么在 maxLength 个字符被输入后，允许继续输入字符。虽然 maxLengthEnforced 被
// 设置为 false，但是 TextField 仍然可以使用 LengthLimitingTextInputFormatter 限制字符的
// 长度。
//
// maxLength 的值要么是 null（默认值），要么是 TextField.noMaxLength, 要么是大于 0 的数。
// null 表示没有输入个数的限制，但是不会有字符计数器; TextField.noMaxLength 也表示没有输入
// 字符个数的限制，但是会有字符计数器；设置为大于 0 的数，表示有输入字符个数的限制，也有字符
// 计数器，包含了限制个数的信息在里面。

// 2, final bool maxLengthEnforced: 默认值是 true。如果设置为 true，表示阻止 TextField 允许输入超过 maxLength 的字符;
// 如果设置为 false，那么允许输入超过 maxLength 长度的字符，并且输入超过 maxLength 长度的字符后，会有警告。

// 3, final int maxLines: 设置最大行数。默认是 1, 设置为 null，就去掉了行数的限制。
// maxLines 不可以是 0 。

// 4, final TextStyle style: 输入文本的样式

// 5, final bool showCursor: 是否显示光标

// 6, final bool autofocus: 自动获取焦点，默认是false。

// 7, final ValueChanged<String> onChanged; 内容改变时的回调

// 8, final bool enabled： 默认是 true。设置为 false，表示 TextField 被禁用了。

// 9. final TextEditingController controller: 控制正被编辑的文本。如果是 null，
// TextField 会创建它自己的 TextEditingController。

// 10. final InputDecoration decoration：TextField 的装饰器。默认的装饰，在 TextField 底部
// 画一根水平的线。但是可以配置显示 icon，标签，提示文字，以及错误文字。
// 设置为 null，将移除所有的装饰。

// 11, final bool obscureText: 是否隐藏输入文本，如在输入密码的情形。但是这里设置为 true，
// 那么 maxLines 就只能而且必须设置为 1, 否则 Obscured fields cannot be multiline.

// 12, final List<TextInputFormatter> inputFormatters：对输入文本进行校验
class TextFieldRoute extends StatefulWidget {
  @override
  _TextFieldState createState() {
    return _TextFieldState();
  }
}

class _TextFieldState extends State<TextFieldRoute> {
  var _usernameController;
  var _passwordController;
  FocusNode _focusNode1;
  FocusNode _focusNode2;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    // _usernameController.text = "wangzhichao";
    // _usernameController.selection = TextSelection(
    //   baseOffset: 4,
    //   extentOffset: _usernameController.text.length,
    // );
    _usernameController.addListener(() {
      print('input ${_usernameController.text}');
    });
    _focusNode1.addListener(() {
      print('用户名 TextField 的焦点：${_focusNode1.hasFocus}');
    });
    _focusNode2.addListener(() {
      print('密码 TextField 的焦点：${_focusNode2.hasFocus}');
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('输入框')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              // 关联 FocusNode1
              focusNode: _focusNode1,
              controller: _usernameController,
              maxLength: 20,
              maxLines: 1,
              autocorrect: true,
              maxLengthEnforced: false,
              inputFormatters: [LengthLimitingTextInputFormatter(30)],
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              autofocus: true,
              showCursor: true,
              cursorColor: Colors.blue,
              cursorWidth: 2.0,
              cursorRadius: Radius.circular(1.0),
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.blue),
                labelText: '用户名',
                labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
                helperText: '用户名为手机号或者邮箱',
                helperStyle: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16.0,
                ),
                hintText: '请输入用户名',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (String value) {
                print('onChanged: $value');
              },
              enabled: true,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              obscureText: false,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              // 关联 FocusNode2
              focusNode: _focusNode2,
              controller: _passwordController,
              maxLength: 10,
              maxLines: 1,
              autocorrect: true,
              maxLengthEnforced: false,
              inputFormatters: [LengthLimitingTextInputFormatter(30)],
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              autofocus: false,
              showCursor: true,
              cursorColor: Colors.blue,
              cursorWidth: 2.0,
              cursorRadius: Radius.circular(1.0),
              decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.blue),
                labelText: '密码',
                labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
                helperText: '密码为纯数字，不大于10位',
                helperStyle: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16.0,
                ),
                hintText: '请输入密码',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (String value) {
                print('onChanged: $value');
              },
              onSubmitted: (String value) {
                print('onSubmitted');
              },
              enabled: true,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Builder(builder: (context) {
                  return TextButton(
                    onPressed: () {
                      var scaffoldState = Scaffold.of(context);
                      scaffoldState.showSnackBar(SnackBar(
                        // 获取输入内容：通过 controller 来获取。
                        content: Text(
                          '用户名：${_usernameController.text}, 密码：${_passwordController.text}',
                        ),
                      ));
                    },
                    child: Text(
                      '提交',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue),
                    ),
                  );
                }),
                Builder(builder: (context) {
                  return TextButton(
                    onPressed: () {
                      var focusedChild = FocusScope.of(context).focusedChild;
                      if (focusedChild == _focusNode1) {
                        FocusScope.of(context).requestFocus(_focusNode2);
                      } else {
                        FocusScope.of(context).requestFocus(_focusNode1);
                      }
                    },
                    child: Text(
                      '移动焦点',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue),
                    ),
                  );
                }),
                TextButton(
                  onPressed: () {
                    // 当所有编辑框都失去焦点时键盘就会收起
                    _focusNode1.unfocus();
                    _focusNode2.unfocus();
                  },
                  child: Text(
                    '隐藏键盘',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormRoute extends StatefulWidget {
  @override
  _FormRouteState createState() => _FormRouteState();
}

class _FormRouteState extends State<FormRoute> {
  var _usernameController;
  var _passwordController;
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('表单')),
      body: Form(
        key: _formKey, // 设置globalKey，用于后面获取FormState
        autovalidateMode: AutovalidateMode.always, // 开启自动校验
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                maxLength: 20,
                maxLines: 1,
                autocorrect: true,
                maxLengthEnforced: false,
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                autofocus: false,
                showCursor: true,
                cursorColor: Colors.blue,
                cursorWidth: 2.0,
                cursorRadius: Radius.circular(1.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.blue),
                  labelText: '用户名',
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
                  helperText: '用户名为手机号或者邮箱',
                  helperStyle: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 16.0,
                  ),
                  hintText: '请输入用户名',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                onChanged: (String value) {
                  print('onChanged: $value');
                },
                enabled: true,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obscureText: false,
                onSaved: (String text) {
                  print('onSaved: $text');
                },
                validator: (v) {
                  return v.trim().length > 0 ? null : '用户名不可以为空';
                },
              ),
              TextFormField(
                controller: _passwordController,
                maxLength: 10,
                maxLines: 1,
                autocorrect: true,
                maxLengthEnforced: false,
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                autofocus: false,
                showCursor: true,
                cursorColor: Colors.blue,
                cursorWidth: 2.0,
                cursorRadius: Radius.circular(1.0),
                decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: Colors.blue),
                    labelText: '密码',
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
                    helperText: '密码为纯数字，不大于10位',
                    helperStyle: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16.0,
                    ),
                    hintText: '请输入密码',
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
                onChanged: (String value) {
                  print('onChanged: $value');
                },
                enabled: true,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                obscureText: true,
                validator: (v) {
                  return v.trim().length > 5 ? null : '密码不能少于 6 位';
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Builder(builder: (context) {
                    return FlatButton(
                      onPressed: () {
//                      FormState formState = Form.of(context);
                        var currentState = (_formKey.currentState as FormState);
                        if (currentState.validate()) {
                          var scaffoldState = Scaffold.of(context);
                          scaffoldState.showSnackBar(SnackBar(
                            // 获取输入内容：通过 controller 来获取。
                            content: Text(
                              '用户名：${_usernameController.text}, 密码：${_passwordController.text}',
                            ),
                          ));
                        }
                      },
                      color: Colors.blue,
                      colorBrightness: Brightness.dark,
                      child: Text('提交'),
                    );
                  }),
                  Builder(builder: (context) {
                    return FlatButton(
                      onPressed: () {
//                      FormState formState = Form.of(context);
                        var currentState = (_formKey.currentState as FormState);
                        currentState.save();
                        var scaffoldState = Scaffold.of(context);
                        scaffoldState.showSnackBar(SnackBar(
                          // 获取输入内容：通过 controller 来获取。
                          content: Text(
                            '保存了',
                          ),
                        ));
                      },
                      color: Colors.blue,
                      colorBrightness: Brightness.dark,
                      child: Text('保存'),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

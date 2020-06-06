import 'package:flutter/material.dart';

class SwitchAndCheckBoxRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxRouteState createState() => _SwitchAndCheckBoxRouteState();
}

class _SwitchAndCheckBoxRouteState extends State<SwitchAndCheckBoxRoute> {

  var _switchState1 = false;

  _handleSwitch1Changed(bool newValue) {
    setState(() {
      _switchState1 = newValue;
    });
  }

  var _checkBoxState1 = false;

  _handleCheckBox1Changed(bool newValue) {
    setState(() {
      _checkBoxState1 = newValue;
    });
  }

  var _checkBoxState2 = false;

  _handleCheckBox2Changed(bool newValue) {
    setState(() {
      _checkBoxState2 = newValue;
    });
  }

  var _checkBoxState3 = false;

  _handleCheckBox3Changed(bool newValue) {
    setState(() {
      _checkBoxState3 = newValue;
    });
  }
  var _checkBoxState4 = true;
  var _checkBoxState5 = false;
  var _checkBoxState6 = false;

  _handleCheckBox4Changed(bool newValue) {
    setState(() {
      _checkBoxState4 = true;
      _checkBoxState5 = false;
      _checkBoxState6 = false;
    });
  }


  _handleCheckBox5Changed(bool newValue) {
    setState(() {
      _checkBoxState4 = false;
      _checkBoxState5 = true;
      _checkBoxState6 = false;
    });
  }


  _handleCheckBox6Changed(bool newValue) {
    setState(() {
      _checkBoxState4 = false;
      _checkBoxState5 = false;
      _checkBoxState6 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('单选开关和复选框'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Switch(
                value: _switchState1,
                onChanged: _handleSwitch1Changed,
              ),
              Text(_switchState1 ? '开' : '关'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _checkBoxState1,
                onChanged: _handleCheckBox1Changed,
              ),
              Text(_checkBoxState1 ? '勾选' : '不勾选'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _checkBoxState2,
                activeColor: Colors.green,
                // 对勾的颜色
                checkColor: Colors.blue,
                onChanged: _handleCheckBox2Changed,
              ),
              Text(_checkBoxState2 ? '开启' : '关闭'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _checkBoxState3,
                activeColor: Colors.green,
                // 对勾的颜色
                checkColor: Colors.blue,
                onChanged: _handleCheckBox3Changed,
                tristate: true,
              ),
              Text(_getCheckBoxState3Text()),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _checkBoxState4,
                activeColor: Colors.green,
                // 对勾的颜色
                checkColor: Colors.white,
                onChanged: _handleCheckBox4Changed,
              ),
              Text('火车'),
              Checkbox(
                value: _checkBoxState5,
                activeColor: Colors.green,
                // 对勾的颜色
                checkColor: Colors.white,
                onChanged: _handleCheckBox5Changed,
              ),
              Text('汽车'),
              Checkbox(
                value: _checkBoxState6,
                activeColor: Colors.green,
                // 对勾的颜色
                checkColor: Colors.white,
                onChanged: _handleCheckBox6Changed,
              ),
              Text('飞机'),
            ],
          ),
        ],
      ),
    );
  }

  String _getCheckBoxState3Text() {
      if(_checkBoxState3 == null) {
        return '未全选';
      }
      return _checkBoxState3 ? '全选' : '全不选';
  }
}



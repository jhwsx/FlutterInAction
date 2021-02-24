import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:json_annotation/json_annotation.dart';

part 'json_parse.g.dart';

class JsonParseWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JsonParseWidgetState();
}

class _JsonParseWidgetState extends State<JsonParseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json 渐进式解析'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'JsonObject格式:',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: FutureBuilder(
                  // DefaultAssetBundle是一个帮助开发者从Asset中读取文件的工具
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/basicMap.json"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> decodeJson =
                          json.decode(snapshot.data);
                      BasicMap basicMap = BasicMap.fromJson(decodeJson);
                      // 不需要手动调用toJson这个方法，因为 json.encode 内部会自动调用。
                      String jsonString = json.encode(basicMap);
                      return Text(
                          "反序列化：${basicMap.toString()}, 序列化：$jsonString");
                    } else {
                      return Text("Loading...");
                    }
                  }),
            ),
            Text(
              'JsonObject格式_带有数组格式数据:',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: FutureBuilder(
                  // DefaultAssetBundle是一个帮助开发者从Asset中读取文件的工具
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/basicMapWithList.json"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> decodeJson =
                          json.decode(snapshot.data);
                      BasicMapWithList basicMap =
                          BasicMapWithList.fromJson(decodeJson);
                      String jsonString = json.encode(basicMap);
                      return Text(
                          "反序列化：${basicMap.toString()}, 序列化：$jsonString");
                    } else {
                      return Text("Loading...");
                    }
                  }),
            ),
            Text(
              'JsonObject格式_嵌套JsonObject数据:',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: FutureBuilder(
                  // DefaultAssetBundle是一个帮助开发者从Asset中读取文件的工具
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/basicMapWithObject.json"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> decodeJson =
                          json.decode(snapshot.data);
                      print('decodeJson["data"]= ${decodeJson['data']}');
                      BasicMapWithObject basicMap =
                          BasicMapWithObject.fromJson(decodeJson);
                      String jsonString = json.encode(basicMap);
                      return Text(
                          "反序列化：${basicMap.toString()}, 序列化：$jsonString");
                    } else {
                      return Text("Loading...");
                    }
                  }),
            ),
            Text(
              'JsonObject格式_带有List类型JsonObject数据:',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: FutureBuilder(
                  // DefaultAssetBundle是一个帮助开发者从Asset中读取文件的工具
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/basicMapWithObjectList.json"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> decodeJson =
                          json.decode(snapshot.data);
                      BasicMapWithObjectList basicMap =
                          BasicMapWithObjectList.fromJson(decodeJson);
                      String jsonString = json.encode(basicMap);
                      return Text(
                          "反序列化：${basicMap.toString()}, 序列化：$jsonString");
                    } else {
                      return Text("Loading...");
                    }
                  }),
            ),
            Text(
              'JsonArray格式:',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: FutureBuilder(
                  // DefaultAssetBundle是一个帮助开发者从Asset中读取文件的工具
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/jsonArray.json"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      // 转换出的是 List 类型，而不是 Map 类型，这是因为 json 是个 JsonArray。
                      List<dynamic> decodeJson = json.decode(snapshot.data);
                      BasicList basicMap = BasicList.fromJson(decodeJson);
                      String jsonString = json.encode(basicMap);
                      return Text(
                          "反序列化：${basicMap.toString()}, 序列化：$jsonString");
                    } else {
                      return Text("Loading...");
                    }
                  }),
            ),
            Text(
              'JsonObject格式_嵌套JsonObject数据使用 json_serializable:',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: FutureBuilder(
                  // DefaultAssetBundle是一个帮助开发者从Asset中读取文件的工具
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/basicMapWithObject2.json"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      // 转换出的是 List 类型，而不是 Map 类型，这是因为 json 是个 JsonArray。
                      Map<String, dynamic> decodeJson =
                          json.decode(snapshot.data);
                      BasicMapWithObject2 basicMap =
                          BasicMapWithObject2.fromJson(decodeJson);
                      String jsonString = json.encode(basicMap);
                      return Text(
                          "反序列化：${basicMap.toString()}, 序列化：$jsonString");
                    } else {
                      return Text("Loading...");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class BasicMap {
  int code;
  String result;
  String message;

  BasicMap.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        result = json['result'],
        message = json['message'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        "code": code,
        "result": result,
        "message": message,
      };

  @override
  String toString() {
    return 'BasicMap{code: $code, result: $result, message: $message}';
  }
}

class BasicMapWithList {
  int code;
  String result;
  String message;
  List<String> data;

  BasicMapWithList.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        result = json['result'],
        message = json['message'],
        // data = json['data']; // 这里报错：type 'List<dynamic>' is not a subtype of type 'List<String>'
        data = List<String>.from(json['data']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        "code": code,
        "result": result,
        "message": message,
        "data": data,
      };

  @override
  String toString() {
    return 'BasicMapWithList{code: $code, result: $result, message: $message, data: $data}';
  }
}

class Data {
  String name;
  int age;

  Data.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "age": age,
      };

  @override
  String toString() {
    return 'Data{name: $name, age: $age}';
  }
}

class BasicMapWithObject {
  int code;
  String result;
  String message;
  Data data;

  BasicMapWithObject.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        result = json['result'],
        message = json['message'],
        // data = json['data']; // 报错：type 'List<dynamic>' is not a subtype of type 'Data'
        data = Data.fromJson(json['data']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        "code": code,
        "result": result,
        "message": message,
        "data": data,
      };

  @override
  String toString() {
    return 'BasicMapWithObject{code: $code, result: $result, message: $message, data: $data}';
  }
}

class Person {
  String name;
  int age;

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "age": age,
      };

  @override
  String toString() {
    return 'Person{name: $name, age: $age}';
  }
}

class BasicMapWithObjectList {
  int code;
  String result;
  String message;
  List<Person> data;

  BasicMapWithObjectList.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        result = json['result'],
        message = json['message'],
        // data = json['data'].map((value) => Person.fromJson(value)
        // ).toList(); // 报错：type 'List<dynamic>' is not a subtype of type 'List<Person>'

        data = List<Person>.from(json['data'].map((value) {
          return Person.fromJson(value);
        }).toList());

  Map<String, dynamic> toJson() => <String, dynamic>{
        "code": code,
        "result": result,
        "message": message,
        "data": data.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'BasicMapWithObjectList{code: $code, result: $result, message: $message, data: $data}';
  }
}

class Family {
  String name;
  int age;
  String gender;

  Family.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        age = json["age"],
        gender = json["gender"];

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "age": age,
        "gender": gender,
      };

  @override
  String toString() {
    return 'Family{name: $name, age: $age, gender: $gender}';
  }
}

class BasicList {
  List<Family> families;

  BasicList.fromJson(List<dynamic> json)
      : families = json.map((e) => Family.fromJson(e)).toList();

  List<dynamic> toJson() => families.map((e) => e.toJson()).toList();

  @override
  String toString() {
    return 'BasicList{families: $families}';
  }
}

@JsonSerializable(nullable: false)
class BasicMapWithObject2 {
  int code;
  String result;
  String message;
  Man data;

  BasicMapWithObject2(this.code, this.result, this.message, this.data);

  factory BasicMapWithObject2.fromJson(Map<String, dynamic> json) =>
      _$BasicMapWithObject2FromJson(json);

  Map<String, dynamic> toJson() => _$BasicMapWithObject2ToJson(this);

  @override
  String toString() {
    return 'BasicMapWithObject2{code: $code, result: $result, message: $message, data: ${data.toString()}}';
  }
}

@JsonSerializable(nullable: false)
class Man {
  String name;
  int age;

  Man(this.name, this.age);

  factory Man.fromJson(Map<String, dynamic> json) => _$ManFromJson(json);

  Map<String, dynamic> toJson() => _$ManToJson(this);

  @override
  String toString() {
    return 'Man{name: $name, age: $age}';
  }
}

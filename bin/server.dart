import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart';
import 'package:sqljocky/sqljocky.dart';
import 'dart:core';
import 'dart:io';
import 'dart:convert';

Map<String, String> data = new Map();
final pool = new ConnectionPool(host: "localhost",
    port: 3306,
    user: 'mini',
//用你自己的账号替代
    password: 'webex3',
//用你自己的密码替代
    db: 'morse_code',
//用你自己的数据库替代
    max: 5); //与数据库相连

main(List<String> args) async {
  //可不关注此处代码
  var parser = new ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '8080');
  var result = parser.parse(args);
  var port = int.parse(result['port'], onError: (val) {
    stdout.writeln('Could not parse port value "$val" into a number.');
    exit(1);
  });
//建立路由
  var myRouter = router();
  myRouter.get('/rest', _echoUserName);
  myRouter.post('/rest', _echoRequest);
  //配置cors参数
  Map <String, String> corsHeader = new Map();
  corsHeader["Access-Control-Allow-Origin"] = "*";
  corsHeader["Access-Control-Allow-Methods"] = 'POST,GET,OPTIONS';
  corsHeader['Access-Control-Allow-Headers'] =
  'Origin, X-Requested-With, Content-Type, Accept';
  var routerHandler = myRouter.handler;
  //配置shelf中间件和路由handle
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addMiddleware(
      shelf_cors.createCorsHeadersMiddleware(corsHeaders: corsHeader))
      .addHandler(routerHandler);

//启动服务器
  io.serve(handler, '127.0.0.1', port).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}


void main() {
  var myRouter = router()
    ..get('/userinfo',responseUser)
    //登录
    ..post ('/signup',postUser)
    ..get('/question/twelvetype',responsequestion)
     //获取题目
    ..get('/geterr',responseerr)
     //获取错题
    ..post('/posterr',posterr);
     //发送错题
  io.serve(myRouter.handler,'localhost',8080);
}

responsequestion(request){
  //todo 访问题目列表，获取练习题
}

responseerr(request){
  //todo 访问错题列表，获取错题
}
posterr(request) {
  //todo 发送错题至错题列表
}
responseUser(request){
  //todo 登录时获取用户信息
}
postUser(resquest){
  //todo 注册时发送用户信息
}

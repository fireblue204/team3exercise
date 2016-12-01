// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';
HttpRequest request;
void main(){
  querySelector("#btnPRLB").onClick.listen(click);

}
void click(MouseEvent e) {
  String questAsJson = '''
  {"quest":[{"word":"A","time":"2"},{"word":"5","time":"1"}]
  }
  ''';
  Map questData = JSON.decode(questAsJson);
  var QuestList = questData["quest"];
  var WordData = QuestList[0]["word"];

  querySelector("#QUES").text =WordData.toString();


}
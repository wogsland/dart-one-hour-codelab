// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:html';

//vars
ButtonElement genButton;

//funkytowns
void main() {
  // input box
  querySelector('#inputName').onInput.listen(updateBadge);
  
  // button
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
}

void updateBadge(Event e) {
  //querySelector('#badgeName').text = (e.target as InputElement).value;
  String inputName = (e.target as InputElement).value;
  setBadgeName(inputName);
  if (inputName.trim().isEmpty) {
    genButton..disabled = false
             ..text = "Now, tell us it's nameses!";
  } else {
    genButton..disabled = true
             ..text = "Stupid, fat hobbit.";
  }
}

void setBadgeName(String newName) {
  querySelector('#badgeName').text = newName;
}

void generateBadge(Event e) {
  setBadgeName('Inigo Montoya. You killed my father; prepare to die.');
}
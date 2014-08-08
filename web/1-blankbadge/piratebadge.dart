// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// import the things to build with...
// supposedly "code bloat is not an issue because of tree-shaking"
import 'dart:html';
import 'dart:math' show Random; //but here we're only grabbing one class
import 'dart:convert' show JSON; //sure, the syntax is all Java, but we still like JSONs

//vars & constants
ButtonElement genButton;
final String TREASURE_KEY = 'pirateName';

//funkytowns
void main() {
  // input box
  querySelector('#inputName').onInput.listen(updateBadge);
  
  // button
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
  setBadgeName(getBadgeNameFromStorage());
}

void updateBadge(Event e) {
  //querySelector('#badgeName').text = (e.target as InputElement).value;
  String inputName = (e.target as InputElement).value;
  setBadgeName(new PirateName(firstName: inputName));
  if (inputName.trim().isEmpty) {
    genButton..disabled = false
             ..text = "Now, tell us it's nameses!";
  } else {
    genButton..disabled = true
             ..text = "Stupid, fat hobbit.";
  }
}

void setBadgeName(PirateName newName) {
  if (newName == null) {
    return;
  }
  querySelector('#badgeName').text = newName.pirateName;
  window.localStorage[TREASURE_KEY] = newName.jsonString;
}

PirateName getBadgeNameFromStorage() {
  String storedName = window.localStorage[TREASURE_KEY];
  if (storedName != null) {
    return new PirateName.fromJSON(storedName);
  } else {
    return null;
  }
}

void generateBadge(Event e) {
  //setBadgeName('Inigo Montoya. You killed my father; prepare to die.');
  setBadgeName(new PirateName());
}

/* These comments work, too */
class PirateName {
  
  // vars and constants
  static final Random indexGen = new Random();
  String _firstName; // The underscore is how one makes variables private. Weird.
  String _appellation; // (not the mountains)
  static final List names = ['Jor','Lara','Kal','John','Martha','Clark'];
  static final List appellations = ['El','Kent'];
  
  // constructors
  PirateName({String firstName, String appellation}) {
    if (firstName == null) {
      _firstName = names[indexGen.nextInt(names.length)];
    } else {
      _firstName = firstName;
    }
    if (appellation == null) {
      _appellation = appellations[indexGen.nextInt(appellations.length)];
    } else {
      _appellation = appellation;
    }
  }
  PirateName.fromJSON(String jsonString) {
    Map storedName = JSON.decode(jsonString);
    _firstName = storedName['f'];
    _appellation = storedName['a'];
  }
  
  
  
  // other methods
  String toString() => pirateName; //mission critical line left out of tutorial
  String get pirateName => _firstName.isEmpty ? '' : '$_firstName the $_appellation';
  String get jsonString => JSON.encode({"f": _firstName, "a": _appellation});
}


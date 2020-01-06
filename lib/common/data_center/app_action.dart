

class AddTestAction {
  final int test;

  AddTestAction(this.test);
}

typedef EditTest2Callback = String Function(String test2);

class EditTest2Action {
  final String test2;

  EditTest2Action(this.test2);
}

class StoreTest3Action {
  final String test3;

  StoreTest3Action(this.test3);
}

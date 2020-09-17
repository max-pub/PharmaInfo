void main() {
  print(null ?? 3 ?? 4);
  Test t = Test()
    ..a = 8
    ..b = (Test2()..c = 15);
  print(t._a);
  print(t.b.c);
}

class Test {
  int _a = 5;
  Test2 b;

  set a(int v) {
    assert(v > 7);
    _a = v;
  }
}

class Test2 {
  int c = 11;
}

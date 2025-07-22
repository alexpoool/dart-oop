mixin Read {
  bool reading = false;

  void readObject() {
    reading = true;
  }

  void letReadObject() {
    reading = true;
  }

}
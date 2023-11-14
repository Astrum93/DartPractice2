extension ListExtension on List {
  void swap(int origin, int target) {
    final item2 = this[target];
    this[target] = this[origin];
    this[origin] = item2;
  }
}
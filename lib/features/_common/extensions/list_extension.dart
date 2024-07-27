extension ListExtension on List {
  /// Returns only [range] items from list
  ///
  /// If list is less than that returns list
  List<T> takeRange<T>(int range) {
    if (length < range) {
      return this as List<T>;
    }

    return getRange(0, range).toList() as List<T>;
  }
}

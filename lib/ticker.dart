class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 2), (x) => ticks - x - 1)
        .take(ticks);
  }

  Stream<int> reverseTick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 2), (x) => ticks + x + 1)
        .take(ticks);
  }
}

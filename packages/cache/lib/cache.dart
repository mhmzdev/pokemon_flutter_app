library cache;

class CacheClient {
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  void write<T extends Object>({String key, T value}) {
    _cache[key] = value;
  }

  T read<T extends Object>({String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}

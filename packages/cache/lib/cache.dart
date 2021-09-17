library cache;

// ignore: public_member_api_docs
class CacheClient {
  // ignore: public_member_api_docs
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  // ignore: public_member_api_docs
  void write<T extends Object>({String key, T value}) {
    _cache[key] = value;
  }

  // ignore: public_member_api_docs
  T read<T extends Object>({String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}

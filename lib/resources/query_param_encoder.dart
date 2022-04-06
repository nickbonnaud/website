class QueryParamEncoder {

  const QueryParamEncoder();

  String encode({required Map<String, String> params}) {
    return params.entries
      .map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}')
      .join('&');
  }
}
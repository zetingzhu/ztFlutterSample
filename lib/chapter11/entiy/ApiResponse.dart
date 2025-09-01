class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;

  ApiResponse({required this.code, required this.message, this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      code: json['code'] as int,
      message: json['message'] as String,
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : null,
    );
  }
}

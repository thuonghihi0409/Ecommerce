import 'package:equatable/equatable.dart';

class ListModel<T> extends Equatable {
  final int? count;

  final String? next;

  final String? previous;

  final List<T>? results;

  final String errorMessage;

  const ListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
    this.errorMessage = '',
  });

  factory ListModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic> json) convert,
      {Map<String, dynamic>? params}) {
    return ListModel(
      count: json['count'],
      next: json['next'] != null
          ? (json['next'] as String).replaceAll('http://', 'https://')
          : null,
      previous: json['previous'] != null
          ? (json['previous'] as String).replaceAll('http://', 'https://')
          : null,
      results: (json['results'] as List).map((e) => convert(e)).toList(),
      errorMessage: '',
    );
  }

  ListModel<T> copyWith({
    int? count,
    String? next,
    String? previous,
    List<T>? results,
    Map<String, dynamic>? params,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    String? errorMessage,
  }) {
    return ListModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [count, next, previous, results, errorMessage];
}

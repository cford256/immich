//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MemoriesApi {
  MemoriesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// This endpoint requires the `memoryAsset.create` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [BulkIdsDto] bulkIdsDto (required):
  Future<Response> addMemoryAssetsWithHttpInfo(String id, BulkIdsDto bulkIdsDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/memories/{id}/assets'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = bulkIdsDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `memoryAsset.create` permission.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [BulkIdsDto] bulkIdsDto (required):
  Future<List<BulkIdResponseDto>?> addMemoryAssets(String id, BulkIdsDto bulkIdsDto,) async {
    final response = await addMemoryAssetsWithHttpInfo(id, bulkIdsDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<BulkIdResponseDto>') as List)
        .cast<BulkIdResponseDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// This endpoint requires the `memory.create` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MemoryCreateDto] memoryCreateDto (required):
  Future<Response> createMemoryWithHttpInfo(MemoryCreateDto memoryCreateDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/memories';

    // ignore: prefer_final_locals
    Object? postBody = memoryCreateDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `memory.create` permission.
  ///
  /// Parameters:
  ///
  /// * [MemoryCreateDto] memoryCreateDto (required):
  Future<MemoryResponseDto?> createMemory(MemoryCreateDto memoryCreateDto,) async {
    final response = await createMemoryWithHttpInfo(memoryCreateDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MemoryResponseDto',) as MemoryResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `memory.delete` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteMemoryWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/memories/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `memory.delete` permission.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteMemory(String id,) async {
    final response = await deleteMemoryWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// This endpoint requires the `memory.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getMemoryWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/memories/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `memory.read` permission.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<MemoryResponseDto?> getMemory(String id,) async {
    final response = await getMemoryWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MemoryResponseDto',) as MemoryResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `memory.statistics` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DateTime] for_:
  ///
  /// * [bool] isSaved:
  ///
  /// * [bool] isTrashed:
  ///
  /// * [MemoryType] type:
  Future<Response> memoriesStatisticsWithHttpInfo({ DateTime? for_, bool? isSaved, bool? isTrashed, MemoryType? type, }) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/memories/statistics';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (for_ != null) {
      queryParams.addAll(_queryParams('', 'for', for_));
    }
    if (isSaved != null) {
      queryParams.addAll(_queryParams('', 'isSaved', isSaved));
    }
    if (isTrashed != null) {
      queryParams.addAll(_queryParams('', 'isTrashed', isTrashed));
    }
    if (type != null) {
      queryParams.addAll(_queryParams('', 'type', type));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `memory.statistics` permission.
  ///
  /// Parameters:
  ///
  /// * [DateTime] for_:
  ///
  /// * [bool] isSaved:
  ///
  /// * [bool] isTrashed:
  ///
  /// * [MemoryType] type:
  Future<MemoryStatisticsResponseDto?> memoriesStatistics({ DateTime? for_, bool? isSaved, bool? isTrashed, MemoryType? type, }) async {
    final response = await memoriesStatisticsWithHttpInfo( for_: for_, isSaved: isSaved, isTrashed: isTrashed, type: type, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MemoryStatisticsResponseDto',) as MemoryStatisticsResponseDto;
    
    }
    return null;
  }

  /// This endpoint requires the `memoryAsset.delete` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [BulkIdsDto] bulkIdsDto (required):
  Future<Response> removeMemoryAssetsWithHttpInfo(String id, BulkIdsDto bulkIdsDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/memories/{id}/assets'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = bulkIdsDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `memoryAsset.delete` permission.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [BulkIdsDto] bulkIdsDto (required):
  Future<List<BulkIdResponseDto>?> removeMemoryAssets(String id, BulkIdsDto bulkIdsDto,) async {
    final response = await removeMemoryAssetsWithHttpInfo(id, bulkIdsDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<BulkIdResponseDto>') as List)
        .cast<BulkIdResponseDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// This endpoint requires the `memory.read` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DateTime] for_:
  ///
  /// * [bool] isSaved:
  ///
  /// * [bool] isTrashed:
  ///
  /// * [MemoryType] type:
  Future<Response> searchMemoriesWithHttpInfo({ DateTime? for_, bool? isSaved, bool? isTrashed, MemoryType? type, }) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/memories';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (for_ != null) {
      queryParams.addAll(_queryParams('', 'for', for_));
    }
    if (isSaved != null) {
      queryParams.addAll(_queryParams('', 'isSaved', isSaved));
    }
    if (isTrashed != null) {
      queryParams.addAll(_queryParams('', 'isTrashed', isTrashed));
    }
    if (type != null) {
      queryParams.addAll(_queryParams('', 'type', type));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      apiPath,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `memory.read` permission.
  ///
  /// Parameters:
  ///
  /// * [DateTime] for_:
  ///
  /// * [bool] isSaved:
  ///
  /// * [bool] isTrashed:
  ///
  /// * [MemoryType] type:
  Future<List<MemoryResponseDto>?> searchMemories({ DateTime? for_, bool? isSaved, bool? isTrashed, MemoryType? type, }) async {
    final response = await searchMemoriesWithHttpInfo( for_: for_, isSaved: isSaved, isTrashed: isTrashed, type: type, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<MemoryResponseDto>') as List)
        .cast<MemoryResponseDto>()
        .toList(growable: false);

    }
    return null;
  }

  /// This endpoint requires the `memory.update` permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MemoryUpdateDto] memoryUpdateDto (required):
  Future<Response> updateMemoryWithHttpInfo(String id, MemoryUpdateDto memoryUpdateDto,) async {
    // ignore: prefer_const_declarations
    final apiPath = r'/memories/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = memoryUpdateDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      apiPath,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// This endpoint requires the `memory.update` permission.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MemoryUpdateDto] memoryUpdateDto (required):
  Future<MemoryResponseDto?> updateMemory(String id, MemoryUpdateDto memoryUpdateDto,) async {
    final response = await updateMemoryWithHttpInfo(id, memoryUpdateDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MemoryResponseDto',) as MemoryResponseDto;
    
    }
    return null;
  }
}

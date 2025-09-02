import 'dart:io';

import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel payload);
  Future<String> uploadBlogImage({
    required File file,
    required BlogModel payload,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel payload) async {
    try {
      final data = await supabaseClient
          .from('blogs')
          .insert(payload.toJson())
          .select();

      return BlogModel.fromJson(data.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File file,
    required BlogModel payload,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(payload.id, file);
      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(payload.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

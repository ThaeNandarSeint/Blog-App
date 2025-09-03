import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/interfaces/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, GetAllBlogsParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<AppFailure, List<Blog>>> call(GetAllBlogsParams params) async {
    return await blogRepository.getAllBlogs();
  }
}

class GetAllBlogsParams {}

import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog, required this.color});

  final Blog blog;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16).copyWith(bottom: 4),
      padding: const EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.topics
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            child: Chip(
                              label: Text(e),
                              padding: const EdgeInsets.all(5.0),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Text(
                blog.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text('${calculateReadingTime(blog.content)} min'),
        ],
      ),
    );
  }
}

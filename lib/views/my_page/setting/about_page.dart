import 'package:flutter/material.dart';
import 'package:yuyan_app/views/document_page/doc_detail_page.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DocDetailPage(
      bookId: 624070,
      slug: 'about',
    );
  }
}

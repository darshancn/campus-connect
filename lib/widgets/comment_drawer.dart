import 'package:flutter/material.dart';

class CommentDrawer extends StatefulWidget {
  const CommentDrawer({super.key});

  @override
  State<CommentDrawer> createState() => _CommentDrawerState();
}

class _CommentDrawerState extends State<CommentDrawer> {
  final List<Map<String, String>> _comments = [
    {
      "name": "Jane Doe",
      "profile": "assets/images/Ellipse_1.png",
      "comment": "I really appreciate the insights shared in this article!",
      "time": "5 min ago",
    },
    {
      "name": "Bạc Khương Đạo",
      "profile": "assets/images/Ellipse_2.png",
      "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "time": "5 min ago",
    },
  ];

  bool _hasMoreComments = true;

  void _loadMoreComments() {
    if (_hasMoreComments) {
      setState(() {
        _comments.addAll([
          {
            "name": "Alex Johnson",
            "profile": "assets/images/Ellipse_1.png",
            "comment": "Great discussion here! I love different viewpoints.",
            "time": "10 min ago",
          },
          {
            "name": "Sophia Tran",
            "profile": "assets/images/Ellipse_2.png",
            "comment": "This was such a helpful read. Thanks for sharing!",
            "time": "12 min ago",
          },
        ]);
        _hasMoreComments = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 12),
          Expanded(child: _buildCommentList()),
          if (_hasMoreComments) _buildLoadMoreButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Comments",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.red,
            child: Icon(Icons.close, size: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentList() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: _comments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final comment = _comments[index];
        return _buildCommentTile(
          name: comment["name"]!,
          profile: comment["profile"]!,
          commentText: comment["comment"]!,
          time: comment["time"]!,
        );
      },
    );
  }

  Widget _buildCommentTile({
    required String name,
    required String profile,
    required String commentText,
    required String time,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset(
                profile,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          commentText,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.black.withOpacity(0.6),
            height: 1.75,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          time,
          style: const TextStyle(
            fontFamily: 'Source Sans Pro',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0x66000000),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadMoreButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: GestureDetector(
        onTap: _loadMoreComments,
        child: Container(
          height: 42,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: const Text(
            "Load More",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

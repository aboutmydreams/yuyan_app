import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/net/api.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/model/dashboard/user_recent_seri.dart';
import 'package:yuyan_app/model/document/action.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/card/card_video_info_seri.dart';
import 'package:yuyan_app/model/document/card/vote_detail.dart';
import 'package:yuyan_app/model/document/commen/comment_detail.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/doc_detail/doc_detail.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/group_home/book_stack.dart';
import 'package:yuyan_app/model/document/group_home/group_home_seri.dart';
import 'package:yuyan_app/model/document/group_user.dart';
import 'package:yuyan_app/model/document/note/doclet.dart';
import 'package:yuyan_app/model/document/note/note.dart';
import 'package:yuyan_app/model/document/note/note_status.dart';
import 'package:yuyan_app/model/document/organization.dart';
import 'package:yuyan_app/model/document/organization_lite.dart';
import 'package:yuyan_app/model/document/toc/toc_seri.dart';
import 'package:yuyan_app/model/document/upload/upload_result_seri.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/document/user_profile.dart';
import 'package:yuyan_app/model/events/event_seri.dart';
import 'package:yuyan_app/model/events/user_event_seri.dart';
import 'package:yuyan_app/model/notification/notification.dart';
import 'package:yuyan_app/model/search/search_result_seri.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/model/topic/topic_detail_seri.dart';

class ApiRepository {
  static BaseApi api = BaseApi();

  static int get currentUserId => App.userProvider.data.id;

  static Future<Tuple2<List<EventSeri>, ApiResponse>> getAttendEvents(
      [int offset = 0]) async {
    var resp = await api.get('/events', queryParameters: {
      'offset': offset,
    });
    var asp = resp.data as ApiResponse;
    var data = (asp.data as List).map((e) => EventSeri.fromJson(e)).toList();
    return Tuple2.fromList([data, asp]);
  }

  static Future<List<DocSeri>> getExploreSelections([int limit = 4]) async {
    var resp = await api.get('/explore/selections?limit=$limit');
    var asp = resp.data as ApiResponse;
    var data = (asp.data as List).map((e) => DocSeri.fromJson(e)).toList();
    return data;
  }

  static Future<List<Serializer>> getExploreRecommends({
    int page = 0,
    int limit = 20,
    bool isDoc = false,
  }) async {
    if (isDoc) {
      var resp =
          await api.get('/explore/recommends?limit=$limit&page=$page&type=Doc');
      var asp = resp.data as ApiResponse;
      return (asp.data['docs'] as List)
          .map((e) => Serializer.fromJson(e))
          .toList();
    } else {
      List<Serializer> list = [];
      var resp = await api.get('/explore/recommends?limit=$limit');
      var asp = resp.data as ApiResponse;
      var data = asp.data;
      if (data['books'] != null) {
        list.addAll((data['books'] as List)
            .map((e) => Serializer.fromJson(e))
            .toList());
      }
      if (data['docs'] != null) {
        list.addAll(
            (data['docs'] as List).map((e) => Serializer.fromJson(e)).toList());
      }
      if (data['users'] != null) {
        list.addAll((data['users'] as List)
            .map((e) => Serializer.fromJson(e))
            .toList());
      }
      return list;
    }
  }

  static Future<bool> deleteRecentItem(int id) async {
    var res = await api.delete('/mine/recent/$id');
    return res.data.current;
  }

  static Future<DocletSeri> getUserReadme({int userId}) async {
    var res = await api.get('/users/$userId/readme');
    var asp = (res.data as ApiResponse);
    return DocletSeri.fromJson(asp.data['doclet']);
  }

  static Future<ApiResponse> getUserEvents({
    int userId,
    int limit = 20,
    int offset = 0,
  }) async {
    var res = await api.get(
      '/users/$userId/events',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );
    var data = (res.data as ApiResponse);
    return data;
  }

  static Future<List<UserRecentSeri>> getUserRecentList(
      {int limit = 100, int offset = 0}) async {
    var resp = await api.get(
      '/mine/recent_list',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    var asp = resp.data as ApiResponse;
    return (asp.data as List).map((e) => UserRecentSeri.fromJson(e)).toList();
  }

  static Future<List<QuickLinkSeri>> getUserQuickLinkList({
    String refId = 'quick_link',
  }) async {
    var resp = await api.get(
      '/quick_links',
      queryParameters: {
        'ref_id': refId,
      },
    );
    var asp = resp.data as ApiResponse;
    return (asp.data as List).map((e) => QuickLinkSeri.fromJson(e)).toList();
  }

  static Future<bool> putNotification({String ids = 'all'}) async {
    var asp = await api.put('/notifications', data: {'ids': ids});
    return (asp.data as ApiResponse).data['ok'];
  }

  static Future<NotificationSeri> getNotificationList(
      {String type = 'readed', int offset = 0, int limit = 100}) async {
    var resp = await api.get(
      '/notifications',
      queryParameters: {'type': type, 'offset': offset, 'limit': limit},
    );
    var asp = resp.data as ApiResponse;
    return NotificationSeri.fromJson(asp.data);
  }

  static Future<List<OrganizationSeri>> getMyOrganizationList() async {
    var resp = await api.get('/mine/organizations');
    var asp = resp.data as ApiResponse;
    var list =
        (asp.data as List).map((e) => OrganizationSeri.fromJson(e)).toList();
    return list;
  }

  static Future<List<OrganizationLiteSeri>> getOrganizationList(
      {int userId}) async {
    var resp = await api.get('/users/$userId/organizations');
    var asp = resp.data as ApiResponse;
    var list = (asp.data as List)
        .map((e) => OrganizationLiteSeri.fromJson(e))
        .toList();
    return list;
  }

  static Future<UserProfileSeri> getUserProfile({int userId}) async {
    userId ??= App.userProvider.data.id;
    var res = await api.get("/users/$userId/profile");
    var asp = (res.data as ApiResponse);
    return UserProfileSeri.fromJson(asp.data);
  }

  static Future<List<GroupSeri>> getGroupList({int userId}) async {
    userId ??= App.userProvider.data.id;
    var res = await api.get("/users/$userId/groups");
    var asp = (res.data as ApiResponse);
    var list = (asp.data as List).map((e) => GroupSeri.fromJson(e)).toList();
    return list;
  }

  static Future<List<GroupUserSeri>> getGroupMemberList({int groupId}) async {
    var res = await api.get("/groups/$groupId/users?with_count=true");
    var data = (res.data as ApiResponse).data as List;
    return data.map((e) => GroupUserSeri.fromJson(e)).toList();
  }

  static Future<BookStackSeri> getUserBookStack({int userId}) async {
    var res = await api.get('/users/$userId/book_stack');
    var data = (res.data as ApiResponse).data;
    return BookStackSeri.fromJson(data['stack']);
  }

  static Future<List<BookStackSeri>> getBookStack({int groupId}) async {
    var res = await api.get("/groups/$groupId/bookstacks");
    var asp = (res.data as ApiResponse).data;
    var list = (asp as List).map((e) => BookStackSeri.fromJson(e)).toList();
    return list;
  }

  static Future<Tuple2<List<GroupViewBlockSeri>, ApiResponse>> getGroupHome(
      {int groupId}) async {
    var res = await api.get(
      '/groups/$groupId/homepage',
      queryParameters: {'include_data': true},
    );
    var asp = (res.data as ApiResponse);
    //兼容version2版本！
    if (asp.data is Map) {
      //为了避免empty状态
      return Tuple2.fromList([
        [null],
        asp
      ]);
    }
    var list =
        (asp.data as List).map((e) => GroupViewBlockSeri.fromJson(e)).toList();
    return Tuple2.fromList([list, asp]);
  }

  //目前仅用于获取Group的动态
  static Future<Tuple2<List<UserEventSeri>, ApiResponse>> getViewBlocks({
    int blockId,
    int offset = 0,
  }) async {
    var resp = await api.get('/view_blocks/$blockId', queryParameters: {
      'offset': offset,
    });
    var asp = resp.data as ApiResponse;
    var data =
        (asp.data as List).map((e) => UserEventSeri.fromJson(e)).toList();
    return Tuple2.fromList([data, asp]);
  }

  static Future<List<BookSeri>> getOrgBookList({
    int orgId,
    int limit = 200,
  }) async {
    if (orgId == null) {
      orgId = App.currentSpaceProvider.data.id;
    }
    var res = await api.get(
      '/organizations/6005608/books',
      queryParameters: {
        'limit': limit,
      },
    );
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => BookSeri.fromJson(e)).toList();
    return list;
  }

  static Future<List<BookSeri>> getBookList({
    int userId,
    int limit = 200,
  }) async {
    var res = await api.get("/groups/$userId/books", queryParameters: {
      'archived': 'include',
      'limit': limit,
    });
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => BookSeri.fromJson(e)).toList();
    return list;
  }

  static Future<bool> getIfFollow({int userId}) async {
    var res = await api.get(
      "/actions/user-owned",
      queryParameters: {
        "action_type": "follow",
        "target_ids": userId,
        "target_type": "User",
      },
    );
    var asp = res.data as ApiResponse;
    return (asp.data as List).length > 0;
  }

  static Future<List<UserSeri>> getFollowingList({
    int userId,
    int offset = 0,
  }) async {
    // var res = await api.get(
    //   "/actions/targets",
    //   queryParameters: {
    //     "action_type": "follow",
    //     "target_type": "User",
    //     "user_id": userId,
    //     "offset": offset,
    //   },
    // );
    var res = await api.get(
      '/users/$userId/interperson',
      queryParameters: {
        'offset': offset,
        'type': 'following',
      },
    );
    var asp = res.data as ApiResponse;
    return (asp.data['data'] as List).map((e) => UserSeri.fromJson(e)).toList();
  }

  static Future<List<UserSeri>> getFollowerList({
    int userId,
    int offset = 0,
  }) async {
    // var res = await api.get(
    //   "/actions/users",
    //   queryParameters: {
    //     "action_type": "follow",
    //     "target_type": "User",
    //     "target_id": userId,
    //     "offset": offset,
    //   },
    // );
    var res = await api.get(
      '/users/$userId/interperson',
      queryParameters: {
        'offset': offset,
        'type': 'follower',
      },
    );
    var asp = res.data as ApiResponse;
    return (asp.data['data'] as List).map((e) => UserSeri.fromJson(e)).toList();
  }

  static Future<bool> followUser({int userId}) async {
    var res = await api.post("/actions", data: {
      "action_type": "follow",
      "target_type": "User",
      "target_id": userId,
    });
    var asp = res.data as ApiResponse;
    var data = ActionSeri.fromJson(asp.data);
    return data.targetId == userId;
  }

  static Future<bool> unfollowUser({int userId}) async {
    var res = await api.delete("/actions", data: {
      "action_type": "follow",
      "target_type": "User",
      "target_id": userId,
    });
    var asp = res.data as ApiResponse;
    return asp.data == null;
  }

  //我的关注知识库
  static Future<List<ActionSeri>> getFollowBookList({
    int limit = 100,
    int offset = 0,
  }) async {
    var res = await api.get(
      "/mine/follows",
      queryParameters: {
        "limit": limit,
        "offset": offset,
        "type": "Book",
      },
    );
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => ActionSeri.fromJson(e)).toList();
    return list;
  }

  // static Future getMyBooks({int limit, int offset}) async {
  //   var res = await api.get(
  //     "/mine/follows",
  //     queryParameters: {
  //       "limit": limit,
  //       "offset": offset,
  //       "type": "Book",
  //     },
  //   );
  // }

  // 查看是否收藏(文章或团队)
  static Future<bool> getIfMark({
    @required int targetId,
    String targetType = "Doc",
  }) async {
    var res = await api.get("/actions", queryParameters: {
      "action_type": "mark",
      "target_id": targetId,
      "target_type": targetType,
    }); // User or Doc
    var asp = res.data as ApiResponse;
    return asp.data['actioned'] != null;
  }

  static Future<bool> toggleMark({
    @required int targetId,
    String targetType,
    bool marked = false,
  }) {
    return marked
        ? unmark(targetId: targetId, targetType: targetType)
        : mark(targetId: targetId, targetType: targetType);
  }

  static Future<bool> mark({
    @required int targetId,
    String targetType = "Doc",
  }) async {
    var res = await api.post("/mine/marks", data: {
      // "action_type": "mark",
      "target_id": targetId,
      "target_type": targetType,
    }); // User or Doc
    var asp = res.data as ApiResponse;
    return asp.data['ok'] == 1;
  }

  static Future<bool> unmark({
    @required int targetId,
    String targetType = "Doc",
  }) async {
    var res = await api.delete("/mine/marks", data: {
      // "action_type": "mark",
      "target_id": targetId,
      "target_type": targetType,
    }); // User or Doc
    var asp = res.data as ApiResponse;
    return asp.data['ok'] == 1;
  }

  static Future<ActionSeri> doLike(
      {bool unlike = false, int target, String type = 'Doc'}) async {
    return _doAction(
      actionType: 'like',
      targetId: target,
      targetType: type,
      del: unlike,
    );
  }

  static Future<bool> getIfLike({
    int targetId,
    String targetType = 'Doc',
  }) async {
    var res = await _getAction(
      '',
      actionType: 'like',
      targetId: targetId,
      targetType: targetType,
    );
    return res.data['actioned'] != null;
  }

  static Future<ApiResponse> getLikeUsers({
    int targetId,
    String targetType = 'Doc',
  }) async {
    var res = await _getAction(
      'users',
      actionType: 'like',
      targetId: targetId,
      targetType: targetType,
    );
    return res;
  }

  static Future<ApiResponse> _getAction(
    String path, {
    String actionType = 'like',
    int targetId,
    String targetType,
    int limit = 20,
    int offset = 0,
  }) async {
    var res = await api.get('/actions/$path', queryParameters: {
      'action_type': actionType,
      'target_id': targetId,
      'target_type': targetType,
      'offset': offset,
      'limit': limit,
    });
    return res.data as ApiResponse;
  }

  static Future<ActionSeri> _doAction({
    // like, watch, follow, watch-comments, watch-topics, mark, read, reaction
    @required String actionType,
    @required int targetId,
    // Doc, Book, Artboard, ArtboardGroup,
    // ArtboardComment, Comment, Topic, User,
    // Resource, DocVersion, Quan, Note
    @required String targetType,
    bool del = false,
  }) async {
    var data = {
      "action_type": actionType,
      "target_id": targetId,
      "target_type": targetType,
    };
    var res = await (del
        ? api.delete('/actions', data: data)
        : api.post('/actions', data: data));
    var asp = res.data as ApiResponse;
    return ActionSeri.fromJson(asp.data);
  }

  static Future<List<ActionSeri>> getMarkList(
      {int offset = 0, int limit = 100}) async {
    var res = await api.get('/mine/marks', queryParameters: {
      'type': 'all',
      'offset': offset,
      'limit': limit,
    });
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => ActionSeri.fromJson(e)).toList();
    return list;
  }

  /// TOPIC [话题] 相关
  static Future<CommentDetailSeri> postComment({
    int commentId,
    String comment,
    int parentId,
    String commentType = 'Topic',
  }) async {
    var data = {
      "commentable_type": commentType,
      "commentable_id": commentId,
      "parent_id": parentId,
      "body_asl": "<!doctype lake><p>$comment</p>",
      "format": "lake"
    };
    var res = await api.post("/comments", data: data);
    var asp = (res.data as ApiResponse);
    return CommentDetailSeri.fromJson(asp.data);
  }

  static Future<CommentDetailSeri> deleteComment(int commentId) async {
    var res = await api.delete("/comments/$commentId");
    var asp = (res.data as ApiResponse);
    return CommentDetailSeri.fromJson(asp.data);
  }

  static Future<TopicDetailSeri> addTopic({
    String title,
    String body,
    int groupId,
  }) async {
    Map<String, dynamic> data = {
      "group_id": groupId,
      "title": title,
      "body_asl": body,
      "assignee_id": null,
      "format": "lake",
      "public": 1,
      "milestone_id": null,
      "uuid": null,
    };
    var res = await api.post('/topics', data: data);
    var asp = (res.data as ApiResponse).data;
    return TopicDetailSeri.fromJson(asp);
  }

  static Future<TopicDetailSeri> getTopicDetail({int iid, int groupId}) async {
    var res = await api.get('/topics/$iid', queryParameters: {
      'group_id': groupId,
    });
    var asp = (res.data as ApiResponse);
    return TopicDetailSeri.fromJson(asp.data);
  }

  static Future<List<CommentDetailSeri>> getCommentsList({
    int commentId,
    //comment_type => 要求是 Doc, Topic, ArtboardComment, Resource, DocVersion, Note 其中的一个
    String commentType = 'Topic',
  }) async {
    var res = await getComments(commentId: commentId, commentType: commentType);
    var data = res.data as List;
    return data.map((e) => CommentDetailSeri.fromJson(e)).toList();
  }

  static Future<ApiResponse> getComments({
    int commentId,
    //comment_type => 要求是 Doc, Topic, ArtboardComment, Resource, DocVersion, Note 其中的一个
    String commentType = 'Topic',
  }) async {
    var res = await api.get('/comments', queryParameters: {
      'commentable_id': commentId,
      'commentable_type': commentType,
      'include_section': true,
    });
    var data = (res.data as ApiResponse);
    return data;
  }

  static Future<List<TopicSeri>> getTopicList({
    int groupId,
    int offset = 0,
    String state = 'open',
    int limit = 100,
  }) async {
    var res = await api.get(
      '/topics',
      queryParameters: {
        'limit': limit,
        'offset': offset,
        'state': state,
        'assignee_id': '',
        'group_id': groupId,
        'kanban_id': '',
        'label_ids': '',
        'milestone_id': '',
        'mode': '',
        'privacy': '',
        'q': '',
        'user_id': '',
      },
    );
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => TopicSeri.fromJson(e)).toList();
    return list;
  }

  static Future<List<TopicSeri>> getMyTopics({
    String type = 'participated', // created, participated, assigned, commented
    String state = 'open', // open, closed
    int limit = 100,
    int offset = 0,
  }) async {
    var res = await api.get(
      '/mine/topics',
      queryParameters: {
        'limit': limit,
        'offset': offset,
        'state': state,
        'type': type,
      },
    );
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => TopicSeri.fromJson(e)).toList();
    return list;
  }

  ///语雀小记
  static Future<bool> deleteNote(int id) async {
    var res = await api.delete('/notes/$id');
    var asp = (res.data as ApiResponse);
    return asp.data;
  }

  static Future<String> convertLake({
    String markdown,
  }) async {
    var res = await api.post(
      '/docs/convert',
      data: {
        'from': 'markdown',
        'to': 'lake',
        'content': markdown,
        'ctoken': App.tokenProvider.data.cToken,
      },
      options: Options(headers: {
        'referer': 'https://www.yuque.com/dashboard/notes',
      }),
    );
    var asp = (res.data as ApiResponse);
    return asp.data['content'];
  }

  static Future<NoteSeri> postNote({
    String html,
    int id = 0,
    String type = 'all',
  }) async {
    var res = await api.put(
      '/notes/$id',
      data: {
        "body_asl": html,
        "body_html": html,
        "description": html,
        "has_attachment": false,
        "has_bookmark": false,
        "has_image": html.contains('name="image"'),
        "has_todo": html.contains('name="checkbox"'),
        "save_type": "user"
      },
    );
    var asp = (res.data as ApiResponse);
    return NoteSeri.fromJson(asp.data);
  }

  static Future<List<NoteSeri>> getMyNoteList({
    String text = '',
    String type = 'all',
    int offset = 0,
  }) async {
    var res = await api.get(
      '/notes',
      queryParameters: {
        'filter_type': type,
        'offset': offset,
        'q': text,
      },
    );
    var asp = (res.data as ApiResponse).data as List;
    return asp.map((e) => NoteSeri.fromJson(e)).toList();
  }

  static Future<NoteSeri> getNoteDetail({
    int noteId,
  }) async {
    var res = await api.get('/notes/$noteId');
    var asp = (res.data as ApiResponse);
    return NoteSeri.fromJson(asp.data);
  }

  static Future<NoteStatusSeri> getNoteStatus() async {
    var res = await api.get('/notes/status');
    var asp = (res.data as ApiResponse);
    return NoteStatusSeri.fromJson(asp.raw);
  }

  static Future<UploadResultSeri> postAttachFile({
    String path, //文件路径
    String attachableType,
    int attachableId, //讨论区=>groupId, 小记=>noteId
    String type = 'image', //一般情况下都是image
    // String attachUuid = '',
    ProgressCallback progressCallback, //进度回调函数
  }) async {
    /// attachableType: Doclet: 小记 doc: 文档; 讨论区-> User,
    var name = path.substring(path.lastIndexOf('/') + 1);
    Map<String, dynamic> query = {
      "type": type,
      "ctoken": App.tokenProvider.data.cToken,
      "attachable_id": attachableId,
      "attachable_type": attachableType,
    };
    var image = await MultipartFile.fromFile(path, filename: name);
    FormData formData = FormData.fromMap({"file": image});
    var res = await api.post(
      '/upload/attach',
      queryParameters: query,
      data: formData,
      onSendProgress: progressCallback,
      options: Options(
        headers: {
          'Referer': 'https://www.yuque.com/api/upload/attach',
        },
      ),
    );
    var asp = (res.data as ApiResponse);
    return UploadResultSeri.fromJson(asp.data);
  }

  ///文档
  static Future<List<TocSeri>> getBookTocList({int bookId}) async {
    var res = await api.get(
      '/catalog_nodes',
      queryParameters: {'book_id': bookId},
    );
    var asp = (res.data as ApiResponse);
    var list = (asp.data as List).map((e) => TocSeri.fromJson(e)).toList();
    return list;
  }

  static Future<DocDetailSeri> getDocDetail({int bookId, String slug}) async {
    var res = await api.get('/docs/$slug', queryParameters: {
      'book_id': bookId,
      // in order to obtain additional information
      'include_contributors': true,
      'include_hits': true,
      'include_like': true,
      'include_pager': true,
      'include_suggests': true,
    });
    var asp = (res.data as ApiResponse);
    return DocDetailSeri.fromJson(asp.data);
  }

  static Future<List<DocSeri>> getBookDocList({int bookId}) async {
    var res = await api.get('/books/$bookId/docs', queryParameters: {
      'include_contributors': true,
      'include_hits': true,
      'limit': 200,
      'offset': 0,
    });
    var asp = (res.data as ApiResponse).data as List;
    return asp.map((e) => DocSeri.fromJson(e)).toList();
  }

  //视频
  static Future<CardVideoResSeri> getCardVideo({String videoId}) async {
    var res = await api.get('/video', queryParameters: {
      'video_id': videoId,
      'ctoken': App.tokenProvider.data.cToken,
    });
    return CardVideoResSeri.fromJson(res.data.current);
  }

  //投票
  static Future<VoteDetailSeri> getVoteDetail({
    int docId,
    String voteId,
    List<String> items,
    String deadline,
  }) async {
    var res = await api.get(
      '/votes',
      queryParameters: {
        'doc_id': docId,
        'vote_id': voteId,
        'deadline': deadline, //iso标准
        'items': items.join(','), //列表，逗号分割
        'ctoken': App.tokenProvider.data.cToken,
      },
    );
    var data = (res.data as ApiResponse);
    return VoteDetailSeri.fromJson(data.data);
  }

  static Future<String> decryptText({String pwd, String text}) async {
    var res = await api.post(
      '/services/crypto',
      data: {
        'pwd': pwd,
        'text': text,
        'action': 'decrypt',
        'ctoken': App.tokenProvider.data.cToken,
      },
    );
    var asp = (res.data as ApiResponse);
    return asp.data;
  }

  //# 搜索相关
  static Future<SearchResultSeri> search({
    String query = '',
    //topic, book, doc, artboard, group, user, attachment, resource, note, content, edison
    String type = 'doc',
    int page = 1,
    bool relateMe = false,
  }) async {
    var res = await api.get(
      '/zsearch',
      queryParameters: {
        'q': query,
        'p': page,
        'type': type,
        if (relateMe) 'related': relateMe,
      },
    );
    var asp = (res.data as ApiResponse);
    return SearchResultSeri.fromJson(asp.data);
  }

  static Future<bool> reportContent({
    String reportType = '0902',
    // 0902 => 色情淫秽
    // 0903 => 反社会、暴力
    // 0904 => 其它(毒品、借贷、枪支等),
    @required String reason,
    int targetId,
    String targetType = 'Doc',
    String url,
  }) async {
    var data = {
      'meta': {
        'reason': reason,
        'referer_url': url,
      },
      'report_type': reportType,
      'target_id': targetId,
      'target_type': targetType,
    };
    var res = await api.post('content_reports', data: data);
    return res.data != null ? true : false;
  }
}

import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/join_token.dart';
import 'package:yuyan_app/model/user/user_lite_seri.dart';

import '../../user/user.dart';
import 'pager.dart';

class DocDetailSeri {
  int id;
  int spaceId;
  String type;
  dynamic subType;
  String title;
  dynamic tag;
  String slug;
  int userId;
  int bookId;
  String cover;
  String description;
  dynamic customDescription;
  String bodyAsl;
  String format;
  int status;
  int readStatus;
  int viewStatus;
  int public;
  int draftVersion;
  int commentsCount;
  int likesCount;

  // Abilities abilities;
  String contentUpdatedAt;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String firstPublishedAt;
  dynamic pinnedAt;
  int wordCount;
  String content;
  bool contentModified;
  dynamic selectedAt;
  dynamic premiumDaysCount;
  dynamic premiumPrice;
  dynamic premiumStartedAt;
  dynamic premiumExpiredAt;
  String editorMeta;
  String editorMetaDraft;

  // Meta meta;
  dynamic premiumPaidUserCount;
  dynamic premiumIncome;

  // Like like;
  int hits;
  bool marked;
  UserSeri user;
  UserSeri lastEditor;
  JoinTokenSeri joinToken;
  List<DocSeri> suggests;
  List<UserLiteSeri> contributors;
  PagerSeri pager;
  String serializer;

  DocDetailSeri(
      {this.id,
      this.spaceId,
      this.type,
      this.subType,
      this.title,
      this.tag,
      this.slug,
      this.userId,
      this.bookId,
      this.cover,
      this.description,
      this.customDescription,
      this.bodyAsl,
      this.format,
      this.status,
      this.readStatus,
      this.viewStatus,
      this.public,
      this.draftVersion,
      this.commentsCount,
      this.likesCount,
      // this.abilities,
      this.contentUpdatedAt,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.firstPublishedAt,
      this.pinnedAt,
      this.wordCount,
      this.content,
      this.contentModified,
      this.selectedAt,
      this.premiumDaysCount,
      this.premiumPrice,
      this.premiumStartedAt,
      this.premiumExpiredAt,
      this.editorMeta,
      this.editorMetaDraft,
      // this.meta,
      this.premiumPaidUserCount,
      this.premiumIncome,
      // this.like,
      this.hits,
      this.marked,
      this.user,
      this.lastEditor,
      this.joinToken,
      this.suggests,
      this.contributors,
      this.pager,
      this.serializer});

  DocDetailSeri.fromJson(dynamic json) {
    id = json["id"];
    spaceId = json["space_id"];
    type = json["type"];
    subType = json["sub_type"];
    title = json["title"];
    tag = json["tag"];
    slug = json["slug"];
    userId = json["user_id"];
    bookId = json["book_id"];
    cover = json["cover"];
    description = json["description"];
    customDescription = json["custom_description"];
    bodyAsl = json["body_asl"];
    format = json["format"];
    status = json["status"];
    readStatus = json["read_status"];
    viewStatus = json["view_status"];
    public = json["public"];
    draftVersion = json["draft_version"];
    commentsCount = json["comments_count"];
    likesCount = json["likes_count"];
    // abilities = json["abilities"] != null
    //     ? Abilities.fromJson(json["abilities"])
    //     : null;
    contentUpdatedAt = json["content_updated_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    publishedAt = json["published_at"];
    firstPublishedAt = json["first_published_at"];
    pinnedAt = json["pinned_at"];
    wordCount = json["word_count"];
    content = json["content"];
    contentModified = json["content_modified"];
    selectedAt = json["selected_at"];
    premiumDaysCount = json["premium_days_count"];
    premiumPrice = json["premium_price"];
    premiumStartedAt = json["premium_started_at"];
    premiumExpiredAt = json["premium_expired_at"];
    editorMeta = json["editor_meta"];
    editorMetaDraft = json["editor_meta_draft"];
    // meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
    premiumPaidUserCount = json["premium_paid_user_count"];
    premiumIncome = json["premium_income"];
    // like = json["like"] != null ? Like.fromJson(json["like"]) : null;
    hits = json["hits"];
    marked = json["marked"];
    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    lastEditor = json["last_editor"] != null
        ? UserSeri.fromJson(json["last_editor"])
        : null;
    joinToken = json["joinToken"] != null
        ? JoinTokenSeri.fromJson(json["joinToken"])
        : null;
    if (json["suggests"] != null) {
      suggests = [];
      json["suggests"].forEach((v) {
        suggests.add(DocSeri.fromJson(v));
      });
    }
    if (json["contributors"] != null) {
      contributors = [];
      json["contributors"].forEach((v) {
        contributors.add(UserLiteSeri.fromJson(v));
      });
    }
    pager = json["pager"] != null ? PagerSeri.fromJson(json["pager"]) : null;
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["space_id"] = spaceId;
    map["type"] = type;
    map["sub_type"] = subType;
    map["title"] = title;
    map["tag"] = tag;
    map["slug"] = slug;
    map["user_id"] = userId;
    map["book_id"] = bookId;
    map["cover"] = cover;
    map["description"] = description;
    map["custom_description"] = customDescription;
    map["body_asl"] = bodyAsl;
    map["format"] = format;
    map["status"] = status;
    map["read_status"] = readStatus;
    map["view_status"] = viewStatus;
    map["public"] = public;
    map["draft_version"] = draftVersion;
    map["comments_count"] = commentsCount;
    map["likes_count"] = likesCount;
    // if (abilities != null) {
    //   map["abilities"] = abilities.toJson();
    // }
    map["content_updated_at"] = contentUpdatedAt;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["published_at"] = publishedAt;
    map["first_published_at"] = firstPublishedAt;
    map["pinned_at"] = pinnedAt;
    map["word_count"] = wordCount;
    map["content"] = content;
    map["content_modified"] = contentModified;
    map["selected_at"] = selectedAt;
    map["premium_days_count"] = premiumDaysCount;
    map["premium_price"] = premiumPrice;
    map["premium_started_at"] = premiumStartedAt;
    map["premium_expired_at"] = premiumExpiredAt;
    map["editor_meta"] = editorMeta;
    map["editor_meta_draft"] = editorMetaDraft;
    // if (meta != null) {
    //   map["meta"] = meta.toJson();
    // }
    map["premium_paid_user_count"] = premiumPaidUserCount;
    map["premium_income"] = premiumIncome;
    // if (like != null) {
    //   map["like"] = like.toJson();
    // }
    map["hits"] = hits;
    map["marked"] = marked;
    if (user != null) {
      map["user"] = user.toJson();
    }
    if (lastEditor != null) {
      map["last_editor"] = lastEditor.toJson();
    }
    if (joinToken != null) {
      map["joinToken"] = joinToken.toJson();
    }
    if (suggests != null) {
      map["suggests"] = suggests.map((v) => v.toJson()).toList();
    }
    if (contributors != null) {
      map["contributors"] = contributors.map((v) => v.toJson()).toList();
    }
    if (pager != null) {
      map["pager"] = pager.toJson();
    }
    map["_serializer"] = serializer;
    return map;
  }
}

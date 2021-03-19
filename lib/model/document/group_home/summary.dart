class SummarySeri {
  String contentUpdatedAt;
  String body;
  String bodyAsl;
  String bodyDraft;
  String bodyDraftAsl;
  String premiumBody;
  String premiumBodyAsl;
  String premiumBodyDraft;
  String premiumBodyDraftAsl;
  bool isSuspect;
  String fullBody;
  String fullBodyAsl;
  String fullBodyDraft;
  String fullBodyDraftAsl;
  String editorMeta;
  String editorMetaDraft;
  int id;
  int spaceId;
  String type;
  dynamic subType;
  String slug;
  int bookId;
  int userId;
  String title;
  dynamic tag;
  String cover;
  String description;
  String customDescription;
  dynamic titleDraft;
  String format;
  int status;
  int readStatus;
  int viewStatus;
  int public;
  int commentsCount;
  int likesCount;
  int collaborationCount;
  int lastEditorId;
  int draftVersion;
  dynamic deletedSlug;
  int wordCount;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String firstPublishedAt;
  dynamic selectedAt;
  dynamic pinnedAt;
  dynamic premiumDaysCount;
  dynamic premiumPrice;
  dynamic premiumStartedAt;
  dynamic premiumExpiredAt;
  String docMeta;
  String docMetaDraft;
  dynamic deletedAt;

  /// 画板summary
  int artboardGroupId;
  dynamic assetId;
  dynamic assetVersionId;
  String md5;
  String uuid;
  int sort;
  String image;
  dynamic smallImage;
  dynamic labelMapUrl;
  String name;
  int width;
  int height;

  SummarySeri({
    this.contentUpdatedAt,
    this.body,
    this.bodyAsl,
    this.bodyDraft,
    this.bodyDraftAsl,
    this.premiumBody,
    this.premiumBodyAsl,
    this.premiumBodyDraft,
    this.premiumBodyDraftAsl,
    this.isSuspect,
    this.fullBody,
    this.fullBodyAsl,
    this.fullBodyDraft,
    this.fullBodyDraftAsl,
    this.editorMeta,
    this.editorMetaDraft,
    this.id,
    this.spaceId,
    this.type,
    this.subType,
    this.slug,
    this.bookId,
    this.userId,
    this.title,
    this.tag,
    this.cover,
    this.description,
    this.customDescription,
    this.titleDraft,
    this.format,
    this.status,
    this.readStatus,
    this.viewStatus,
    this.public,
    this.commentsCount,
    this.likesCount,
    this.collaborationCount,
    this.lastEditorId,
    this.draftVersion,
    this.deletedSlug,
    this.wordCount,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.firstPublishedAt,
    this.selectedAt,
    this.pinnedAt,
    this.premiumDaysCount,
    this.premiumPrice,
    this.premiumStartedAt,
    this.premiumExpiredAt,
    this.docMeta,
    this.docMetaDraft,
    this.deletedAt,

    /// 画板summary
    this.artboardGroupId,
    this.assetId,
    this.assetVersionId,
    this.md5,
    this.uuid,
    this.sort,
    this.image,
    this.smallImage,
    this.labelMapUrl,
    this.name,
    this.width,
    this.height,
  });

  SummarySeri.fromJson(dynamic json) {
    // meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
    contentUpdatedAt = json["content_updated_at"];
    body = json["body"];
    bodyAsl = json["body_asl"];
    bodyDraft = json["body_draft"];
    bodyDraftAsl = json["body_draft_asl"];
    premiumBody = json["premium_body"];
    premiumBodyAsl = json["premium_body_asl"];
    premiumBodyDraft = json["premium_body_draft"];
    premiumBodyDraftAsl = json["premium_body_draft_asl"];
    isSuspect = json["isSuspect"];
    fullBody = json["full_body"];
    fullBodyAsl = json["full_body_asl"];
    fullBodyDraft = json["full_body_draft"];
    fullBodyDraftAsl = json["full_body_draft_asl"];
    editorMeta = json["editor_meta"];
    editorMetaDraft = json["editor_meta_draft"];
    id = json["id"];
    spaceId = json["space_id"];
    type = json["type"];
    subType = json["sub_type"];
    slug = json["slug"];
    bookId = json["book_id"];
    userId = json["user_id"];
    title = json["title"];
    tag = json["tag"];
    cover = json["cover"];
    description = json["description"];
    customDescription = json["custom_description"];
    titleDraft = json["title_draft"];
    format = json["format"];
    status = json["status"];
    readStatus = json["read_status"];
    viewStatus = json["view_status"];
    public = json["public"];
    commentsCount = json["comments_count"];
    likesCount = json["likes_count"];
    collaborationCount = json["collaboration_count"];
    lastEditorId = json["last_editor_id"];
    draftVersion = json["draft_version"];
    deletedSlug = json["deleted_slug"];
    wordCount = json["word_count"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    publishedAt = json["published_at"];
    firstPublishedAt = json["first_published_at"];
    selectedAt = json["selected_at"];
    pinnedAt = json["pinned_at"];
    premiumDaysCount = json["premium_days_count"];
    premiumPrice = json["premium_price"];
    premiumStartedAt = json["premium_started_at"];
    premiumExpiredAt = json["premium_expired_at"];
    docMeta = json["doc_meta"];
    docMetaDraft = json["doc_meta_draft"];
    deletedAt = json["deleted_at"];

    //画板summary
    artboardGroupId = json["artboard_group_id"];
    assetId = json["asset_id"];
    assetVersionId = json["asset_version_id"];
    md5 = json["md5"];
    uuid = json["uuid"];
    sort = json["sort"];
    image = json["image"];
    smallImage = json["small_image"];
    labelMapUrl = json["label_map_url"];
    name = json["name"];
    width = json["width"];
    height = json["height"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["content_updated_at"] = contentUpdatedAt;
    map["body"] = body;
    map["body_asl"] = bodyAsl;
    map["body_draft"] = bodyDraft;
    map["body_draft_asl"] = bodyDraftAsl;
    map["premium_body"] = premiumBody;
    map["premium_body_asl"] = premiumBodyAsl;
    map["premium_body_draft"] = premiumBodyDraft;
    map["premium_body_draft_asl"] = premiumBodyDraftAsl;
    map["isSuspect"] = isSuspect;
    map["full_body"] = fullBody;
    map["full_body_asl"] = fullBodyAsl;
    map["full_body_draft"] = fullBodyDraft;
    map["full_body_draft_asl"] = fullBodyDraftAsl;
    map["editor_meta"] = editorMeta;
    map["editor_meta_draft"] = editorMetaDraft;
    map["id"] = id;
    map["space_id"] = spaceId;
    map["type"] = type;
    map["sub_type"] = subType;
    map["slug"] = slug;
    map["book_id"] = bookId;
    map["user_id"] = userId;
    map["title"] = title;
    map["tag"] = tag;
    map["cover"] = cover;
    map["description"] = description;
    map["custom_description"] = customDescription;
    map["title_draft"] = titleDraft;
    map["format"] = format;
    map["status"] = status;
    map["read_status"] = readStatus;
    map["view_status"] = viewStatus;
    map["public"] = public;
    map["comments_count"] = commentsCount;
    map["likes_count"] = likesCount;
    map["collaboration_count"] = collaborationCount;
    map["last_editor_id"] = lastEditorId;
    map["draft_version"] = draftVersion;
    map["deleted_slug"] = deletedSlug;
    map["word_count"] = wordCount;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["published_at"] = publishedAt;
    map["first_published_at"] = firstPublishedAt;
    map["selected_at"] = selectedAt;
    map["pinned_at"] = pinnedAt;
    map["premium_days_count"] = premiumDaysCount;
    map["premium_price"] = premiumPrice;
    map["premium_started_at"] = premiumStartedAt;
    map["premium_expired_at"] = premiumExpiredAt;
    map["doc_meta"] = docMeta;
    map["doc_meta_draft"] = docMetaDraft;
    map["deleted_at"] = deletedAt;

    ///画板summary
    map["artboard_group_id"] = artboardGroupId;
    map["asset_id"] = assetId;
    map["asset_version_id"] = assetVersionId;
    map["md5"] = md5;
    map["uuid"] = uuid;
    map["sort"] = sort;
    map["image"] = image;
    map["small_image"] = smallImage;
    map["label_map_url"] = labelMapUrl;
    map["name"] = name;
    map["width"] = width;
    map["height"] = height;
    return map;
  }
}

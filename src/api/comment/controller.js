const jwt = require('jsonwebtoken');
const  {commentCreate, commentShow, commentUpdate, commentDelete, commentInfo, MaxSort, MaxCmtgroup} = require('./query');

// 댓글 작성
exports.store = async (ctx, next) => {
    let user = ctx.request.user;
    let feed_id = ctx.params.id;
    let { content } = ctx.request.body;
    let sort = 0;
    let cmtgroup = 0;
    let query = await MaxCmtgroup();
    (query == null) ? cmtgroup = 1 : cmtgroup = cmtgroup+1;

    let result = await commentCreate(user.id, feed_id, content, sort, cmtgroup);
    if(result == null){
        ctx.body = {result: "ok"};
    } else {
        ctx.body = {result: "fail"};
    }
}

// 대댓글 작성
exports.orderStore = async (ctx, next) => {
    let user = ctx.request.user;
    let feed_id = ctx.params.id;
    let { content } = ctx.request.body;
    let comment_id = ctx.params.comment_id;
    let query = commentInfo(comment_id);
    let cmtgroup = query.cmtgroup;
    query = MaxSort(query.cmtgroup);
    let sort = query.sort;

    let result = await commentCreate(user.id, feed_id, content, sort, cmtgroup);
    if(result == null){
        ctx.body = {result: "ok"};
    } else {
        ctx.body = {result: "fail"};
    }
}

// 피드의 댓글 전체 보기
exports.show = async (ctx, next) => {
    let feed_id = ctx.params.id;
    let user = ctx.request.user;
    let query = commentShow(feed_id);
    query['is_me'] = (user.id === query.user_id);
    ctx.body = query;
}

// 댓글 수정
exports.update = async (ctx, next) =>{
    let user = ctx.request.user;

    // 댓글의 id로 댓글 작성자의 id를 구함
    let comment_id = ctx.params.comment_id;
    let query = await commentInfo(comment_id);

    if(user.id == query.user_id){
        let { content } = ctx.request.body;
        let result = await commentUpdate(comment_id, content);
        if(result == null){
            ctx.body = {result: "fail"};
        } else {
            ctx.body = {result: "ok"};
        }
    }
}

// 댓글 삭제
exports.delete = async (ctx, next) => {
    let user = ctx.request.user;

    // 댓글의 id로 댓글 작성자의 id를 구함
    let comment_id = ctx.params.comment_id;
    let query = await commentInfo(comment_id);

    if(user.id == query.user_id){
        let result = await commentDelete(comment_id);
        if(result == null){
            ctx.body = {result: "fail"};
        } else {
            ctx.body = {result: "ok"};
        }
    }
}
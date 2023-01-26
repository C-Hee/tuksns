const jwt = require('jsonwebtoken');
const  {commentCreate, commentShow, commentUpdate, commentDelete, commentInfo, MaxSort, MaxCmtgroup} = require('./query');

// 피드의 댓글 전체 보기
exports.show = async (ctx, next) => {
    let feed_id = ctx.params.id;
    let user = ctx.request.user;
    let query = commentShow(feed_id);

    if (Object.entries(query).length !== 0){
        if (user == null){
            query['is_me'] = false;
        } else {
            query['is_me'] = (user.id === query.user_id); // 내 글 조회 -> 내 글이면 true
        }
    }
    ctx.body = query;
}

// // 댓글 작성 대댓글 존재
// exports.store = async (ctx, next) => {
//     let user = ctx.request.user;
//     let feed_id = ctx.params.id;
//     let { content } = ctx.request.body;
//     let sort = 0;
//     let cmtgroup = 0;
//     let query = await MaxCmtgroup();
//     (query == null) ? cmtgroup = 1 : cmtgroup = cmtgroup+1;

//     let result = await commentCreate(user.id, feed_id, content, sort, cmtgroup);
//     if(result == null){
//         ctx.body = {result: "success"};
//     } else {
//         ctx.body = {result: "fail"};
//     }
// }

// 댓글 작성 대댓글 없음
exports.store = async (ctx, next) => {
    let user = ctx.request.user;
    let feed_id = ctx.params.id;
    let { content } = ctx.request.body;

    let result = await commentCreate(user.id, user.name, feed_id, content);
    if(result.affectedRows > 0) {
        ctx.body = { result: "succes", id: result.insertId }
    } else {
        ctx.body = { result: "fail", }
    }
}

// 댓글 수정
exports.update = async (ctx, next) =>{
    let comment_id = ctx.params.comment_id;

    let { content } = ctx.request.body;
    let result = await commentUpdate(comment_id, content);
    if(result.affectedRows > 0) {
        ctx.body = { result: "succes", id: comment_id }
    } else {
        ctx.body = { result: "fail", }
    }
    
}

// 댓글 삭제
exports.delete = async (ctx, next) => {
    let comment_id = ctx.params.comment_id;

    let result = await commentDelete(comment_id);
    if(result.affectedRows > 0) {
        ctx.body = { result: "succes", id: comment_id }
    } else {
        ctx.body = { result: "fail", }
    }
}

// // 대댓글 작성
// exports.orderStore = async (ctx, next) => {
//     let user = ctx.request.user;
//     let feed_id = ctx.params.id;
//     let { content } = ctx.request.body;

//     let comment_id = ctx.params.comment_id;
//     let query = commentInfo(comment_id);
//     let cmtgroup = query.cmtgroup;
//     query = MaxSort(query.cmtgroup);
//     let sort = query.sort + 1;

//     let result = await commentCreate(user.id, user.name, feed_id, content, sort, cmtgroup);
//     if(result == null){
//         ctx.body = {result: "success"};
//     } else {
//         ctx.body = {result: "fail"};
//     }
// }

// // 대댓글 수정
// exports.orderUpdate = async (ctx, next) =>{
//     let ordercomment_id = ctx.params.ordercomment_id;

//     let { content } = ctx.request.body;
//     let result = await commentUpdate(ordercomment_id, content);
//     if(result == null){
//         ctx.body = {result: "fail"};
//     } else {
//         ctx.body = {result: "success"};
//     }
    
// }

// // 대댓글 삭제
// exports.orderDelete = async (ctx, next) => {
//     let ordercomment_id = ctx.params.ordercomment_id;

//     let result = await commentDelete(ordercomment_id);
//     if(result == null){
//         ctx.body = {result: "fail"};
//     } else {
//         ctx.body = {result: "success"};
//     }
// }
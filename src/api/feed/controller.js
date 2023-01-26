const jwt = require('jsonwebtoken');
const { feedFullView, feedTypeView, feedCreate, feedShow,feedUpdate, feedDelete, findIdName, findFeedUser} = require('./query');
const { dateFromNow, isNewFeed } = require('../../common/formatter/date');

// 전체 피드 보기
exports.index = async (ctx, next) => {
    let query = await feedFullView();

    for (var i = 0; i < query.length; i++){
        query[i]['dateNow'] = await dateFromNow(query[i].created_at);
        query[i]['newFeed'] = await isNewFeed(query[i].created_at);
    }

    ctx.body = query;
}

// 주제별 피드 보기
exports.typeIndex = async (ctx, next) => {
    let feed_type = ctx.params.type;
    let query = await feedTypeView(feed_type);

    for (var i = 0; i < query.length; i++){
        query[i]['dateNow'] = await dateFromNow(query[i].created_at);
        query[i]['newFeed'] = await isNewFeed(query[i].created_at);
    }

    ctx.body = query;
}

// 새 피드 작성 처리
exports.store = async (ctx, next) => {
    let user = ctx.request.user;

    let feed_type = ctx.params.type;
    let { title, image_id, content } = ctx.request.body;

    let result = await feedCreate(feed_type, user.id, user.name, title, content, image_id);
    if(result.affectedRows > 0) {
        ctx.body = { result: "succes", id: result.insertId }
    } else {
        ctx.body = { result: "fail", }
    }
}

// 피드 상세보기
exports.show = async (ctx, next) => {
    let feed_id = ctx.params.id;
    let user = ctx.request.user;
    
    let query = await feedShow(feed_id);
    query['is_me'] = (user.id === query.user_id); // 내 글 조회 -> 내 글이면
    query['dateNow'] = await dateFromNow(query.created_at);
    query['newFeed'] = await isNewFeed(query.created_at);

    ctx.body = query;
}

// 피드 수정
exports.update = async (ctx, next) =>{
    let feed_id = ctx.params.id;

    let { title, content } = ctx.request.body;
    let result = await feedUpdate(feed_id, title, content);
    if(result.affectedRows > 0) {
        ctx.body = { result: "succes", id: feed_id }
    } else {
        ctx.body = { result: "fail", }
    }
}

// 피드 삭제
exports.delete = async (ctx, next) => {
    let feed_id = ctx.params.id;

    let result = await feedDelete(feed_id);
    if(result.affectedRows > 0) {
        ctx.body = { result: "succes", id: feed_id }
    } else {
        ctx.body = { result: "fail", }
    }
}

/**
 * 토큰으로 사용자 이메일 반환
 * @param {string} token jwt 토큰
 * @returns {string} 사용자 email
 */
let TokenToEmail = (token) => {
    return new Promise((resolve, reject) => {
        jwt.verify(token, process.env.APP_KEY, (error, payload) => {
            (error) ? reject(error) : resolve(payload);
        })
    })
}
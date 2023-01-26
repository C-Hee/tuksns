const jwt = require('jsonwebtoken');
const { feedFullView, feedTypeView, feedCreate, feedShow,feedUpdate, feedDelete, findIdName, findFeedUser, findFeedImage} = require('./query');
const { isNewFeed } = require('../../common/formatter/date');
const { dateFromNow } = require('../../common/formatter/date');

// 전체 피드 보기
exports.index = async (ctx, next) => {
    let query = await feedFullView();
    ctx.body = query;
}

// 주제별 피드 보기
exports.typeIndex = async (ctx, next) => {
    let feed_type = ctx.params.type;
    let query = await feedTypeView();
    ctx.body = query;
}

// 새 피드 작성 처리
exports.store = async (ctx, next) => {
    let user = ctx.request.user;

    let feed_type = ctx.params.type;
    let { title, image_id, content } = ctx.request.body;

    let result = await feedCreate(feed_type, user.id, query.name, title, content, image_id);
    if(result == null){
        ctx.body = {result: "ok"};
    } else {
        ctx.body = {result: "fail"};
    }
}

// 피드 상세보기
exports.show = async (ctx, next) => {
    let id = ctx.params.id;
    let user = ctx.request.user;    // middleware 수정한 코드를 바탕으로 사용 가능 41~43
    let item = await feedShow(id);
    item['is_me'] = (user.id === item.user_id); // 내 글 조회 -> 내 글이면 true, 아니면 false

    ctx.body = item;
}

// 피드 수정
exports.update = async (ctx, next) =>{
    let user = ctx.request.user;

    // 피드의 id로 피드 작성자의 id를 구함
    let feed_id = ctx.params.id;
    let feedUser_id = await findFeedUser(feed_id);

    if(user.id == feedUser_id.user_id){
        let { title, content } = ctx.request.body;
        let result = await feedUpdate(feed_id, title, content);
        if(result == null){
            ctx.body = {result: "fail"};
        } else {
            ctx.body = {result: "ok"};
        }
    }
}

// 피드 삭제
exports.delete = async (ctx, next) => {
    let user = ctx.request.user;

    // 피드의 id로 피드 작성자의 id를 구함
    let feed_id = ctx.params.id;
    let feedUser_id = await findFeedUser(feed_id);

    if(user.id == feedUser_id.user_id){
        let result = await feedDelete(feed_id);
        if(result == null){
            ctx.body = {result: "fail"};
        } else {
            ctx.body = {result: "ok"};
        }
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
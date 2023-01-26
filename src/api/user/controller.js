const jwt = require("jsonwebtoken");
const { register, login, info, find } = require('./query');
const { emailCheck, passwordCheck } = require('../../common/validator/auth');

const crypto = require('crypto');

/** 해당 id의 상세 회원정보 */
exports.info = async (ctx, next) => {
    let id = ctx.params.id;
    let query = await info(id);
    ctx.body = query;
}

/** 회원 가입 */
exports.register = async (ctx, next) => {
    let { email, password, name} = ctx.request.body;

    if (!emailCheck(email)){
        ctx.statuc = 400;
        ctx.body = {result: "fail", message: `이메일 형식에 맞지 않습니다.`};
        return;
    }

    if (!passwordCheck(password)){
        ctx.statuc = 400;
        ctx.body = {result: "fail", message: `비밀번호 형식에 맞지 않습니다.`};
        return;
    }

    let { count } = await find(email);
    if ( count > 0) {
        ctx.status = 400;
        ctx.body = {result: "fail", message: '중복된 이메일이 존재합니다.'};
        return;
    }

    let result = await crypto.pbkdf2Sync(password, process.env.APP_KEY, 50, 100, 'sha512');  // 50회 반복, 최대 산출물의 길이 255, sha512 방식으로 암호화

    let { affectedRows, insertId } = await register(email, result.toString('base64'), name);  // base64 방식으로 암호화 후 회원가입

    if(affectedRows > 0){
        let token = await generteToken({ name, id: insertId });
        ctx.body = {result: "success", token: token};
    } else {
        ctx.body = {result: "fail", message: '서버 오류'};
    }
}

/** 로그인 */
exports.login = async (ctx, next) => {

    let { email, password } = ctx.request.body;
    let result = await crypto.pbkdf2Sync(password, process.env.APP_KEY, 50, 100, 'sha512');   // 너무 길이 100으로 줄임

    let item = await login(email, result.toString('base64'));

    if(item == null) {
        ctx.body = {result: "fail", message: '서버 오류'};
    } else {
        let token = await generteToken({ name: item.name, id: item.id });
        ctx.body = {result: "success", token: token};
    }
}

/**
 * jwt 토큰 생성
 * @param {object} payload 추가적으로 저장할 payload
 * @returns {string} jwt 토큰 string
 */
let generteToken = (payload) => {
    return new Promise((resolve, reject) => {
        jwt.sign(payload, process.env.APP_KEY, (error, token) => {
            // if(error) { reject(error); }
            // resolve(token);
            (error) ? reject(error) : resolve(token);
        })
    })
}
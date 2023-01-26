require('dotenv').config();
const Koa = require('koa');
const Router = require('@koa/router');
const bodyParser = require('koa-bodyparser');
const app = new Koa();
const path = require('path');
const router = new Router();

// 서버 실행 포트. 환경 변수 PORT를 사용하거나 값이 없으면 3000포트를 사용
const port = process.env.PORT || 3000;

// 바디파서 세팅 (http request의 body 부분을 활용할 수 있도록 해줌)
app.use(bodyParser({formLimit: '5mb'}));

// 라우터 설정
router.use(require('./src/routers').routes());
app.use(router.routes());
app.use(router.allowedMethods());

// 서버 실행
app.listen(port, () => {
    console.log(`웹서버 구동... ${port}`);
})
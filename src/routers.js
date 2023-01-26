const Router = require('@koa/router');
const router = new Router();
const multer = require('@koa/multer');
const path = require('path');
const upload = multer({
    dest: path.resolve(__dirname, '../', 'storage')
})

const { myLogging } = require('./middleware/logging');
const { verify } = require('./middleware/auth');

const webController = require('./web/controller');
const apiUserController = require('./api/user/controller');
const apiFeedController = require('./api/feed/controller');
const apiCommentController = require('./api/comment/controller');

router.use(myLogging);

// 이미지 업로드, 다운로드
router.post('/file/upload', upload.single('file'), require('./api/file/controller').upload);
router.get('/file/:id', require('./api/file/controller').download);

// 메인 페이지
router.get('/', webController.home);
router.get('/page/:name', webController.page);

// 회원가입, 로그인
router.post('/api/user/login', apiUserController.login);
router.post('/api/user/register', apiUserController.register);

// 전체 피드
router.get('/api/feed', apiFeedController.index);
// 주제별 게시판 피드
router.get('/api/feed/:type', apiFeedController.typeIndex);
// 피드 상세보기
router.get('/api/feed/:type/:id', apiFeedController.show);
// 댓글 상세보기
router.get('/api/feed/:type/:id/comment', apiCommentController.show);

// 로그인 확인
router.use(verify);

// 회원 상세정보
router.get('/api/user/:id', apiUserController.info);

// 피드 작성, 수정, 삭제
router.post('/api/feed/:type', apiFeedController.store);
router.put('/api/feed/:type/:id', apiFeedController.update);
router.delete('/api/feed/:type/:id', apiFeedController.delete);

// 댓글 작성, 수정, 삭제
router.post('/api/feed/:type/:id/comment', apiCommentController.store);
router.put('/api/feed/:type/:id/comment/:comment_id', apiCommentController.update);
router.delete('/api/feed/:type/:id/comment/:comment_id', apiCommentController.delete);

module.exports = router;
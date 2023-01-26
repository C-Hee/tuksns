const { create, show } = require('./query');
const fs = require('fs');

// 파일 업로드
exports.upload = async (ctx) => {
    let file = ctx.request.file;
    let { affectedRows, insertId } = await create(file.originalname, file.path, file.size);

    if(affectedRows > 0){
        ctx.body = {
            result: "success",
            id: insertId
        }
    } else {
        ctx.body = {
            result: "fail",
        }
    }
}

// 해당하는 이름으로 파일을 만들어줌
exports.download = async ctx => {
    let { id } = ctx.params;

    let item = await show(id);

    if(item == null) {
        ctx.body = {result: "fall"};
        return;
    }

    ctx.response.set("content-disposition", `attachment; filename=${item.original_name}`);
    ctx.statusCode = 200;
    ctx.body = fs.createReadStream(item.file_path);
}
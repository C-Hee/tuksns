// 사이트 메인 페이지
exports.home = (ctx, next) => {
    ctx.body = "Hello World";
}

// 약관, 개인정보처리방침 등 정적, 정보성 페이지
exports.page = async (ctx, next) => {
    let { name } = ctx.params;

    let pagename = ctx.params.name;
    let content;
    switch (pagename) {
        case 'terms':
            content = "이용약관";
            pagename = content;
            break;
        case 'policy':
            content = "개인정보 처리방침";
            pagename = content;
            break;
    }

    await ctx.render('index' , { pagename : pagename });
}
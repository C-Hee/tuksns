/**
 * 아매알 유효성 검사
 * @param {string} email 회원가입할 이메일
 * @returns 이메일 유효성 검사 결과
 */
exports.emailCheck = email => {
    var emailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (emailformat.test(email)) {
        return true;
    } else {
        return false;
    }
}

/**
 * 비밀번호 유효성 검사 숫자와 영문자 조합으로 8~16자리
 * @param {string} password 회원가입할 비밀번호
 * @returns 비밀번호 유효성 검사 결과
 */
exports.passwordCheck = password => {
    var pwformat = /^[a-zA-Z0-9]{8,16}$/;
    if (pwformat.test(password)) {
        return true;
    } else {
        return false;
    }
}
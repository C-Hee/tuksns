const { pool } = require('../../data');

/**
 * 피드의 모든 댓글을 가져오는 함수
 * @param {number} feed_id 피드의 id
 * @returns 
 */
exports.commentShow = async (feed_id) => {
    const query = `SELECT * FROM comment WHERE
    feed_id = ?`;
    let result = await pool(query, [feed_id]);
    return (result.length < 0) ? null : result[0];
}

/**
 * 작성된 댓글을 데이터베이스에 저장하는 함수 대댓글 있음
 * @param {number} user_id 댓글 작성자의 id
 * @param {number} feed_id 댓글이 작성된 피드의 id
 * @param {string} content 댓글 내용
 * @param {number} sort 댓글 정렬 순서
 * @param {number} cmtgroup 댓글의 최종 부모
 * @returns 
 */
// exports.commentCreate = async (user_id, feed_id, content, sort, cmtgroup) => {
//     const query = `INSERT INTO comment
//     (user_id, feed_id, content, sort, cmtgroup)
//     VALUES (?,?,?,?,?,?)`;
//     return await pool(query, [user_id, feed_id, content, sort, cmtgroup]);
// }


/**
 * 작성된 댓글을 데이터베이스에 저장하는 함수 대댓글 없음
 * @param {number} user_id 댓글 작성자의 id
 * @param {string} user_name 댓글 작성자의 name
 * @param {number} feed_id 댓글이 작성된 피드의 id
 * @param {string} content 댓글 내용
 * @returns 
 */
exports.commentCreate = async (user_id, user_name, feed_id, content) => {
    const query = `INSERT INTO comment
    (user_id, user_name, feed_id, content)
    VALUES (?,?,?,?)`;
    return await pool(query, [user_id, user_name, feed_id, content]);
}

/**
 * 댓글의 내용을 수정하는 함수
 * @param {number} comment_id 수정할 댓글의 id
 * @param {string} content 댓글의 수정한 내용
 * @returns 
 */
exports.commentUpdate = async (comment_id, content) => {
    const query = `UPDATE comment content = ? WHERE id = ?`;
    return await pool(query, [content, comment_id]);
}

/**
 * 댓글을 삭제하는 함수
 * @param {number} comment_id 삭제할 댓글의 id
 * @returns 
 */
exports.commentDelete = async (comment_id) => {
    const query = `DELETE FROM comment WHERE id = ?`;
    return await pool(query, [comment_id]);
}

/**
 * 댓글의 id로 댓글의 정보를 가져오는 함수
 * @param {number} comment_id 댓글 id
 * @returns 
 */
exports.commentInfo = async (comment_id) => {
    const query = `SELECT * FROM comment WHERE id = ?`;
    let result = await pool(query, [comment_id]);
    return (result.length < 0) ? null : result[0];
}

/**
 * 가장 높은 cmtgroup 값을 가져오는 함수
 * @returns 가장 높은 cmtgroup 값
 */
exports.MaxCmtgroup = async () => {
    const query = `SELECT cmtgroup FROM comment ORDER BY cmtgroup DESC`;
    let result = await pool(query);
    return (result.length < 0) ? null : result[0];
}

/**
 * 댓글의 대댓글 순서 중 가장 높은 값을 가져오는 함수
 * @param {number} cmtgroup 대댓글의 부모 댓글의 그룹
 */
exports.MaxSort = async (cmtgroup) => {
    const query = `SELECT sort FROM comment WHERE cmtgroup = ? AND sort = (SELECT MAX(sort) FROM comment)`;
    let result = await pool(query, [cmtgroup]);
    return (result.length < 0) ? null : result[0];
}
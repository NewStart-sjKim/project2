package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Board;

public interface BoardMapper {

	@Select("select ifnull(max(board_num),0) from board")
	int maxNum();
	
	@Insert("insert into board (board_num,user_id,board_title,board_content,board_readcnt,board_id,board_date)"
			 + " values (#{board_num},#{user_id},#{board_title},#{board_content},0,#{board_id},now())")
	void insert(Board board);
	
	//건의사항 전체 게시글 건수
	@Select({"<script>",
		"select count(*) from board where board_id=#{board_id} ",
		"<if test='searchtype != null'> and ${searchtype} like '%${searchcontent}%'</if>",
		"</script>"})
	int boardCount(Map<String, Object> param);

	
	@Select({"<script>",
		"select * from board",
		"<if test='board_num != null'> where board_num = ${board_num}</if>",
		"<if test='board_id != null'> where board_id = ${board_id}</if>",
		"<if test='searchtype != null'> and ${searchtype} like '%${searchcontent}%'</if>",
		"<if test='limit != null'> order by board_num desc</if>",
		"</script>"})
	List<Board> select(Map<String, Object> param);
	
	@Select("select * from board where board_num=#{board_num}")
	Board getBoard(Integer board_num);

	
	@Update("update board set board_readcnt = board_readcnt + 1 where board_num=#{board_num}")
	void addReadcnt(Integer board_num);
	
	
	@Delete("delete from board where board_num = #{board_num}")
	void deleteBoard(int board_num);
	
	

}
package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import dto.User;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<UserMapper> cls = UserMapper.class;

	public void insert(User user) {
		template.getMapper(cls).insert(user);

	}

	public User selectOne(String user_id) {
		param.clear();
		param.put("user_id", user_id);
		return template.getMapper(cls).selectOne(param);
	}

	public void update(User user) {
		template.getMapper(cls).update(user);

	}

	public User idSearch(String user_email) {
		param.clear();
		param.put("user_email", user_email);
		return template.getMapper(cls).idSearch(param);
	}

	public User idEmailSearch(String email, String user_id) {
		param.clear();
		param.put("user_email", email);
		param.put("user_id", user_id);
		return template.getMapper(cls).idEmailSearch(param);
	}

	public void chgpass(String user_id, String chgpass) {
		param.clear();
		param.put("user_id", user_id);
		param.put("user_pass", chgpass);
		template.getMapper(cls).chgpass(param);
	}

	public void delete(String user_id) {
		param.clear();
		param.put("user_id", user_id);
		template.getMapper(cls).delete(param);
	}

	public User checkId(String user_id) {
		param.clear();
		param.put("user_id", user_id);
		return template.getMapper(cls).checkId(param);
	}

	public List<User> list() {
		return template.getMapper(cls).list();
	}

	public void avgUpdate(String vi_id, int vi_avg) {
		param.clear();
		param.put("user_id", vi_id);
		param.put("user_avg", vi_avg);
		template.getMapper(cls).avgUpdate(param);
		
	}

	public User getUser(String user_id) {
		return template.getMapper(cls).getUser(user_id);
	}
}
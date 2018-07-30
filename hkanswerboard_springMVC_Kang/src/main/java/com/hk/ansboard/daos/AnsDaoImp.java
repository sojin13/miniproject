package com.hk.ansboard.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.ansboard.dtos.AnsDto;

@Repository
public class AnsDaoImp implements IAnsDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	private String namespace="com.hk.ansboard.";
	
	@Override
	public List<AnsDto> getAllList() {
		return sqlSession.selectList(namespace+"boardlist");
	}

	@Override	
	public AnsDto getBoard(int seq) {		
	      Map<String, Integer> map=new HashMap<>();
	      map.put("seq",seq);
	      return sqlSession.selectOne(namespace+"boardlist",map);
	}

	@Override
	public boolean updateBoard(AnsDto dto) {		
		int count=0;
		count=sqlSession.update(namespace+"updateboard", dto);		
		return count>0?true:false;
	}

	@Override
	public boolean insertBoard(AnsDto dto) {		
		int count=0;
		count=sqlSession.insert(namespace+"insertboard", dto);		
		return count>0?true:false;
	}

	@Override
	public boolean mulDelboard(String[] seq) {
		Map<String, String[]> map=new HashMap<>();
	    map.put("seqs", seq);
	    int count=sqlSession.update(namespace+"muldelboard", map);

		return count>0?true:false;
	}

	@Override
	public int replyBoardUpdate(AnsDto dto) {
		return sqlSession.update(namespace+"ansupdate", dto);
		
	}

	@Override
	public int replyBoardInsert(AnsDto dto) {
		
		return sqlSession.insert(namespace+"ansinsert", dto);
	}

	@Override
	public boolean readCount(int seq) {
		int count=0;
		count=sqlSession.update(namespace+"readcount", seq);
		return count>0?true:false;
	}

	@Override
	public AnsDto getBoardAjax(int seq) {		
		return sqlSession.selectOne(namespace+"detailAjax", seq);
	}

}

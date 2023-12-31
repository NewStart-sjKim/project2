package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dto.BmService;
import dto.Game;
import dto.GameService;
import dto.Gamer;
import dto.User;
import exception.LoginException;

@Controller
@RequestMapping("game")
public class GameController {
    @Autowired
	private GameService service;
    @Autowired
    private BmService bmservice;

	@GetMapping("*")
	public ModelAndView write() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Game());
		return mav;
	}
	
	
	@PostMapping("write") 
	public ModelAndView writePost(@Valid Game game, BindingResult bresult, HttpServletRequest request) {
		  ModelAndView mav = new ModelAndView();
		  //작성할 때 로그인이 되어있는지 확인합니다.
		  if(bresult.hasErrors()) {
			  System.out.println("inputcheck:"+ bresult.getModel());
			  mav.getModel().putAll(bresult.getModel());
			  return mav; 
		}
		  System.out.println(game);
		  //확인이 되었으면 db에 저장 후 게임 리스트로 이동합니다
		  int game_num = service.gameInsert(game);
		  service.gamerInsert(game.getUser_id(),game_num);
		  mav.addObject("message","작성이 완료 되었습니다.");
			mav.addObject("url","gamelist");
			mav.setViewName("alert");

	  return mav; 
	}
	
	@GetMapping("write")
	public ModelAndView writeGet(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//로그인 정보를 가져오기위해 session 정보를 가져와서 user_id로 저장합니다.
		String user_id = (String)session.getAttribute("login");
		System.out.println(user_id);
		Game g = new Game();
		//dto에 있는 게임클래스를 가져와서 
		g.setUser_id(user_id);
		mav.addObject("game",g);
		return mav;
	}
	
	@RequestMapping("gamelist")
	public ModelAndView gamelist(@RequestParam Map<String,String> param, HttpSession session) {
		Integer pageNum = null;
		String searchtype = param.get("searchtype");
		String searchcontent = param.get("searchcontent");
		String sort = param.get("sort");
		if(param.get("pageNum") != null) pageNum = Integer.parseInt(param.get("pageNum"));
		if(searchtype==null || searchcontent == null || searchtype.trim().equals("") || searchcontent.trim().equals("")) {
			searchtype=null;
			searchcontent=null;
		}
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(sort == null || sort.equals("")) sort=null;
		int limit = 10;
		int listCount = service.gameCount(searchtype,searchcontent);
		System.out.println(listCount);
		List<Game> gamelist = service.gameList();
		List<Game> gamepage = service.gamepage(pageNum,limit,searchtype,searchcontent);
		for(Game g : gamepage) {
			User user = bmservice.getUser(g.getUser_id());
			if(user == null) {
				g.setUser_id("탈퇴한 회원");
			}
		}
		int maxpage = (int)((double)listCount/limit + 0.95);
		int startpage = (int)((pageNum/10.0 + 0.9) -1) * 10 + 1;
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int game_num = listCount - (pageNum - 1) * limit;
		System.out.println("st : " + searchtype);
		System.out.println("sc : " + searchcontent);
		System.out.println(listCount);
		mav.addObject("game_num",game_num);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listCount",listCount);
		mav.addObject("gamepage",gamepage);
		mav.addObject("gamelist",gamelist);
		return mav;
	}
	@RequestMapping("gameinfo")
	public ModelAndView getgameinfo(Integer game_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Game game = service.getGame(game_num);
		if(game ==  null) {
			throw new LoginException("없는 게임입니다.", "gamelist");
		}
		String userid = game.getUser_id();
		User user = bmservice.getUser(userid);
		if(user == null) {
			throw new LoginException("탈퇴한 회원의 매치입니다.","gamelist");
		}
		mav.addObject("game",game);
		return mav;
	}
	@RequestMapping("apply")
	public ModelAndView apply( Integer game_num, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser"); //로그인 되어있는 유저의 모든 정보		
		Game game = service.getGame(game_num);
		if(game == null) {
			throw new LoginException("없는 게임 번호입니다.","gamelist");
		}
		String game_userid = game.getUser_id();
		User dbuser = bmservice.getUser(game_userid);
		if(dbuser == null) {
			throw new LoginException("탈퇴한 회원의 매치입니다. 신청 불가합니다.","gamelist");
		}
		Gamer gamer = service.getGamer(user.getUser_id(),game_num);
		int userAge = user.getUser_age();  // 유저의 나이
		int gameAge = game.getGame_age();  // 게임의 제한 나이
		int userAvg = user.getUser_avg();  // 유저의 에버리지
	    int gameAvg = game.getGame_avg();  // 게임의 에버리지
	    int gamePeople = game.getGame_people(); //게임의 신천인원수
	    int gameMax = game.getGame_max();  // 게임에서 설정한 제한 인원수
	    
		//유저의 나이가 게임나이보다 작거나 게임의 나이에서 9를 초과하면서 유저나이가 다른 경유에 예외경우 발생
		if (userAge < gameAge || userAge > (gameAge + 9)) {
		    if (userAge != gameAge) {
		        throw new LoginException("나이제한을 확인해주세요.", "gameinfo?game_num=" + game_num);
		    }
		}
		if(!game.getGame_gender().equals("성별무관") && !user.getUser_gender().equals(game.getGame_gender())) {
			throw new LoginException("성별 맞지않습니다.","gameinfo?game_num="+game_num);
		}
		if (userAvg < gameAvg - 15 || userAvg > gameAvg + 15) {
		    throw new LoginException("에버리지가 맞지않습니다.", "gameinfo?game_num=" + game_num);
		}
		if(gamePeople == gameMax) {
			throw new LoginException("신청인원이 마감 되었습니다.", "gameinfo?game_num=" + game_num);
		}
		if(gamer != null){
			throw new LoginException(" 이미 신청 되었습니다.", "gameinfo?game_num=" + game_num);
		}
		
		service.gamerInsert(user.getUser_id(),game_num);
		service.gameupdate(user.getUser_id(),game_num);
		
		mav.addObject("game",game);
		mav.addObject("message","신청이 완료 되었습니다.");
		mav.addObject("url","gameinfo?game_num="+game_num);
		mav.setViewName("alert");
		return mav;
	}
	@GetMapping("update")
	public ModelAndView idgetupdate(Integer game_num,String userid,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser"); //로그인 되어있는 유저의 모든 정보
		
		Game game = service.getGame(game_num);
		
		if(game == null) {
			throw new LoginException("없는 게임 번호입니다.","gamelist");
		}
		if(!game.getUser_id().equals(userid)) {
			throw new LoginException("본인만 수정 가능합니다.","gamelist");
		}
		List<Gamer> gamerlist = service.getGamer(game_num);
		if(gamerlist.size() >= 2 ) {
			throw new LoginException(" 이미 참여인원 있어서 수정이 불가합니다.", "gameinfo?game_num=" + game_num);
		}
		mav.addObject("game",game);
		return mav;
	}
	
	@PostMapping("update")
	public ModelAndView postupdate(@Valid Game game, BindingResult bresult ,Integer game_num) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			  System.out.println("inputcheck:"+ bresult.getModel());
			  mav.getModel().putAll(bresult.getModel());
			  return mav; 
		}
			service.gameupdate(game,game_num);
			  mav.addObject("message","수정이 완료 되었습니다.");
				mav.addObject("url","gamelist");
				mav.setViewName("alert");
			return mav;
	}
	/*
	 * @PostMapping("gameinfo") public ModelAndView postgameinfo(HttpSession
	 * session) { ModelAndView mav = new ModelAndView(); String user_id =
	 * (String)session.getAttribute("login"); service.gameupdate(user_id); return
	 * mav; }
	 */
}

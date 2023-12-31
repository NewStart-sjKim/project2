package dto;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("mss")
public class MailSendService {
	@Autowired
	private JavaMailSenderImpl mailSender;

//=================================================메일 인증 메서드 시작	
	private int authNumber;

	public void makeRandomNumber() {
		// 난수의 범위 111111 ~ 999999 (6자리 난수)
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
	public void mailSend(String setFrom, String toMail, String title, String content) throws UnsupportedEncodingException, MessagingException {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom,"볼링매니아 관리자");
			helper.setTo(toMail);
			helper.setSubject(title);
			// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
			helper.setText(content, true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

//=======================================메일 인증 메서드 끝	
	public String joinEmail(String user_email) throws UnsupportedEncodingException, MessagingException { // 메일인증
		makeRandomNumber();
		String setFrom = "mik3533@naver.com";
		String toMail = user_email;
		String title = "회원 가입 인증 이메일 입니다."; // 이메일 제목
		String content = "볼링매니아를 방문해주셔서 감사합니다." +
		        "<br><br>" + "인증 번호는 <span style=\"color:green\"><strong>"
				+ authNumber + "</strong></span>입니다." + "<br>" + "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}
	public String idSearchEmail(String user_email) throws UnsupportedEncodingException, MessagingException {
		makeRandomNumber();
		String setFrom = "mik3533@naver.com";
		String toMail = user_email;
		String title = "아이디 찾기 인증 이메일 입니다."; // 이메일 제목
		String content = "인증 번호는 <span style=\"color:green\"><strong>"
				+ authNumber + "</strong></span>입니다." + "<br>" + "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}

	public String pwSearchEmail(String email) throws UnsupportedEncodingException, MessagingException {
		makeRandomNumber();
		String setFrom = "mik3533@naver.com";
		String toMail = email;
		String title = "비밀번호 찾기 인증 이메일 입니다."; // 이메일 제목
		String content = "인증 번호는 <span style=\"color:green\"><strong>" + authNumber + "</strong></span>입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}
}

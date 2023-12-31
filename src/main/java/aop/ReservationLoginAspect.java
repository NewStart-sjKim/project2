package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import dto.User;
import exception.LoginException;

@Component
@Aspect
public class ReservationLoginAspect {
	@Around
	("execution(* controller.ReservationController*.reserv*(..)) && args(..,session)")
	public Object rvloginCheck(ProceedingJoinPoint joinPoint,
			HttpSession session) throws Throwable {
	   User loginUser = (User)session.getAttribute("loginUser");	
	   if(loginUser == null) {
				throw new LoginException("로그인이 필요합니다.", "../user/login");
	   }
	   return joinPoint.proceed();	
	}

}

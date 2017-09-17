package net.mwav.common.module;

import java.util.Map;

import javax.annotation.Resource;
import javax.mail.internet.InternetAddress;

import org.apache.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import net.common.common.CommandMap;
import net.mwav.member.service.MemberService;

//http://answerofgod.tistory.com/entry/SPRING-EMAIL-%EB%B3%B4%EB%82%B4%EA%B8%B0-%EA%B8%B0%EB%8A%A5%EB%B9%84%EB%B2%88%EC%B0%BE%EA%B8%B0%EB%A9%94%EC%9D%BC
//http://gangzzang.tistory.com/132
//http://evilimp.tistory.com/10

//https://support.google.com/mail/answer/13287?hl=en (구글)
//http://examples.javacodegeeks.com/enterprise-java/spring/mail-spring/spring-e-mail-support-gmail-smtp-server-example/

//https://myaccount.google.com/lesssecureapps?rfn=27&rfnc=1&et=0&asae=2&pli=1
//@Controller
@Service
public class EmailSender {

	// 기존의 autowired로 빈등록은 <context:component-scan
	// base-package="net"></context:component-scan>
	// 했으니 패스

	// @중요 Autowired는 빈등록하는 것으로 등록되어있는 빈 id 랑 일치해야 한다 !!
	// -> 그러면 빈을 여기저기 공유하게끔 해주는 역활을 한다.
	// -> 근데 그냥 만약 sendEmialAction을 호출하면 null 에러난다.
	// -> memberController 에 이 클래스 자체를 빈 지정하고 거기서 autowire로 사용한다.

	@Autowired
	private EmailTemplates emailTemplates;
	private EmailVO email = new EmailVO();

	// private static Logger log = Logger.getLogger("sendMail");

	// @RequestMapping("/main/sendpw.mwav")
	public void sendEmailAction(CommandMap commandMap) throws Exception {

		// ModelAndView mv = new ModelAndView("/Index");
		// String id = (String) commandMap.get("id");
		String mbrEmail = (String) commandMap.get("mbrEmail");
		String mbrTempLoginPw = (String) commandMap.get("mbrTempLoginPw");
		String mbrLoginId = (String) commandMap.get("mbrLoginId");

		// log.debug("메일");
		email.setContent("비밀번호는 " + mbrTempLoginPw + " 입니다.");
		email.setReceiver(mbrEmail);
		email.setSubject("Mwav 홈페이지 " + mbrLoginId + "님 [임시비밀번호]찾기 메일입니다.");
		emailTemplates.sendBasicEmail(email);
		// String pw = memberService.getPw(commandMap);
		// System.out.println(pw);
		/*
		 * if (pw != null) { email.setContent("비밀번호는 " + pw + " 입니다.");
		 * email.setReceiver(e_mail); email.setSubject(id + "님 비밀번호 찾기 메일입니다.");
		 * emailSender.SendEmail(email); mav = new
		 * ModelAndView("redirect:/login.mwav"); return mav; } else { mav = new
		 * ModelAndView("redirect:/logout.mwav"); return mav; }
		 */
		// return mv;
	}

	public void sendRegistrationEmail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

		email.setHtmlYn("Y"); // html 형식으로 세팅
		email.setFrom("webmaster@mwav.net"); // from
		email.setReceiver((String) map.get("mbrEmail")); // 받는사람:가입유저
		email.setSubject("[Mwav]" + (String) map.get("mbrLoginId")
				+ "님, 회원가입을 환영합니다."); // 메일 제목 properties 파일 참조
		email.setVeloTemplate("GeneralMail/GeneralMail_Registration.vm"); // 템플릿 파일명
		email.setEmailMap(map);

		// 이메일 전송 로그
		email.setRegUsr("0");
		
		
		emailTemplates.sendVelocityEmail(email); // 메일 전송
	}
	
	public void sendQuestionEmail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		email.setHtmlYn("Y"); // html 형식으로 세팅
		email.setFrom("webmaster@mwav.net"); // from
		email.setReceiver((String) map.get("uqUserEmail")); // 받는사람:가입유저
		email.setSubject("[접수]_"+(String) map.get("uqUserName")
				+ "님 문의해주신 내용이 정상 접수 되었습니다."); // 메일 제목 properties 파일 참조
		email.setVeloTemplate("QnAnswer/Question.vm"); // 템플릿 파일명
		email.setEmailMap(map);

		// 이메일 전송 로그
		email.setRegUsr("0");
		
		
		emailTemplates.sendVelocityEmail(email); // 메일 전송
	}
}
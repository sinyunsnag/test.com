/*
 * Copyright 2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package net.mwav.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.mwav.member.service.MemberService;
import net.mwav.member.vo.Member_tbl_VO;

import org.apache.log4j.Logger;
import org.apache.maven.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.ExpiredAuthorizationException;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.web.ProviderSignInUtils;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.User;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.WebRequest;

@Controller
public class SignController {
	Logger logger = Logger.getLogger(this.getClass());
	private final ProviderSignInUtils providerSignInUtils;

	private Facebook facebook;
	@Autowired
	Member_tbl_VO member_tbl_VO;

	@Resource(name = "memberService")
	private MemberService memberService;

	@Inject
	public SignController(ConnectionFactoryLocator connectionFactoryLocator,
			UsersConnectionRepository connectionRepository) {
		this.providerSignInUtils = new ProviderSignInUtils(
				connectionFactoryLocator, connectionRepository);
	}

	@RequestMapping(value = "/signin", method = {RequestMethod.GET, RequestMethod.POST})
	public void signin() {
		System.out.println("출력3");
	}

	@RequestMapping("/google/expired")
	public void simulateExpiredToken() { // 만료된 토큰 관리
		throw new ExpiredAuthorizationException("google");
	}

	@RequestMapping(value = "/signup.mwav", method = {RequestMethod.GET, RequestMethod.POST})
	public String signupForm2(WebRequest req, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		Connection<?> connection = providerSignInUtils
				.getConnectionFromSession(req);
		
		int loginCheck = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = request.getSession();

		/*
		 * API 마다 메소드가 다르기때문에 이부분은 체크 필요.
		 * http://docs.spring.io/spring-social/docs
		 * /1.0.3.RELEASE/api/org/springframework
		 * /social/connect/Connection.html#fetchUserProfile()
		 */
		String social = connection.getKey().getProviderId();
		String smMember_id = null;
		String First_Name = null;
		String Last_Name = null;
		String Email = null;
		String Gender = null;
		String Link = null;
		String Picture = null;
		System.out.println("뭔소셜이냐" + social);

		if (social.equals("facebook")) {
			facebook = (Facebook) connection.getApi();
			String[] fields = { "id", "email", "first_name", "last_name",
					"gender", "birthday", "link" };
			/*
			 * System.out.println("이건뭘까" +
			 * facebook.userOperations().getUserProfile());
			 */
			User user = facebook.fetchObject("me", User.class, fields);

			// (#12) bio field is deprecated for versions v2.8 and higher
			// fetchUserProfile
			smMember_id = connection.getKey().getProviderUserId();
			First_Name = user.getFirstName();
			Last_Name = user.getLastName();
			Email = user.getEmail();
			Gender = user.getGender();
			Link = user.getLink();
		} else {

			smMember_id = connection.getKey().getProviderUserId();
			First_Name = connection.fetchUserProfile().getFirstName();
			Last_Name = connection.fetchUserProfile().getLastName();
			Email = connection.fetchUserProfile().getEmail();
			if (Last_Name == null) {
				Last_Name = null;
			}
			Gender = null;
			Link = connection.getProfileUrl();
			if (Link == null) {
				Link = null;
			}
			Picture = connection.getImageUrl();
			if (Picture == null) {
				Picture = null;
			}
		}
		logger.debug("smMember_id = " + smMember_id);
		logger.debug("First_Name = " + First_Name);
		logger.debug("Last_Name = " + Last_Name);
		logger.debug("Email = " + Email);
		logger.debug("Gender = " + Gender);
		logger.debug("Link = " + Link);
		logger.debug("Picture = " + Picture);

		/*
		 * ID가 없으면 (Insert), 있으면 (로그인)
		 */
		System.out.println("smMember_id" + smMember_id);
		boolean check;
		int member_id = 0;
		String m_id = null;
		check = memberService.selectOneSnsMbrLoginIdCheck(smMember_id);
		
		logger.info("check = " + check);
		if (check == false) { // 기존에 등록 아이디가 존재하지 않는 경우

			m_id = memberService.selectOneMemberPkCheck();
			member_id = Integer.parseInt(m_id);
			System.out.println("멤버아이디=" + member_id);
			// 메번로그인할때마다 생성하면 애매하니까

			if (First_Name == null) {
				First_Name = "sns_imsi";
			}

			if (Last_Name == null) {
				Last_Name = "sns_imsi";
			}
			if (Email == null) {
				Email = "sns_imsi";
			}
			map.put("member_id", member_id);
			map.put("mbrLoginId", social + "_imsi");
			map.put("mbrLoginPw", "sns_imsi");
			map.put("mbrTempLoginPw", null);
			map.put("mbrFirstName", First_Name);
			map.put("mbrLastName", Last_Name);
			map.put("mbrMiddleNam", "sns_imsi");
			map.put("mbrEmail", Email);
			map.put("mbrCellPhone", "sns_imsi");
			map.put("mbrAddrFlag", 0);
			map.put("mbrZipcode", 123456);
			map.put("mbrAddress", "sns_imsi");

			// 회원가입.
			memberService.insertMbrForm(map);
			
			map.put("smMember_id", smMember_id);
			map.put("First_Name", First_Name);
			map.put("Last_Name", Last_Name);
			map.put("Email", Email);
			map.put("Gender", 3);
			map.put("Link", Link);
			map.put("Picture", Picture);
			map.put("member_id", member_id);
			// sns가입 (*당연히 회원가입이되어야 이게 가능 순서가 당연하지 이게 저기를 외래키로 가리키는데)
			memberService.insertSnsForm(map);
			member_tbl_VO.setMember_id(member_id);
			session.setAttribute("member", member_tbl_VO);
			System.out.println("세션에 있는 값 "+(String)request.getSession().getAttribute("loginCheck"));
			memberService.updateAutoLogin((String)request.getSession().getAttribute("loginCheck"), response, member_tbl_VO.getMember_id());
			logger.info("insertSnsForm success!!!!!!");
		} else {
			// 업데이트 해야하는 요소가 있다면 사실해줘야 한다.
			// 기존 등록된 내용이 있는 경우
			// member_id를 기준으로 불러온다.
			// String m_id = memberService.selectOneMemberPkCheck();
			try {
				m_id = memberService.selectOneSmMemberPkCheck(smMember_id);
				member_id = Integer.parseInt(m_id);
			} catch (NullPointerException e) {
				e.printStackTrace();
			}
			System.out.println("세션에 있는 값 "+ (String)request.getSession().getAttribute("loginCheck"));

			member_tbl_VO.setMember_id(member_id);
			session.setAttribute("member", member_tbl_VO);
			memberService.updateAutoLogin((String)request.getSession().getAttribute("loginCheck"), response, member_tbl_VO.getMember_id());
			
		
		}

		String mbrLoginId = connection.getDisplayName();
		//System.out.println("mbrLoginId___" + mbrLoginId);

		loginCheck = 1;
		// session.setAttribute("member_id", member_id);
		request.setAttribute("loginCheck", loginCheck);
		request.getSession().setAttribute("loginCheck", null);
		return "/Index";
	}

}

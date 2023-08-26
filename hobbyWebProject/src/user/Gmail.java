package user;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		//정책변경으로 일반 비밀번호를 넣으면 인증이 되지 않기 때문에 앱비밀번호를 넣는다.
		return new PasswordAuthentication("o0o7o2o0@gmail.com", "cqwjshkagzfvyxhk");
	}
}


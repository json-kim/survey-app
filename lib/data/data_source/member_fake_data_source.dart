import 'package:survey_app/domain/model/member/member.dart';

class MemberFakeDataSource {
  Future<bool> checkAuth(Member member) async {
    return true;
  }

  Future<bool> signUpMember(Member member) async {
    return true;
  }
}
